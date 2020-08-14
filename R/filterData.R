#' filterData
#'devtools::document()
#' @param Data data file (in data.frame/data.table format)
#' @param source TRUE/FALSE statement to indicate if "source data" is used
#' @param fy starting year
#' @return A wide data frame with each year as a row and variables as columns.
#' @export
#' @importFrom rlang .data
#' @examples
#' \dontrun{
#' filterData(Data, 2001, source = FALSE)
#' }
filterData <- function(Data, fy, source = FALSE){
  #Create vector with column names to generate NA columns later
  Data <- data.frame(Data)
  
  
  columns <- c("total_pension_liability_dollar", "wage_inflation",
               "payroll_growth_assumption", "other_contribution_dollar",
               "other_additions_dollar", "x1_year_investment_return_percentage",
               "amortizaton_method", "number_of_years_remaining_on_amortization_schedule",
               "fiscal_year_of_contribution", "statutory_payment_dollar",
               "statutory_payment_percentage", "discount_rate_assumption", "cost_structure",
               "employer_normal_cost_percentage", "inflation_rate_assumption_for_gasb_reporting",
               "total_number_of_members", "total_projected_actuarial_required_contribution_percentage_of_payroll"
  )
  
  columns2 <- c("test")
  for (i in (1:length(columns))){
    if(sum(colnames(Data) %in% columns[i])==0) {
      columns2 <- rbind(columns2, columns[i])}
  }
  columns2 <- as.character(columns2 <- columns2[2:length(columns2)])
  cols <- matrix(NA,length(Data[,1]),length(columns2))
  colnames(cols) <- columns2
  Data <- cbind(Data, cols)
  
  ####
  Data <- Data %>% arrange(state, display_name, year)
  Data <- Data %>%
    select(
      year,
      plan_name = display_name,
      state,
      if(isTRUE(source)){"data_source_name"},
      return_1yr = x1_year_investment_return_percentage,
      actuarial_cost_method_in_gasb_reporting,
      funded_ratio = actuarial_funded_ratio_percentage,
      ava = actuarial_value_of_assets_gasb_dollar,
      mva = market_value_of_assets_dollar,
      aal = actuarially_accrued_liabilities_dollar,
      tpl = total_pension_liability_dollar,
      adec = actuarially_required_contribution_dollar,
      adec_paid_pct = actuarially_required_contribution_paid_percentage,
      statutory = statutory_payment_dollar,#NEW
      statutory_pct = statutory_payment_percentage,#NEW
      amortizaton_method,
      total_benefit_payments = total_benefits_paid_dollar,#added
      benefit_payments = benefit_payments_dollar,
      refunds = refunds_dollar,#added
      admin_exp = administrative_expense_dollar,
      cost_structure,
      payroll = covered_payroll_dollar,
      ee_contribution = employee_contribution_dollar,
      ee_nc_pct = employee_normal_cost_percentage,
      er_contribution = employer_contribution_regular_dollar,
      er_nc_pct = employer_normal_cost_percentage,
      er_state_contribution = employer_state_contribution_dollar,
      er_proj_adec_pct = employers_projected_actuarial_required_contribution_percentage_of_payroll,
      other_contribution = other_contribution_dollar,#added
      other_additions = other_additions_dollar,#added
      fy_contribution = fiscal_year_of_contribution,
      inflation_assum = inflation_rate_assumption_for_gasb_reporting,
      arr = investment_return_assumption_for_gasb_reporting,
      dr = discount_rate_assumption,#NEW
      number_of_years_remaining_on_amortization_schedule,
      payroll_growth_assumption,
      total_amortization_payment_pct = total_amortization_payment_percentage,
      total_contribution = total_contribution_dollar,
      total_nc_pct = total_normal_cost_percentage,
      total_number_of_members,
      total_proj_adec_pct = total_projected_actuarial_required_contribution_percentage_of_payroll,
      type_of_employees_covered,
      unfunded_actuarially_accrued_liabilities_dollar,
      wage_inflation
    ) 
  Data %>% filter(year >= fy)
}
