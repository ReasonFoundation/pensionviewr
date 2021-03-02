#' filterData 
## selects around 50 of the original columns, recreates any of the missing columns, 
## renames column headers for simplicity, and allows to filter plans by type of employees covered
#'
#' @param Data data file (in data.frame/data.table format)
#' @param source TRUE/FALSE statement to indicate if "source data" is used
#' @param fy starting year
#' @param employee character parameter designating filter for type of employees covered (e.g. "teacher", "state", "local", "state and local", "police and fire", "state, local, and teacher")
#' @param blend.teacher TRUE if you want to create another category ("state, local, and teacher")
#' @return A wide data frame with each year as a row and variables as columns.
#' @export
#' @importFrom rlang .data
#' @examples
#' \dontrun{
#' filterData(Data, 2001, employee = "teacher", blend.teacher = FALSE, source = FALSE)
#' }
#' @author Anil Niraula <anil.niraula@reason.org>

filterData <- function(Data, fy = 2001, employee = NULL, blend.teacher = FALSE, source = FALSE) 
{
  
  if (isTRUE(blend.teacher)) {
    
    blended.teach <- c(
      "Arizona State Retirement System",
      "Delaware State Employees’ Pension Plan",
      "District of Columbia Teachers Retirement Fund",
      "Florida Retirement System",
      "Employee Retirement System of Hawaii",
      "Idaho Public Employee Retirement System",
      "Iowa Public Employees' Retirement System",
      "Kansas Public Employees' Retirement System",
      "Public Employees' Retirement System of Mississippi",
      "Nevada Public Employees Retirement System",
      "New Hampshire Retirement System",
      "North Carolina Teachers' and State Employees' Retirement System",
      "Oregon Public Employees Retirement System",
      "Rhode Island Employees Retirement System",
      "South Carolina Retirement Systems",
      "South Dakota Retirement System",
      "Tennessee Consolidated Retirement System, Teachers Pension Plan",
      "Utah Retirement Systems, Noncontributory Retirement System",
      "Virginia Retirement System",
      "Wisconsin Retirement System",
      "Wyoming Retirement System, Public Employees’ Pension Plan",
      "Maine Public Employees Retirement System (PERS) Defined Benefit Plan",
      "Maryland State Employees’ Retirement System"
    )
    
    Data <- data.frame(Data)
    
    Data <- Data %>% 
      mutate(type_of_employees_covered = 
               case_when(display_name %in% blended.teach ~ "Plan covers state, local and teachers",
                         TRUE ~ type_of_employees_covered))
    
  }
  
  Data <- data.frame(Data)
  
  columns <- c("total_pension_liability_dollar", "wage_inflation", 
               "payroll_growth_assumption", "other_contribution_dollar", 
               "other_additions_dollar", "x1_year_investment_return_percentage", 
               "amortizaton_method", "number_of_years_remaining_on_amortization_schedule", 
               "total_normal_cost_dollar", "fiscal_year_of_contribution", 
               "statutory_payment_dollar", "statutory_payment_percentage", 
               "discount_rate_assumption", "market_investment_return_mva_basis", 
               "cost_structure", "employer_normal_cost_percentage", 
               "asset_valuation_method_for_gasb_reporting", "inflation_rate_assumption_for_gasb_reporting", 
               "total_number_of_members", "total_projected_actuarial_required_contribution_percentage_of_payroll", 
               "market_assets_reported_for_asset_smoothing")
  columns2 <- c("test")
  for (i in (1:length(columns))) {
    if (sum(colnames(Data) %in% columns[i]) == 0) {
      columns2 <- rbind(columns2, columns[i])
    }
  }
  columns2 <- as.character(columns2 <- columns2[2:length(columns2)])
  cols <- matrix(NA, length(Data[, 1]), length(columns2))
  colnames(cols) <- columns2
  Data <- cbind(Data, cols)
  Data <- data.frame(Data)
  Data <- Data %>% arrange(state, display_name, year)
  Data <- Data %>% select(year, plan_name = display_name, 
                          state, if (isTRUE(source)) {
                            "data_source_name"
                          }, return_1yr = x1_year_investment_return_percentage, 
                          ava_return = market_investment_return_mva_basis, actuarial_cost_method_in_gasb_reporting, 
                          funded_ratio = actuarial_funded_ratio_percentage, ava = actuarial_value_of_assets_gasb_dollar, 
                          mva = market_value_of_assets_dollar, mva_smooth = market_assets_reported_for_asset_smoothing, 
                          aal = actuarially_accrued_liabilities_dollar, tpl = total_pension_liability_dollar, 
                          adec = actuarially_required_contribution_dollar, adec_paid_pct = actuarially_required_contribution_paid_percentage, 
                          statutory = statutory_payment_dollar, statutory_pct = statutory_payment_percentage, 
                          amortizaton_method, total_benefit_payments = total_benefits_paid_dollar, 
                          benefit_payments = benefit_payments_dollar, refunds = refunds_dollar, 
                          admin_exp = administrative_expense_dollar, cost_structure, 
                          asset_valuation_method_for_gasb_reporting, payroll = covered_payroll_dollar, 
                          ee_contribution = employee_contribution_dollar, ee_nc_pct = employee_normal_cost_percentage, 
                          er_contribution = employer_contribution_regular_dollar, 
                          er_nc_pct = employer_normal_cost_percentage, er_state_contribution = employer_state_contribution_dollar, 
                          er_proj_adec_pct = employers_projected_actuarial_required_contribution_percentage_of_payroll, 
                          other_contribution = other_contribution_dollar, other_additions = other_additions_dollar, 
                          fy_contribution = fiscal_year_of_contribution, inflation_assum = inflation_rate_assumption_for_gasb_reporting, 
                          arr = investment_return_assumption_for_gasb_reporting, 
                          dr = discount_rate_assumption, number_of_years_remaining_on_amortization_schedule, 
                          payroll_growth_assumption, total_amortization_payment_pct = total_amortization_payment_percentage, 
                          total_contribution = total_contribution_dollar, total_nc_pct = total_normal_cost_percentage, 
                          total_nc_dollar = total_normal_cost_dollar, total_number_of_members, 
                          total_proj_adec_pct = total_projected_actuarial_required_contribution_percentage_of_payroll, 
                          type_of_employees_covered, unfunded_actuarially_accrued_liabilities_dollar, 
                          wage_inflation)
  Data$fy_contribution <- as.numeric(Data$fy_contribution)
  Data$year <- as.numeric(Data$year)
  Data$fy_contribution <- round(Data$fy_contribution, 0)
  Data <- Data %>% filter(year >= fy)
  

  
  if (is_null(employee)) {
    employee <- employee
  }
  else if (employee == "teacher") {
    employee <- c("Plan covers teachers")
  }
  else if (employee == "state and local") {
    employee <- c("Plan covers state and local employees")
  }
  else if (employee == "police and fire") {
    employee <- c("Plan covers police and/or fire")
  }
  else if (employee == "state") {
    employee <- c("Plan covers state employees")
  }
  else if (employee == "local") {
    employee <- c("Plan covers local employees")
  }
  else if (employee == "state, local, and teachers") {
    employee <- c("Plan covers state, local and teachers")
  }
  
  if (is_null(employee)) {
    Data <- data.frame(Data)
  }
  else {
    Data %>% filter(type_of_employees_covered == paste(employee))
  }
}

