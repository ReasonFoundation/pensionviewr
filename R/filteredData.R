#' filteredData filters around 45 columns, starting year, adds missing columns, and populates DR column
#'
#' @param Data data.table or data.frame with pension values (see pullData()/pullStateData())
#' @param fy starting fiscal year
#' @param source TRUE if Data coemes from using pullSourceData() function
#'
#' @return
#' @export
#'
#' @examples
#' \dontrun{
#' filteredData(Data, 2001, FALSE)
#' }
filteredData <- function(Data,fy, source = FALSE){
  columns <- c("total_pension_liability_dollar", "wage_inflation",
             "payroll_growth_assumption", "other_contribution_dollar",
             "other_additions_dollar", "x1_year_investment_return_percentage",
             "amortization_method", "number_of_years_remaining_on_amortization_schedule",
             "fiscal_year_of_contribution", "statutory_payment_dollar",
             "statutory_payment_percentage", "discount_rate_assumption", 
             "multiple_discount_rates", "asset_valuation_method_for_gasb_reporting",
             "cost_structure", "employer_normal_cost_percentage",
             "inflation_rate_assumption_for_gasb_reporting", "total_number_of_members",
             "total_projected_actuarial_required_contribution_percentage_of_payroll")

##Create missing columns for plans with no data for st 7 variable
for (i in (1:length(columns))){
  if(sum((colnames(Data) == columns[i]))==0) {
    Data %>% mutate(columns[i])}
}

if(sum(is.na(Data$discount_rate_assumption))==0){ 
  Data$discount_rate_assumption <- Data$investment_return_assumption_for_gasb_reporting}
####

Data <- Data %>%
  filter(year > fy-1)
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
    asset_valuation_method_for_gasb_reporting,
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
    multidr = multiple_discount_rates,#NEW
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
}