#' Pull State data
#'
#' @param FY Numeric parameter containing a starting fiscal year as it is listed in the Reason pension database.
#' @return A wide data frame with each year as a row and variables as columns.
#' @export
#' @importFrom rlang .data
#' @examples
#' \dontrun{
#' pullStateData(2001)
#' }
pullStateData <- function(FY){
  #dw <- get("dw")
  con <- RPostgres::dbConnect(
    RPostgres::Postgres(),
    dbname = trimws(dw$path),
    host = dw$hostname,
    port = dw$port,
    user = dw$username,
    password = dw$password,
    sslmode = "require"
  )
  
  query <- paste("select * from pull_data_state_only()
where year > '", paste(FY-1), "'
and attribute_name in ('1 Year Investment Return Percentage',
'Actuarial Cost Method in GASB Reporting',
'Actuarial Funded Ratio Percentage',
'Actuarial Value of Assets GASB Dollar',
'Market Value of Assets Dollar',
'Actuarially Accrued Liabilities Dollar',
'Total Pension Liability Dollar',
'Actuarially Required Contribution Dollar',
'Actuarially Required Contribution Paid Percentage',
'Statutory Payment Dollar',
'Statutory Payment Percentage',
'Amortizaton Method',
'Total Benefits Paid Dollar',
'Benefit Payments Dollar',
'Refunds Dollar',
'Administrative Expense Dollar',
'Cost Structure',
'Covered Payroll Dollar',
'Employee Contribution Dollar',
'Employee Normal Cost Percentage',
'Employer Contribution Regular Dollar',
'Employer Normal Cost Dollar',
'Employer State Contribution Dollar',
'Employers Projected Actuarial Required Contribution Percentage of Payroll',
'Other Contribution Dollar',
'Other Additions',
'Fiscal Year Of Contribution',
'Inflation Rate Assumption For GASB Reporting',
'Investment Return Assumption for GASB Reporting',
'Discount Rate Assumption',
'Number of Years Remaining on Amortization Schedule',
'Payroll Growth Assumption',
'Unfunded Actuarially Accrued Liabilities Dollar',
'Total Contribution Dollar',
'Total Normal Cost Percentage',
'Total Number Of Members',
'Total Projected Actuarial Required Contribution Percentage Of Payroll',
'Type of Employees Covered',
'Total Amortization Payment Percentage',
'Wage Inflation')")
  
  result <- RPostgres::dbSendQuery(con, query)
  #RPostgres::dbBind(result, list(1))
  all_data <- RPostgres::dbFetch(result) %>%
    janitor::clean_names()
  RPostgres::dbClearResult(result)
  RPostgres::dbDisconnect(con)
  
  all_data %>%
    dplyr::group_by_at(dplyr::vars(-.data$attribute_value)) %>%  # group by everything other than the value column.
    dplyr::mutate(row_id = 1:dplyr::n()) %>%
    dplyr::ungroup() %>%  # build group index
    tidyr::pivot_wider(names_from = attribute_name, values_from = attribute_value) %>%# CHANGED to pivot
    dplyr::select(-.data$row_id) %>%  # drop the index
    dplyr::arrange(display_name, year) %>%
    janitor::clean_names()
}