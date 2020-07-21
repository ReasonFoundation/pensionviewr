#' Pull all data for state-level pension plans
#' @param state 
#' @param FY 
#'

#' @return A wide data frame with each year as a row and variables as columns.
#' @export
#' @importFrom rlang .data
#' @examples
#' \dontrun{
#' pullStateData(state, 2001)
#' }
pullStateData <- function(state, FY){
  con <- RPostgres::dbConnect(
    RPostgres::Postgres(),
    dbname = "d629vjn37pbl3l",
    host = "ec2-3-209-200-73.compute-1.amazonaws.com",
    port = 5432,
    user = "reason_readonly",
    password = "p88088bd28ea68027ee96c65996f7ea3b56db0e27d7c9928c05edc6c23ef2bc27",
    sslmode = "require")
  
  if(str_count(paste0(state))<6){
    query <- paste("select * from pull_data_state_only()
where year > '", paste(FY-1), "'
and attribute_name in ('1 Year Investment Return Percentage',
'Investment Return Assumption for GASB Reporting',
'Market Value of Assets Dollar',
'Actuarial Value of Assets GASB Dollar',
'Actuarially Accrued Liabilities Dollar',
'Actuarial Funded Ratio Percentage',
'Unfunded Actuarially Accrued Liabilities Dollar',
'Employee Contribution Dollar',
'Employee Normal Cost Percentage',
'Employer Normal Cost Dollar',
'Employer Contribution Regular Dollar',
'Total Contribution Dollar',
'Total Normal Cost Percentage',
'Total Amortization Payment Percentage',
'Covered Payroll Dollar',
'Actuarially Required Contribution Dollar',
'Actuarially Required Contribution Paid Percentage',
'Employers Projected Actuarial Required Contribution Percentage of Payroll',
'Payroll Growth Assumption',
'Type of Employees Covered',
'Total Pension Liability Dollar',
'Amortizaton Method',
'Actuarial Cost Method in GASB Reporting',
'Number of Years Remaining on Amortization Schedule',
'Actuarial Cost Method in GASB Reporting',
'Wage Inflation',
'Total Benefits Paid Dollar')")}else{NULL}
  
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