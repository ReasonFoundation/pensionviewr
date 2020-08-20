---
output: github_document
always_allow_html: yes
---
knitr::knit("README.Rmd")
<!-- README.md is generated from README.Rmd. Please edit that file -->



# pensionviewr

The goal of `pensionviewr` is to simplify the process of gathering and visualizing public pension plan data from the Reason pension database. This repo contains the functions of the `pensionviewr` package, which once installed locally, provides helpful functions for creating and exporting graphics made in ggplot in the style used by the Reason Pension Integrity Project team.

## Installing pensionviewr

`pensionviewr` is not on CRAN, so you will have to install it directly from Github using `devtools`. 

If you do not have the `devtools` package installed, you will have to run the first line in the code below as well. 

``` r
install.packages('devtools')
devtools::install_github("ReasonFoundation/pensionviewr")
```

## Using the functions:

The package has seven functions for data pulling and preparation: 
`planList()`, 
`pullData()`, 
`pullStateData()`,
`pullSourceData()`.
`filterData()`,
`loadData()`, and 
`selectedData()`.

The package has four functions for plots: 
`glPlot()`, 
`linePlot()`, 
`debtPlot()`, and 
`savePlot()`.

A basic explanation and summary here:

### `planList()`

1. `planList()`: returns a stripped down list of the pension plans in the database along with their state and the internal databse id.

Example of how it is used in a standard workflow:


```r
pl <- planList()
pl %>% 
  head() %>%
  kable() %>%
  kable_styling(full_width = FALSE, position = "left")
```

<table class="table" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:left;"> display_name </th>
   <th style="text-align:left;"> state </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:left;"> Alabama Clerks &amp; Registrars Supernumerary Fund </td>
   <td style="text-align:left;"> Alabama </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Alabama Employees' Retirement System (ERS) </td>
   <td style="text-align:left;"> Alabama </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> Alabama Judicial Retirement Fund (JRF) </td>
   <td style="text-align:left;"> Alabama </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> Alabama Peace Officers Annuity Benefit Fund </td>
   <td style="text-align:left;"> Alabama </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> Alabama Port Authority Hourly Pension Plan </td>
   <td style="text-align:left;"> Alabama </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;"> Alabama Port Authority Terminal Railway Plan </td>
   <td style="text-align:left;"> Alabama </td>
  </tr>
</tbody>
</table>

### `pullData()`

2. `pullData()`:  pulls the data for a specified plan from the Reason pension database. `pullData` has two arguments:
`pullData(pl, plan_name)`

* `pl`: A datafram containing the list of plan names, states, and ids in the form produced by the `planList()` function.
* `plan_name`: A string enclosed in quotation marks containing a plan name as it is listed in the Reason pension database.

Example of how it is used in a standard workflow:

The next step would be to load the data for the specific plan of interest. Let's use the Vermont State Retirement System as an example. Let's first see what plans in Vermont are available:


```r
VT <- pl %>% filter(state == 'Vermont')
VT %>% 
  kable() %>%
  kable_styling(full_width = FALSE, position = "left")
```

<table class="table" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:left;"> display_name </th>
   <th style="text-align:left;"> state </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1945 </td>
   <td style="text-align:left;"> Burlington Employees Retirement System </td>
   <td style="text-align:left;"> Vermont </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1946 </td>
   <td style="text-align:left;"> City Of South Burlington Employees Pension Plan </td>
   <td style="text-align:left;"> Vermont </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1947 </td>
   <td style="text-align:left;"> City Of St. Albans Pension Plan </td>
   <td style="text-align:left;"> Vermont </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1950 </td>
   <td style="text-align:left;"> Rockingham &amp; Bellows Falls Employees' Pension </td>
   <td style="text-align:left;"> Vermont </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1948 </td>
   <td style="text-align:left;"> Rutland City Pension Plan </td>
   <td style="text-align:left;"> Vermont </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1949 </td>
   <td style="text-align:left;"> St. Johnsbury Town Pension Plan </td>
   <td style="text-align:left;"> Vermont </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1944 </td>
   <td style="text-align:left;"> Vermont Municipal Employees Retirement System </td>
   <td style="text-align:left;"> Vermont </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1942 </td>
   <td style="text-align:left;"> Vermont State Retirement System </td>
   <td style="text-align:left;"> Vermont </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1943 </td>
   <td style="text-align:left;"> Vermont State Teachers' Retirement System </td>
   <td style="text-align:left;"> Vermont </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1951 </td>
   <td style="text-align:left;"> Windsor Town Pension Plan </td>
   <td style="text-align:left;"> Vermont </td>
  </tr>
</tbody>
</table>

The full plan name we are interested in is there listed as "Vermon State Retirement System". We can pull the data for it now:


```r
vtsrs_data <- pullData(pl, plan_name = "Vermont State Retirement System")
vtsrs_data %>% 
  head() %>%
  kable() %>%
  kable_styling(full_width = FALSE, position = "left")
```

<table class="table" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;"> year </th>
   <th style="text-align:right;"> plan_id </th>
   <th style="text-align:left;"> display_name </th>
   <th style="text-align:left;"> state </th>
   <th style="text-align:right;"> x1_year_investment_return_percentage </th>
   <th style="text-align:right;"> x10_year_investment_return_percentage </th>
   <th style="text-align:right;"> x3_year_investment_return_percentage </th>
   <th style="text-align:right;"> x5_year_investment_return_percentage </th>
   <th style="text-align:right;"> x7_year_investment_return_percentage </th>
   <th style="text-align:right;"> actuarial_assets_reported_for_asset_smoothing </th>
   <th style="text-align:right;"> actuarial_cost_method_code_names_for_gasb </th>
   <th style="text-align:left;"> actuarial_cost_method_in_gasb_reporting </th>
   <th style="text-align:right;"> actuarial_experience_dollar </th>
   <th style="text-align:right;"> actuarial_funded_ratio_percentage </th>
   <th style="text-align:left;"> actuarial_valuation_report_date </th>
   <th style="text-align:right;"> actuarial_value_of_assets_dollar </th>
   <th style="text-align:right;"> actuarial_value_of_assets_gasb_dollar </th>
   <th style="text-align:right;"> actuarially_accrued_liabilities_dollar </th>
   <th style="text-align:right;"> actuarially_determined_contribution_dollar </th>
   <th style="text-align:right;"> actuarially_determined_contribution_missed_dollar </th>
   <th style="text-align:right;"> actuarially_required_contribution_dollar </th>
   <th style="text-align:right;"> actuarially_required_contribution_paid_dollar </th>
   <th style="text-align:right;"> actuarially_required_contribution_paid_percentage </th>
   <th style="text-align:right;"> administering_government_type </th>
   <th style="text-align:left;"> administrating_jurisdiction </th>
   <th style="text-align:right;"> administrative_expense_dollar </th>
   <th style="text-align:right;"> administrative_expense_in_normal_cost_dollar </th>
   <th style="text-align:right;"> age_of_retirement_experience_dollar </th>
   <th style="text-align:left;"> amortizaton_method </th>
   <th style="text-align:right;"> amounts_transmitted_to_federal_social_security_system_dollar </th>
   <th style="text-align:right;"> are_most_members_covered_by_social_security </th>
   <th style="text-align:right;"> asset_smoothing_baseline </th>
   <th style="text-align:right;"> asset_smoothing_baseline_add_or_subtract_gain_loss </th>
   <th style="text-align:right;"> asset_smoothing_period_for_gasb_reporting </th>
   <th style="text-align:right;"> asset_valuation_method_code_for_gasb_reporting </th>
   <th style="text-align:right;"> asset_valuation_method_code_for_plan_reporting </th>
   <th style="text-align:left;"> asset_valuation_method_for_gasb_reporting </th>
   <th style="text-align:right;"> average_age_of_actives </th>
   <th style="text-align:right;"> average_benefit_of_beneficiaries </th>
   <th style="text-align:right;"> average_salary_of_actives </th>
   <th style="text-align:right;"> average_tenure_of_actives </th>
   <th style="text-align:right;"> basis_of_membership_and_participation </th>
   <th style="text-align:right;"> benefit_payments_dollar </th>
   <th style="text-align:right;"> benefits_paid_to_disability_retirees_dollar </th>
   <th style="text-align:right;"> benefits_paid_to_service_retirees_dollar </th>
   <th style="text-align:left;"> benefits_website </th>
   <th style="text-align:right;"> blended_discount_rate </th>
   <th style="text-align:right;"> bonds_corporate_book_value_dollar </th>
   <th style="text-align:right;"> bonds_corporate_other_book_value_dollar </th>
   <th style="text-align:right;"> bonds_corporate_other_dollar </th>
   <th style="text-align:right;"> bonds_federally_sponsored_investments_dollar </th>
   <th style="text-align:right;"> cash_and_short_term_investments_dollar </th>
   <th style="text-align:right;"> cash_on_hand_and_demand_deposits_dollar </th>
   <th style="text-align:right;"> census_coverage_type </th>
   <th style="text-align:right;"> census_retirement_system_code </th>
   <th style="text-align:right;"> closed_plan </th>
   <th style="text-align:right;"> cost_sharing </th>
   <th style="text-align:left;"> cost_structure </th>
   <th style="text-align:right;"> covered_payroll_dollar </th>
   <th style="text-align:right;"> current_gain_loss_amount </th>
   <th style="text-align:right;"> death_benefits_paid_dollar </th>
   <th style="text-align:right;"> depreciation_expense_dollar </th>
   <th style="text-align:right;"> disability_benefits_paid_dollar </th>
   <th style="text-align:right;"> disability_claim_experience_total_dollar </th>
   <th style="text-align:left;"> discount_rate_assumption </th>
   <th style="text-align:right;"> dividends_income_dollar </th>
   <th style="text-align:right;"> do_employees_contribute </th>
   <th style="text-align:right;"> employee_contribution_dollar </th>
   <th style="text-align:right;"> employee_group_id </th>
   <th style="text-align:right;"> employee_normal_cost_percentage </th>
   <th style="text-align:right;"> employee_normal_cost_percentage_estimated_categorical </th>
   <th style="text-align:right;"> employees_receiving_lump_sum_payments </th>
   <th style="text-align:right;"> employer_contribution_regular_dollar </th>
   <th style="text-align:right;"> employer_normal_cost_percentage </th>
   <th style="text-align:right;"> employer_normal_cost_percentage_estimated_categorical </th>
   <th style="text-align:right;"> employer_regular_contribution_dollar </th>
   <th style="text-align:right;"> employer_state_contribution_dollar </th>
   <th style="text-align:right;"> employer_type </th>
   <th style="text-align:right;"> employers_projected_actuarial_required_contribution_percentage_of_payroll </th>
   <th style="text-align:right;"> estimated_actuarial_assets_indicator </th>
   <th style="text-align:right;"> estimated_actuarial_funded_ratio_indicator </th>
   <th style="text-align:right;"> estimated_actuarial_liabilities_indicator </th>
   <th style="text-align:right;"> estimated_employers_projected_actuarial_required_contribution_categorical </th>
   <th style="text-align:right;"> expected_return_method </th>
   <th style="text-align:right;"> fair_value_change_investments </th>
   <th style="text-align:right;"> federal_agency_securities_investments_dollar </th>
   <th style="text-align:right;"> federal_government_securities_investments_dollar </th>
   <th style="text-align:right;"> federal_treasury_securities_investments_dollar </th>
   <th style="text-align:right;"> federally_sponsored_agnecy_securities_investments_dollar </th>
   <th style="text-align:left;"> fiscal_year_end_date </th>
   <th style="text-align:right;"> fiscal_year_of_contribution </th>
   <th style="text-align:right;"> fiscal_year_type </th>
   <th style="text-align:right;"> foreign_and_international_securities_investments_1997_2001_dollar </th>
   <th style="text-align:right;"> foreign_and_international_securities_investments_2001_present_dollar </th>
   <th style="text-align:right;"> former_active_members_retired_on_account_of_age_or_service </th>
   <th style="text-align:right;"> former_active_members_retired_on_account_of_disability </th>
   <th style="text-align:left;"> full_state_name </th>
   <th style="text-align:right;"> funding_method_code_1_for_gasb_reporting </th>
   <th style="text-align:right;"> funding_method_code_2_for_gasb_reporting </th>
   <th style="text-align:right;"> gain_from_investments_dollar </th>
   <th style="text-align:right;"> gain_loss_base_1 </th>
   <th style="text-align:right;"> gain_loss_base_2 </th>
   <th style="text-align:right;"> gain_loss_concept </th>
   <th style="text-align:right;"> gain_loss_period </th>
   <th style="text-align:right;"> gain_loss_recognition </th>
   <th style="text-align:right;"> gain_loss_periods_phased_in_for_asset_smoothing </th>
   <th style="text-align:right;"> geometric_growth_percentage </th>
   <th style="text-align:right;"> geometric_return_percentage </th>
   <th style="text-align:right;"> gross_or_net_investment_returns_categorical </th>
   <th style="text-align:right;"> inactive_members </th>
   <th style="text-align:right;"> inflation_rate_assumption_for_gasb_reporting </th>
   <th style="text-align:right;"> interest_and_dividends_income_dollar </th>
   <th style="text-align:right;"> interest_income_dollar </th>
   <th style="text-align:right;"> investment_expenses_dollar </th>
   <th style="text-align:right;"> investment_experience_dollar </th>
   <th style="text-align:left;"> investment_return_assumption_for_gasb_reporting </th>
   <th style="text-align:right;"> investments_held_in_trust_by_other_agencies_dollar </th>
   <th style="text-align:right;"> legislative_changes_dollar </th>
   <th style="text-align:right;"> local_employee_contribution_dollar </th>
   <th style="text-align:right;"> local_government_active_members </th>
   <th style="text-align:right;"> local_government_contribution_dollar </th>
   <th style="text-align:right;"> loss_from_investments_dollar </th>
   <th style="text-align:right;"> market_assets_reported_for_asset_smoothing </th>
   <th style="text-align:right;"> market_funded_ratio_percentage </th>
   <th style="text-align:right;"> market_value_of_assets_dollar </th>
   <th style="text-align:right;"> market_value_of_assets_net_of_fees_dollar </th>
   <th style="text-align:right;"> members_covered_by_social_security </th>
   <th style="text-align:right;"> monthly_lump_sum_payments_to_members_dollar </th>
   <th style="text-align:right;"> monthly_lump_sum_payments_to_survivors_dollar </th>
   <th style="text-align:right;"> monthly_payments_to_disabled_dollar </th>
   <th style="text-align:right;"> monthly_payments_to_retirees_dollar </th>
   <th style="text-align:right;"> monthly_payments_to_survivors_dollar </th>
   <th style="text-align:right;"> mortality_rate_experience_active_dollar </th>
   <th style="text-align:right;"> mortality_rate_experience_total_dollar </th>
   <th style="text-align:right;"> mortgage_investments_dollar </th>
   <th style="text-align:left;"> multiple_discount_rates </th>
   <th style="text-align:right;"> net_expenses_dollar </th>
   <th style="text-align:right;"> net_flows_reported_for_asset_smoothing </th>
   <th style="text-align:right;"> net_pension_liability_dollar </th>
   <th style="text-align:right;"> net_position_dollar </th>
   <th style="text-align:right;"> new_entrant_experience_dollar </th>
   <th style="text-align:right;"> non_investment_actuarial_experience_dollar </th>
   <th style="text-align:right;"> number_of_survivors </th>
   <th style="text-align:right;"> number_of_years_remaining_on_amortization_schedule </th>
   <th style="text-align:right;"> optional_benefits_available </th>
   <th style="text-align:right;"> other_actuarial_experience_dollar </th>
   <th style="text-align:right;"> other_actuarially_accured_liabilities_dollar </th>
   <th style="text-align:right;"> other_benefits_paid_dollar </th>
   <th style="text-align:right;"> other_contribution_dollar </th>
   <th style="text-align:right;"> other_deductions_dollar </th>
   <th style="text-align:right;"> other_investments_dollar </th>
   <th style="text-align:right;"> other_investments_income_dollar </th>
   <th style="text-align:right;"> other_payments_dollar </th>
   <th style="text-align:right;"> other_receipts_paid_dollar </th>
   <th style="text-align:right;"> other_securities_investments_dollar </th>
   <th style="text-align:right;"> payroll_growth_assumption </th>
   <th style="text-align:right;"> percent_of_gain_loss_to_be_phased_in_this_year </th>
   <th style="text-align:left;"> plan_full_name </th>
   <th style="text-align:left;"> plan_name </th>
   <th style="text-align:right;"> plan_type </th>
   <th style="text-align:right;"> present_value_of_future_benefits_for_active_members_dollar </th>
   <th style="text-align:right;"> present_value_of_future_benefits_for_retired_members_dollar </th>
   <th style="text-align:right;"> real_estate_investments_dollar </th>
   <th style="text-align:right;"> receipts_for_transmittal_to_federal_social_security_system_dollar </th>
   <th style="text-align:right;"> refunds_dollar </th>
   <th style="text-align:right;"> rentals_from_state_government_dollar </th>
   <th style="text-align:right;"> retirement_benefits_paid_dollar </th>
   <th style="text-align:right;"> salary_experience_dollar </th>
   <th style="text-align:right;"> securities_lending_dollar </th>
   <th style="text-align:right;"> securities_lending_income_dollar </th>
   <th style="text-align:right;"> short_term_investments_dollar </th>
   <th style="text-align:right;"> smoothing_reset </th>
   <th style="text-align:left;"> social_security_coverage_of_plan_members </th>
   <th style="text-align:left;"> state_abbreviation </th>
   <th style="text-align:right;"> state_and_local_government_securitites_investments_dollar </th>
   <th style="text-align:right;"> state_contribution_for_employee_dollar </th>
   <th style="text-align:right;"> state_contribution_to_own_system_on_behalf_of_employees_dollar </th>
   <th style="text-align:right;"> state_employee_contribution_dollar </th>
   <th style="text-align:right;"> state_government_active_members </th>
   <th style="text-align:right;"> stocks_corporate_book_value_dollar </th>
   <th style="text-align:right;"> stocks_corporate_dollar </th>
   <th style="text-align:right;"> survivior_benefits_paid_dollar </th>
   <th style="text-align:right;"> survivors_receiving_lump_sum_payments </th>
   <th style="text-align:right;"> system_id </th>
   <th style="text-align:right;"> tier_id </th>
   <th style="text-align:right;"> time_or_savings_deposits_dollar </th>
   <th style="text-align:right;"> total_active_members </th>
   <th style="text-align:right;"> total_additions_dollar </th>
   <th style="text-align:right;"> total_amortization_payment_percentage </th>
   <th style="text-align:right;"> total_amount_of_active_salaries_payroll_in_dollars </th>
   <th style="text-align:right;"> total_benefits_paid_dollar </th>
   <th style="text-align:right;"> total_cash_and_securities_investments_dollar </th>
   <th style="text-align:right;"> total_contribution_dollar </th>
   <th style="text-align:right;"> total_corporate_bonds_investments_dollar </th>
   <th style="text-align:right;"> total_earnings_on_investments_dollar </th>
   <th style="text-align:right;"> total_normal_cost_percentage </th>
   <th style="text-align:right;"> total_normal_cost_percentage_estimated_categorical </th>
   <th style="text-align:right;"> total_number_of_beneficiaries </th>
   <th style="text-align:right;"> total_number_of_disability_retirees </th>
   <th style="text-align:right;"> total_number_of_inactive_non_vested </th>
   <th style="text-align:right;"> total_number_of_inactive_vested </th>
   <th style="text-align:right;"> total_number_of_members </th>
   <th style="text-align:right;"> total_number_of_other_beneficiaries </th>
   <th style="text-align:right;"> total_number_of_service_retirees </th>
   <th style="text-align:right;"> total_number_of_survivor_beneficiaries </th>
   <th style="text-align:right;"> total_other_investments_dollar </th>
   <th style="text-align:right;"> total_other_securities_investments_dollar </th>
   <th style="text-align:right;"> total_pension_liability_dollar </th>
   <th style="text-align:right;"> total_projected_actuarial_required_contribution_percentage_of_payroll </th>
   <th style="text-align:left;"> type_of_employees_covered </th>
   <th style="text-align:right;"> unfunded_actuarially_accrued_liabilities_dollar </th>
   <th style="text-align:right;"> vesting_period </th>
   <th style="text-align:right;"> withdrawal_experience_dollar </th>
   <th style="text-align:right;"> year_of_inception </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 1987 </td>
   <td style="text-align:right;"> 1942 </td>
   <td style="text-align:left;"> Vermont State Retirement System </td>
   <td style="text-align:left;"> Vermont </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 10937000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 55374000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 40324000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 16763000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 33406000 </td>
   <td style="text-align:right;"> 33406000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 159000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 72891000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 9570 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 12432000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 1988 </td>
   <td style="text-align:right;"> 1942 </td>
   <td style="text-align:left;"> Vermont State Retirement System </td>
   <td style="text-align:left;"> Vermont </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 11939000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 74255000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 16755000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 17446000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 18254000 </td>
   <td style="text-align:right;"> 17970000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 1035000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 91137000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 10846 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 24801000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 1989 </td>
   <td style="text-align:right;"> 1942 </td>
   <td style="text-align:left;"> Vermont State Retirement System </td>
   <td style="text-align:left;"> Vermont </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 12952000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 65332000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 36288000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 19053000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 52105000 </td>
   <td style="text-align:right;"> 46494000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 245000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 97577000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 9344 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 39059000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 1990 </td>
   <td style="text-align:right;"> 1942 </td>
   <td style="text-align:left;"> Vermont State Retirement System </td>
   <td style="text-align:left;"> Vermont </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 14194000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 81205000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 24321000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 20993000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 42673000 </td>
   <td style="text-align:right;"> 33514000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 225000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 138437000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 9445 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 33700000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 1991 </td>
   <td style="text-align:right;"> 1942 </td>
   <td style="text-align:left;"> Vermont State Retirement System </td>
   <td style="text-align:left;"> Vermont </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 16525000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 80874000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 11709000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 17681000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 41568000 </td>
   <td style="text-align:right;"> 41568000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 503000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 169474000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 9163 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 24380000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 1992 </td>
   <td style="text-align:right;"> 1942 </td>
   <td style="text-align:left;"> Vermont State Retirement System </td>
   <td style="text-align:left;"> Vermont </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 18238000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 78964000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 33116000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 17523000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 40497000 </td>
   <td style="text-align:right;"> 40497000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 239000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 174366000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 9138 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 29164000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
</tbody>
</table>

### `pullStateData()`

3. `pullStateData()`: pulls all state-level pension data in wide format from the Reason pension database. `pullStateData` has single argument:
`pullStateData(FY)`

* `FY`: Starting fiscal year for the data pulled from the Reason pension database.

This could be the initial step for either making state-level pension analysis or then filter pulled data for a specific state plan.
Example of how it is used in a standard workflow:


```r
state.data <- pullStateData(2001)
Kansas.data <- state.data %>% filter(state == 'Kansas')
Kansas.PERS.data <- state.data %>% filter(state == "Kansas Public Employees' Retirement System")
state.data %>% 
  head() %>%
  kable() %>%
  kable_styling(full_width = FALSE, position = "left")
```

<table class="table" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;"> year </th>
   <th style="text-align:right;"> plan_id </th>
   <th style="text-align:left;"> display_name </th>
   <th style="text-align:left;"> state </th>
   <th style="text-align:left;"> investment_return_assumption_for_gasb_reporting </th>
   <th style="text-align:left;"> actuarial_funded_ratio_percentage </th>
   <th style="text-align:left;"> actuarially_required_contribution_dollar </th>
   <th style="text-align:left;"> total_amortization_payment_percentage </th>
   <th style="text-align:left;"> administrative_expense_dollar </th>
   <th style="text-align:left;"> x1_year_investment_return_percentage </th>
   <th style="text-align:left;"> employer_state_contribution_dollar </th>
   <th style="text-align:left;"> type_of_employees_covered </th>
   <th style="text-align:left;"> covered_payroll_dollar </th>
   <th style="text-align:left;"> actuarial_cost_method_in_gasb_reporting </th>
   <th style="text-align:left;"> actuarially_accrued_liabilities_dollar </th>
   <th style="text-align:left;"> number_of_years_remaining_on_amortization_schedule </th>
   <th style="text-align:left;"> total_benefits_paid_dollar </th>
   <th style="text-align:left;"> benefit_payments_dollar </th>
   <th style="text-align:left;"> other_contribution_dollar </th>
   <th style="text-align:left;"> employer_contribution_regular_dollar </th>
   <th style="text-align:left;"> refunds_dollar </th>
   <th style="text-align:left;"> total_normal_cost_percentage </th>
   <th style="text-align:left;"> unfunded_actuarially_accrued_liabilities_dollar </th>
   <th style="text-align:left;"> employee_normal_cost_percentage </th>
   <th style="text-align:left;"> payroll_growth_assumption </th>
   <th style="text-align:left;"> market_value_of_assets_dollar </th>
   <th style="text-align:left;"> actuarially_required_contribution_paid_percentage </th>
   <th style="text-align:left;"> actuarial_value_of_assets_gasb_dollar </th>
   <th style="text-align:left;"> amortizaton_method </th>
   <th style="text-align:left;"> total_contribution_dollar </th>
   <th style="text-align:left;"> wage_inflation </th>
   <th style="text-align:left;"> total_pension_liability_dollar </th>
   <th style="text-align:left;"> employers_projected_actuarial_required_contribution_percentage_of_payroll </th>
   <th style="text-align:left;"> statutory_payment_percentage </th>
   <th style="text-align:left;"> employee_contribution_dollar </th>
   <th style="text-align:left;"> statutory_payment_dollar </th>
   <th style="text-align:left;"> discount_rate_assumption </th>
   <th style="text-align:left;"> employer_normal_cost_dollar </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2001 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Alabama Employees' Retirement System (ERS) </td>
   <td style="text-align:left;"> Alabama </td>
   <td style="text-align:left;"> 0.08 </td>
   <td style="text-align:left;"> 1.002 </td>
   <td style="text-align:left;"> 122483000 </td>
   <td style="text-align:left;"> -0.0044 </td>
   <td style="text-align:left;"> -4578000 </td>
   <td style="text-align:left;"> -0.0636 </td>
   <td style="text-align:left;"> 65159000 </td>
   <td style="text-align:left;"> Plan covers state and local employees </td>
   <td style="text-align:left;"> 2408543000 </td>
   <td style="text-align:left;"> Entry Age Normal </td>
   <td style="text-align:left;"> 8010123000 </td>
   <td style="text-align:left;"> 12.0 </td>
   <td style="text-align:left;"> -396621000 </td>
   <td style="text-align:left;"> 378196060 </td>
   <td style="text-align:left;"> 1273000 </td>
   <td style="text-align:left;"> 122483000 </td>
   <td style="text-align:left;"> -1544000 </td>
   <td style="text-align:left;"> 0.1 </td>
   <td style="text-align:left;"> -18348000 </td>
   <td style="text-align:left;"> 0.0501 </td>
   <td style="text-align:left;"> 0.045 </td>
   <td style="text-align:left;"> 7236735000 </td>
   <td style="text-align:left;"> 1.0 </td>
   <td style="text-align:left;"> 8028471000 </td>
   <td style="text-align:left;"> Level Percent Open </td>
   <td style="text-align:left;"> 254721000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 0.0455 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 130965000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2002 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Alabama Employees' Retirement System (ERS) </td>
   <td style="text-align:left;"> Alabama </td>
   <td style="text-align:left;"> 0.08 </td>
   <td style="text-align:left;"> 0.954 </td>
   <td style="text-align:left;"> 123887000 </td>
   <td style="text-align:left;"> 0.0145 </td>
   <td style="text-align:left;"> -5582000 </td>
   <td style="text-align:left;"> -0.0929 </td>
   <td style="text-align:left;"> 64421000 </td>
   <td style="text-align:left;"> Plan covers state and local employees </td>
   <td style="text-align:left;"> 2547775000 </td>
   <td style="text-align:left;"> Entry Age Normal </td>
   <td style="text-align:left;"> 8493469000 </td>
   <td style="text-align:left;"> 18.0 </td>
   <td style="text-align:left;"> -414821000 </td>
   <td style="text-align:left;"> 411556940 </td>
   <td style="text-align:left;"> 2091000 </td>
   <td style="text-align:left;"> 123887000 </td>
   <td style="text-align:left;"> -8388000 </td>
   <td style="text-align:left;"> 0.0988 </td>
   <td style="text-align:left;"> 392623000 </td>
   <td style="text-align:left;"> 0.0501 </td>
   <td style="text-align:left;"> 0.045 </td>
   <td style="text-align:left;"> 6424435000 </td>
   <td style="text-align:left;"> 1.0 </td>
   <td style="text-align:left;"> 8100846000 </td>
   <td style="text-align:left;"> Level Percent Open </td>
   <td style="text-align:left;"> 275108000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 0.0632 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 149130000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2003 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Alabama Employees' Retirement System (ERS) </td>
   <td style="text-align:left;"> Alabama </td>
   <td style="text-align:left;"> 0.08 </td>
   <td style="text-align:left;"> 0.911 </td>
   <td style="text-align:left;"> 154218000 </td>
   <td style="text-align:left;"> 0.0151 </td>
   <td style="text-align:left;"> -5843000 </td>
   <td style="text-align:left;"> 0.1648 </td>
   <td style="text-align:left;"> 80193000 </td>
   <td style="text-align:left;"> Plan covers state and local employees </td>
   <td style="text-align:left;"> 2677025000 </td>
   <td style="text-align:left;"> Entry Age Normal </td>
   <td style="text-align:left;"> 9124279000 </td>
   <td style="text-align:left;"> 19.0 </td>
   <td style="text-align:left;"> -448083000 </td>
   <td style="text-align:left;"> 454751060 </td>
   <td style="text-align:left;"> 2521000 </td>
   <td style="text-align:left;"> 154218000 </td>
   <td style="text-align:left;"> -820000 </td>
   <td style="text-align:left;"> 0.0873 </td>
   <td style="text-align:left;"> 811779000 </td>
   <td style="text-align:left;"> 0.0501 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 7222812000 </td>
   <td style="text-align:left;"> 1.0 </td>
   <td style="text-align:left;"> 8312500000 </td>
   <td style="text-align:left;"> Level Percent Open </td>
   <td style="text-align:left;"> 316502000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 0.0523 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 159763000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2004 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Alabama Employees' Retirement System (ERS) </td>
   <td style="text-align:left;"> Alabama </td>
   <td style="text-align:left;"> 0.08 </td>
   <td style="text-align:left;"> 0.897 </td>
   <td style="text-align:left;"> 170713000 </td>
   <td style="text-align:left;"> 0.028 </td>
   <td style="text-align:left;"> -5892000 </td>
   <td style="text-align:left;"> 0.1006 </td>
   <td style="text-align:left;"> 80193000 </td>
   <td style="text-align:left;"> Plan covers state and local employees </td>
   <td style="text-align:left;"> 2702393000 </td>
   <td style="text-align:left;"> Entry Age Normal </td>
   <td style="text-align:left;"> 9546478000 </td>
   <td style="text-align:left;"> 19.0 </td>
   <td style="text-align:left;"> -480064000 </td>
   <td style="text-align:left;"> 497945220 </td>
   <td style="text-align:left;"> 1575000 </td>
   <td style="text-align:left;"> 170713000 </td>
   <td style="text-align:left;"> -3798000 </td>
   <td style="text-align:left;"> 0.0988 </td>
   <td style="text-align:left;"> 982533000 </td>
   <td style="text-align:left;"> 0.0501 </td>
   <td style="text-align:left;"> 0.045 </td>
   <td style="text-align:left;"> 7795598000 </td>
   <td style="text-align:left;"> 1.0 </td>
   <td style="text-align:left;"> 8563945000 </td>
   <td style="text-align:left;"> Level Percent Open </td>
   <td style="text-align:left;"> 339261000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 0.0767 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 166973000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2005 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Alabama Employees' Retirement System (ERS) </td>
   <td style="text-align:left;"> Alabama </td>
   <td style="text-align:left;"> 0.08 </td>
   <td style="text-align:left;"> 0.84 </td>
   <td style="text-align:left;"> 195846000 </td>
   <td style="text-align:left;"> 0.0441 </td>
   <td style="text-align:left;"> -6898000 </td>
   <td style="text-align:left;"> 0.1098 </td>
   <td style="text-align:left;"> 88770000 </td>
   <td style="text-align:left;"> Plan covers state and local employees </td>
   <td style="text-align:left;"> 2982122000 </td>
   <td style="text-align:left;"> Entry Age Normal </td>
   <td style="text-align:left;"> 10634976000 </td>
   <td style="text-align:left;"> 19.0 </td>
   <td style="text-align:left;"> -518308000 </td>
   <td style="text-align:left;"> 539462060 </td>
   <td style="text-align:left;"> 2185000 </td>
   <td style="text-align:left;"> 195846000 </td>
   <td style="text-align:left;"> 35204000 </td>
   <td style="text-align:left;"> 0.0982 </td>
   <td style="text-align:left;"> 1699618000 </td>
   <td style="text-align:left;"> 0.0501 </td>
   <td style="text-align:left;"> 0.045 </td>
   <td style="text-align:left;"> 8464515000 </td>
   <td style="text-align:left;"> 1.0 </td>
   <td style="text-align:left;"> 8935358000 </td>
   <td style="text-align:left;"> Level Percent Open </td>
   <td style="text-align:left;"> 356159000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 0.0922 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 158128000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2006 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Alabama Employees' Retirement System (ERS) </td>
   <td style="text-align:left;"> Alabama </td>
   <td style="text-align:left;"> 0.08 </td>
   <td style="text-align:left;"> 0.811 </td>
   <td style="text-align:left;"> 241750000 </td>
   <td style="text-align:left;"> 0.0516 </td>
   <td style="text-align:left;"> -7850000 </td>
   <td style="text-align:left;"> 0.0837 </td>
   <td style="text-align:left;"> 101881000 </td>
   <td style="text-align:left;"> Plan covers state and local employees </td>
   <td style="text-align:left;"> 3070146000 </td>
   <td style="text-align:left;"> Entry Age Normal </td>
   <td style="text-align:left;"> 11457564000 </td>
   <td style="text-align:left;"> 19.0 </td>
   <td style="text-align:left;"> -583573000 </td>
   <td style="text-align:left;"> 615907940 </td>
   <td style="text-align:left;"> 2982000 </td>
   <td style="text-align:left;"> 241750000 </td>
   <td style="text-align:left;"> 30960000 </td>
   <td style="text-align:left;"> 0.1006 </td>
   <td style="text-align:left;"> 2170033000 </td>
   <td style="text-align:left;"> 0.0501 </td>
   <td style="text-align:left;"> 0.045 </td>
   <td style="text-align:left;"> 9001867000 </td>
   <td style="text-align:left;"> 1.0 </td>
   <td style="text-align:left;"> 9287531000 </td>
   <td style="text-align:left;"> Level Percent Open </td>
   <td style="text-align:left;"> 428876000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 0.1021 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 184144000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
  </tr>
</tbody>
</table>

### `pullSourceData()`

4. `pullSourceData()`: pulls pension data for a specific plan, along with `data_source_name` column in wide format from the Reason pension database. `pullSourceData` has 3 arguments:

* `pl`: A dataf ram containing the list of plan names, states, and ids in the form produced by the `planList()` function.
* `plan_name`: A string enclosed in quotation marks containing a plan name as it is listed in the Reason pension database.
* `fy`: Starting fiscal year for the data pulled from the Reason pension database.

Example how this function is used:


```r
Kansas.source <- pullSourceData(pl, "Kansas Public Employees' Retirement System", 2001)
Kansas.source %>% 
  head() %>%
  kable() %>%
  kable_styling(full_width = FALSE, position = "left")
```

<table class="table" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;"> year </th>
   <th style="text-align:right;"> plan_id </th>
   <th style="text-align:left;"> display_name </th>
   <th style="text-align:left;"> state </th>
   <th style="text-align:left;"> data_source_name </th>
   <th style="text-align:right;"> x1_year_investment_return_percentage </th>
   <th style="text-align:right;"> x10_year_investment_return_percentage </th>
   <th style="text-align:right;"> x25_year_investment_return_percentage </th>
   <th style="text-align:right;"> x3_year_investment_return_percentage </th>
   <th style="text-align:right;"> x5_year_investment_return_percentage </th>
   <th style="text-align:right;"> actuarial_assets_reported_for_asset_smoothing </th>
   <th style="text-align:right;"> actuarial_cost_method_code_names_for_gasb </th>
   <th style="text-align:left;"> actuarial_cost_method_in_gasb_reporting </th>
   <th style="text-align:right;"> actuarial_funded_ratio_percentage </th>
   <th style="text-align:right;"> actuarial_liabilities_entry_age_normal_dollar </th>
   <th style="text-align:left;"> actuarial_valuation_report_date </th>
   <th style="text-align:right;"> actuarial_value_of_assets_dollar </th>
   <th style="text-align:right;"> actuarial_value_of_assets_gasb_dollar </th>
   <th style="text-align:right;"> actuarially_accrued_liabilities_dollar </th>
   <th style="text-align:right;"> actuarially_required_contribution_dollar </th>
   <th style="text-align:right;"> actuarially_required_contribution_paid_percentage </th>
   <th style="text-align:right;"> adjustment_to_market_value_of_assets_dollar </th>
   <th style="text-align:right;"> administering_government_type </th>
   <th style="text-align:left;"> administrating_jurisdiction </th>
   <th style="text-align:right;"> administrative_expense_dollar </th>
   <th style="text-align:right;"> administrative_expense_in_normal_cost_dollar </th>
   <th style="text-align:left;"> amortizaton_method </th>
   <th style="text-align:right;"> amounts_transmitted_to_federal_social_security_system_dollar </th>
   <th style="text-align:right;"> are_most_members_covered_by_social_security </th>
   <th style="text-align:right;"> asset_smoothing_baseline </th>
   <th style="text-align:right;"> asset_smoothing_baseline_add_or_subtract_gain_loss </th>
   <th style="text-align:right;"> asset_smoothing_period_for_gasb_reporting </th>
   <th style="text-align:right;"> asset_valuation_method_code_for_gasb_reporting </th>
   <th style="text-align:right;"> asset_valuation_method_code_for_plan_reporting </th>
   <th style="text-align:left;"> asset_valuation_method_for_gasb_reporting </th>
   <th style="text-align:right;"> average_age_of_actives </th>
   <th style="text-align:right;"> average_age_of_beneficiaries </th>
   <th style="text-align:right;"> average_age_of_service_retirees </th>
   <th style="text-align:right;"> average_benefit_of_beneficiaries </th>
   <th style="text-align:right;"> average_benefit_paid_to_service_retirees </th>
   <th style="text-align:right;"> average_salary_of_actives </th>
   <th style="text-align:right;"> average_tenure_of_actives </th>
   <th style="text-align:right;"> basis_of_membership_and_participation </th>
   <th style="text-align:right;"> benefit_payments_dollar </th>
   <th style="text-align:right;"> benefits_paid_to_service_retirees_dollar </th>
   <th style="text-align:left;"> benefits_website </th>
   <th style="text-align:right;"> blended_discount_rate </th>
   <th style="text-align:right;"> bonds_corporate_book_value_dollar </th>
   <th style="text-align:right;"> bonds_corporate_other_book_value_dollar </th>
   <th style="text-align:right;"> bonds_corporate_other_dollar </th>
   <th style="text-align:right;"> bonds_federally_sponsored_investments_dollar </th>
   <th style="text-align:right;"> cash_and_short_term_investments_dollar </th>
   <th style="text-align:right;"> cash_on_hand_and_demand_deposits_dollar </th>
   <th style="text-align:right;"> census_coverage_type </th>
   <th style="text-align:right;"> census_retirement_system_code </th>
   <th style="text-align:right;"> closed_plan </th>
   <th style="text-align:right;"> cost_sharing </th>
   <th style="text-align:left;"> cost_structure </th>
   <th style="text-align:right;"> covered_payroll_dollar </th>
   <th style="text-align:right;"> death_benefits_paid_dollar </th>
   <th style="text-align:right;"> disability_benefits_paid_dollar </th>
   <th style="text-align:right;"> dividends_income_dollar </th>
   <th style="text-align:right;"> do_employees_contribute </th>
   <th style="text-align:right;"> employee_contribution_dollar </th>
   <th style="text-align:right;"> employee_group_id </th>
   <th style="text-align:right;"> employee_normal_cost_percentage </th>
   <th style="text-align:right;"> employee_normal_cost_percentage_estimated_categorical </th>
   <th style="text-align:right;"> employees_receiving_lump_sum_payments </th>
   <th style="text-align:right;"> employer_contribution_regular_dollar </th>
   <th style="text-align:right;"> employer_normal_cost_percentage </th>
   <th style="text-align:right;"> employer_normal_cost_percentage_estimated_categorical </th>
   <th style="text-align:right;"> employer_regular_contribution_dollar </th>
   <th style="text-align:right;"> employer_state_contribution_dollar </th>
   <th style="text-align:right;"> employer_type </th>
   <th style="text-align:right;"> employers_projected_actuarial_required_contribution_percentage_of_payroll </th>
   <th style="text-align:right;"> estimated_actuarial_assets_indicator </th>
   <th style="text-align:right;"> estimated_actuarial_funded_ratio_indicator </th>
   <th style="text-align:right;"> estimated_actuarial_liabilities_indicator </th>
   <th style="text-align:right;"> estimated_employers_projected_actuarial_required_contribution_categorical </th>
   <th style="text-align:right;"> fair_value_change_investments </th>
   <th style="text-align:right;"> federal_agency_securities_investments_dollar </th>
   <th style="text-align:right;"> federal_government_securities_investments_dollar </th>
   <th style="text-align:right;"> federal_treasury_securities_investments_dollar </th>
   <th style="text-align:right;"> federally_sponsored_agnecy_securities_investments_dollar </th>
   <th style="text-align:left;"> fiscal_year_end_date </th>
   <th style="text-align:right;"> fiscal_year_of_contribution </th>
   <th style="text-align:right;"> fiscal_year_type </th>
   <th style="text-align:right;"> foreign_and_international_securities_investments_1997_2001_dollar </th>
   <th style="text-align:right;"> foreign_and_international_securities_investments_2001_present_dollar </th>
   <th style="text-align:right;"> former_active_members_retired_on_account_of_age_or_service </th>
   <th style="text-align:right;"> former_active_members_retired_on_account_of_disability </th>
   <th style="text-align:left;"> full_state_name </th>
   <th style="text-align:right;"> funding_method_code_1_for_gasb_reporting </th>
   <th style="text-align:right;"> funding_method_code_2_for_gasb_reporting </th>
   <th style="text-align:right;"> gain_from_investments_dollar </th>
   <th style="text-align:right;"> gain_loss_base_1 </th>
   <th style="text-align:right;"> gain_loss_base_2 </th>
   <th style="text-align:right;"> gain_loss_concept </th>
   <th style="text-align:right;"> gain_loss_period </th>
   <th style="text-align:right;"> gain_loss_recognition </th>
   <th style="text-align:right;"> gain_loss_periods_phased_in_for_asset_smoothing </th>
   <th style="text-align:left;"> gain_loss_values_to_be_included_in_smoothed_asset_calculation </th>
   <th style="text-align:right;"> gain_loss_values_used_in_smoothing </th>
   <th style="text-align:right;"> geometric_growth_percentage </th>
   <th style="text-align:right;"> geometric_return_percentage </th>
   <th style="text-align:right;"> gross_or_net_investment_returns_categorical </th>
   <th style="text-align:right;"> inactive_members </th>
   <th style="text-align:right;"> inflation_rate_assumption_for_gasb_reporting </th>
   <th style="text-align:right;"> interest_and_dividends_income_dollar </th>
   <th style="text-align:right;"> interest_income_dollar </th>
   <th style="text-align:right;"> investment_expenses_dollar </th>
   <th style="text-align:right;"> investment_return_assumption_for_gasb_reporting </th>
   <th style="text-align:right;"> investments_held_in_trust_by_other_agencies_dollar </th>
   <th style="text-align:right;"> local_employee_contribution_dollar </th>
   <th style="text-align:right;"> local_government_active_members </th>
   <th style="text-align:right;"> local_government_contribution_dollar </th>
   <th style="text-align:right;"> loss_from_investments_dollar </th>
   <th style="text-align:right;"> management_fees_for_securities_lending_dollar </th>
   <th style="text-align:right;"> market_assets_reported_for_asset_smoothing </th>
   <th style="text-align:right;"> market_funded_ratio_percentage </th>
   <th style="text-align:right;"> market_value_of_assets_dollar </th>
   <th style="text-align:right;"> market_value_of_assets_net_of_fees_dollar </th>
   <th style="text-align:right;"> members_covered_by_social_security </th>
   <th style="text-align:right;"> monthly_lump_sum_payments_to_members_dollar </th>
   <th style="text-align:right;"> monthly_lump_sum_payments_to_survivors_dollar </th>
   <th style="text-align:right;"> monthly_payments_to_disabled_dollar </th>
   <th style="text-align:right;"> monthly_payments_to_retirees_dollar </th>
   <th style="text-align:right;"> monthly_payments_to_survivors_dollar </th>
   <th style="text-align:right;"> mortgage_investments_dollar </th>
   <th style="text-align:right;"> net_expenses_dollar </th>
   <th style="text-align:right;"> net_flows_reported_for_asset_smoothing </th>
   <th style="text-align:right;"> net_pension_liability_dollar </th>
   <th style="text-align:right;"> net_position_dollar </th>
   <th style="text-align:right;"> number_of_survivors </th>
   <th style="text-align:right;"> number_of_years_remaining_on_amortization_schedule </th>
   <th style="text-align:right;"> optional_benefits_available </th>
   <th style="text-align:right;"> other_actuarially_accured_liabilities_dollar </th>
   <th style="text-align:right;"> other_additions_dollar </th>
   <th style="text-align:right;"> other_benefits_paid_dollar </th>
   <th style="text-align:right;"> other_contribution_dollar </th>
   <th style="text-align:right;"> other_deductions_dollar </th>
   <th style="text-align:right;"> other_investments_dollar </th>
   <th style="text-align:right;"> other_investments_income_dollar </th>
   <th style="text-align:right;"> other_payments_dollar </th>
   <th style="text-align:right;"> other_receipts_paid_dollar </th>
   <th style="text-align:right;"> other_securities_investments_dollar </th>
   <th style="text-align:right;"> payroll_growth_assumption </th>
   <th style="text-align:right;"> percent_of_gain_loss_to_be_phased_in_this_year </th>
   <th style="text-align:left;"> plan_full_name </th>
   <th style="text-align:left;"> plan_name </th>
   <th style="text-align:right;"> plan_type </th>
   <th style="text-align:right;"> present_value_of_future_benefits_for_active_members_dollar </th>
   <th style="text-align:right;"> present_value_of_future_benefits_for_inactive_non_vested_members_dollar </th>
   <th style="text-align:right;"> present_value_of_future_benefits_for_inactive_vested_members_dollar </th>
   <th style="text-align:right;"> present_value_of_future_benefits_for_other_members_dollar </th>
   <th style="text-align:right;"> present_value_of_future_benefits_for_retired_members_dollar </th>
   <th style="text-align:right;"> present_value_of_future_normal_costs_total_dollar </th>
   <th style="text-align:right;"> projected_payroll_dollar </th>
   <th style="text-align:right;"> real_estate_income_dollar </th>
   <th style="text-align:right;"> real_estate_investments_dollar </th>
   <th style="text-align:right;"> receipts_for_transmittal_to_federal_social_security_system_dollar </th>
   <th style="text-align:right;"> refunds_dollar </th>
   <th style="text-align:right;"> rentals_from_state_government_dollar </th>
   <th style="text-align:right;"> retirement_benefits_paid_dollar </th>
   <th style="text-align:right;"> securities_lending_dollar </th>
   <th style="text-align:right;"> securities_lending_income_dollar </th>
   <th style="text-align:right;"> securities_lending_rebates_dollar </th>
   <th style="text-align:right;"> short_term_investments_dollar </th>
   <th style="text-align:right;"> smoothing_reset </th>
   <th style="text-align:left;"> social_security_coverage_of_plan_members </th>
   <th style="text-align:left;"> state_abbreviation </th>
   <th style="text-align:right;"> state_and_local_government_securitites_investments_dollar </th>
   <th style="text-align:right;"> state_contribution_for_employee_dollar </th>
   <th style="text-align:right;"> state_contribution_to_own_system_on_behalf_of_employees_dollar </th>
   <th style="text-align:right;"> state_employee_contribution_dollar </th>
   <th style="text-align:right;"> state_government_active_members </th>
   <th style="text-align:right;"> stocks_corporate_book_value_dollar </th>
   <th style="text-align:right;"> stocks_corporate_dollar </th>
   <th style="text-align:right;"> survivior_benefits_paid_dollar </th>
   <th style="text-align:right;"> survivors_receiving_lump_sum_payments </th>
   <th style="text-align:right;"> system_id </th>
   <th style="text-align:right;"> tier_id </th>
   <th style="text-align:right;"> time_or_savings_deposits_dollar </th>
   <th style="text-align:right;"> total_active_members </th>
   <th style="text-align:right;"> total_additions_dollar </th>
   <th style="text-align:right;"> total_amortization_payment_percentage </th>
   <th style="text-align:right;"> total_amount_of_active_salaries_payroll_in_dollars </th>
   <th style="text-align:right;"> total_benefits_paid_dollar </th>
   <th style="text-align:right;"> total_cash_and_securities_investments_dollar </th>
   <th style="text-align:right;"> total_contribution_dollar </th>
   <th style="text-align:right;"> total_corporate_bonds_investments_dollar </th>
   <th style="text-align:right;"> total_earnings_on_investments_dollar </th>
   <th style="text-align:right;"> total_normal_cost_percentage </th>
   <th style="text-align:right;"> total_normal_cost_percentage_estimated_categorical </th>
   <th style="text-align:right;"> total_number_of_beneficiaries </th>
   <th style="text-align:right;"> total_number_of_inactive_vested </th>
   <th style="text-align:right;"> total_number_of_members </th>
   <th style="text-align:right;"> total_number_of_other_beneficiaries </th>
   <th style="text-align:right;"> total_number_of_service_retirees </th>
   <th style="text-align:right;"> total_other_investments_dollar </th>
   <th style="text-align:right;"> total_other_securities_investments_dollar </th>
   <th style="text-align:right;"> total_pension_liability_dollar </th>
   <th style="text-align:right;"> total_projected_actuarial_required_contribution_percentage_of_payroll </th>
   <th style="text-align:left;"> type_of_employees_covered </th>
   <th style="text-align:right;"> unfunded_actuarially_accrued_liabilities_dollar </th>
   <th style="text-align:right;"> vesting_period </th>
   <th style="text-align:right;"> wage_inflation </th>
   <th style="text-align:right;"> year_of_inception </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2001 </td>
   <td style="text-align:right;"> 790 </td>
   <td style="text-align:left;"> Kansas Public Employees' Retirement System </td>
   <td style="text-align:left;"> Kansas </td>
   <td style="text-align:left;"> Census </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 65070000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 1679698000 </td>
   <td style="text-align:right;"> 1241346000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 312013000 </td>
   <td style="text-align:right;"> 40000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 138676000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 731892000 </td>
   <td style="text-align:right;"> 1581852000 </td>
   <td style="text-align:right;"> 849960000 </td>
   <td style="text-align:right;"> 438352000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 1253159000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 49741 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 28892 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 62243000 </td>
   <td style="text-align:right;"> 120365 </td>
   <td style="text-align:right;"> 54708000 </td>
   <td style="text-align:right;"> 1061275000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00e+00 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 42616243000 </td>
   <td style="text-align:right;"> 3958886000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 4561 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 482326000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 672675000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 311973000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 91161000 </td>
   <td style="text-align:right;"> 47515000 </td>
   <td style="text-align:right;"> 141900000 </td>
   <td style="text-align:right;"> 31228 </td>
   <td style="text-align:right;"> 3881374000 </td>
   <td style="text-align:right;"> 3881374000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 9863097000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 1679698000 </td>
   <td style="text-align:right;"> -779598000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 1155001000 </td>
   <td style="text-align:right;"> 1253159000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2001 </td>
   <td style="text-align:right;"> 790 </td>
   <td style="text-align:left;"> Kansas Public Employees' Retirement System </td>
   <td style="text-align:left;"> Kansas </td>
   <td style="text-align:left;"> Public Plans Database </td>
   <td style="text-align:right;"> -0.073 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0.055 </td>
   <td style="text-align:right;"> 0.094 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> Projected Unit Credit </td>
   <td style="text-align:right;"> 0.88 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> 2000-12-31 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 9835182000 </td>
   <td style="text-align:right;"> 11140014000 </td>
   <td style="text-align:right;"> 249356715 </td>
   <td style="text-align:right;"> 0.776 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> Kansas </td>
   <td style="text-align:right;"> -6843434 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> Expected value plus 1/3 of difference between market and expected </td>
   <td style="text-align:right;"> 43.94 </td>
   <td style="text-align:right;"> 73.09 </td>
   <td style="text-align:right;"> 73.09 </td>
   <td style="text-align:right;"> 9632 </td>
   <td style="text-align:right;"> 9632 </td>
   <td style="text-align:right;"> 31020 </td>
   <td style="text-align:right;"> 10.14 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 523942280 </td>
   <td style="text-align:right;"> 523942280 </td>
   <td style="text-align:left;"> http://www.kpers.org/active/benefits.html </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Multiemployer, cost sharing plan </td>
   <td style="text-align:right;"> 4876555000 </td>
   <td style="text-align:right;"> -8227488 </td>
   <td style="text-align:right;"> -46456603 </td>
   <td style="text-align:right;"> 37639689 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 204142810 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.04170 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 193384289 </td>
   <td style="text-align:right;"> 0.00633 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 0.06426 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> -1061275002 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> 2001-06-30 </td>
   <td style="text-align:right;"> 2004 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> Kansas </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> -0.07300 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0.035 </td>
   <td style="text-align:right;"> 239122780 </td>
   <td style="text-align:right;"> 201483091 </td>
   <td style="text-align:right;"> -23251905 </td>
   <td style="text-align:right;"> 0.08 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> -2024.120 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 9664667194 </td>
   <td style="text-align:right;"> 9664667194 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> -656169212 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 175815 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 556969 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> Kansas Public Employees Retirement System </td>
   <td style="text-align:left;"> Kansas PERS </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 4319879000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 4454208500 </td>
   <td style="text-align:right;"> 41997152 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> -43967623 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> -550674064 </td>
   <td style="text-align:right;"> -58226883 </td>
   <td style="text-align:right;"> 62950106 </td>
   <td style="text-align:right;"> -56202763 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> Plan members covered by Social Security </td>
   <td style="text-align:left;"> KS </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 35 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 143591 </td>
   <td style="text-align:right;"> -400423869 </td>
   <td style="text-align:right;"> 0.05793 </td>
   <td style="text-align:right;"> 4454193000 </td>
   <td style="text-align:right;"> -605358155 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 397527099 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0.04803 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 54396 </td>
   <td style="text-align:right;"> 35482 </td>
   <td style="text-align:right;"> 233469 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 54396 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0.10596 </td>
   <td style="text-align:left;"> Plan covers state and local employees </td>
   <td style="text-align:right;"> 1304832000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 1962 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2002 </td>
   <td style="text-align:right;"> 790 </td>
   <td style="text-align:left;"> Kansas Public Employees' Retirement System </td>
   <td style="text-align:left;"> Kansas </td>
   <td style="text-align:left;"> Census </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 36776000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 1000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 1686622000 </td>
   <td style="text-align:right;"> 356174000 </td>
   <td style="text-align:right;"> 495292000 </td>
   <td style="text-align:right;"> 2239000 </td>
   <td style="text-align:right;"> 7000 </td>
   <td style="text-align:right;"> 4000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 1000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 9980 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 161891000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 192872000 </td>
   <td style="text-align:right;"> 1290290000 </td>
   <td style="text-align:right;"> 1097418000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 1463113000 </td>
   <td style="text-align:right;"> 55611 </td>
   <td style="text-align:right;"> 458 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 31201 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 38677000 </td>
   <td style="text-align:right;"> 122894 </td>
   <td style="text-align:right;"> 59582000 </td>
   <td style="text-align:right;"> 240963000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 153557 </td>
   <td style="text-align:right;"> 4588435000 </td>
   <td style="text-align:right;"> 5.52e+08 </td>
   <td style="text-align:right;"> 583955000 </td>
   <td style="text-align:right;"> 46305349000 </td>
   <td style="text-align:right;"> 624000000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 1040 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 1000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 837398000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 17745000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 349793000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 493053000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 109431000 </td>
   <td style="text-align:right;"> 52460000 </td>
   <td style="text-align:right;"> 163004000 </td>
   <td style="text-align:right;"> 30663 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 2804000000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 138 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 9300427000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 2042796000 </td>
   <td style="text-align:right;"> 23567000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 1187191000 </td>
   <td style="text-align:right;"> 1480858000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 10000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2002 </td>
   <td style="text-align:right;"> 790 </td>
   <td style="text-align:left;"> Kansas Public Employees' Retirement System </td>
   <td style="text-align:left;"> Kansas </td>
   <td style="text-align:left;"> Public Plans Database </td>
   <td style="text-align:right;"> -0.047 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0.001 </td>
   <td style="text-align:right;"> 0.054 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> Projected Unit Credit </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> 2001-12-31 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 9962918000 </td>
   <td style="text-align:right;"> 11743052000 </td>
   <td style="text-align:right;"> 260482999 </td>
   <td style="text-align:right;"> 0.797 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> Kansas </td>
   <td style="text-align:right;"> -6776044 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> Level Percent Closed </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> Expected value plus 1/3 of difference between market and expected </td>
   <td style="text-align:right;"> 44.17 </td>
   <td style="text-align:right;"> 72.97 </td>
   <td style="text-align:right;"> 72.97 </td>
   <td style="text-align:right;"> 9958 </td>
   <td style="text-align:right;"> 9958 </td>
   <td style="text-align:right;"> 32041 </td>
   <td style="text-align:right;"> 10.21 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 558772440 </td>
   <td style="text-align:right;"> 558772440 </td>
   <td style="text-align:left;"> http://www.kpers.org/active/benefits.html </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Multiemployer, cost sharing plan </td>
   <td style="text-align:right;"> 5116384000 </td>
   <td style="text-align:right;"> -8694809 </td>
   <td style="text-align:right;"> -47625764 </td>
   <td style="text-align:right;"> 24416401 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 209624015 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.04170 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 221473727 </td>
   <td style="text-align:right;"> 0.04570 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 0.07141 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> -676384745 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> 2002-06-30 </td>
   <td style="text-align:right;"> 2005 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> Kansas </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> -0.06009 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0.035 </td>
   <td style="text-align:right;"> 183625585 </td>
   <td style="text-align:right;"> 159209184 </td>
   <td style="text-align:right;"> -19758136 </td>
   <td style="text-align:right;"> 0.08 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> -1422.527 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 8902288000 </td>
   <td style="text-align:right;"> 8902288000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> -729867044 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 31 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 137633 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 667029 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0.04 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> Kansas Public Employees Retirement System </td>
   <td style="text-align:left;"> Kansas PERS </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 4615163500 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 4672655000 </td>
   <td style="text-align:right;"> 44792323 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> -39066937 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> -627704056 </td>
   <td style="text-align:right;"> -29999829 </td>
   <td style="text-align:right;"> 33310814 </td>
   <td style="text-align:right;"> -28577302 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> Plan members covered by Social Security </td>
   <td style="text-align:left;"> KS </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 35 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 145910 </td>
   <td style="text-align:right;"> -32511584 </td>
   <td style="text-align:right;"> 0.02571 </td>
   <td style="text-align:right;"> 5116384500 </td>
   <td style="text-align:right;"> -684024629 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 431097742 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0.08512 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 56115 </td>
   <td style="text-align:right;"> 38056 </td>
   <td style="text-align:right;"> 240081 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 56115 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0.11311 </td>
   <td style="text-align:left;"> Plan covers state and local employees </td>
   <td style="text-align:right;"> 1780134000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0.04 </td>
   <td style="text-align:right;"> 1962 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2003 </td>
   <td style="text-align:right;"> 790 </td>
   <td style="text-align:left;"> Kansas Public Employees' Retirement System </td>
   <td style="text-align:left;"> Kansas </td>
   <td style="text-align:left;"> Census </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 23890000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 2029621000 </td>
   <td style="text-align:right;"> 620442000 </td>
   <td style="text-align:right;"> 542484000 </td>
   <td style="text-align:right;"> 3240000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 427 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 167238000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 163907000 </td>
   <td style="text-align:right;"> 353064000 </td>
   <td style="text-align:right;"> 189157000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 1651327000 </td>
   <td style="text-align:right;"> 57307 </td>
   <td style="text-align:right;"> 316 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 40404 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 45989000 </td>
   <td style="text-align:right;"> 121964 </td>
   <td style="text-align:right;"> 64227000 </td>
   <td style="text-align:right;"> 208412000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3445237000 </td>
   <td style="text-align:right;"> 9.96e+08 </td>
   <td style="text-align:right;"> 177140000 </td>
   <td style="text-align:right;"> 49168020000 </td>
   <td style="text-align:right;"> 950123000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 3560 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 966220000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 63687000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 168626000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 539244000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 113579000 </td>
   <td style="text-align:right;"> 53659000 </td>
   <td style="text-align:right;"> 178757000 </td>
   <td style="text-align:right;"> 25330 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 2992701000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 249 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 9388172000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 2650063000 </td>
   <td style="text-align:right;"> 30447000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 1134846000 </td>
   <td style="text-align:right;"> 1715014000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2003 </td>
   <td style="text-align:right;"> 790 </td>
   <td style="text-align:left;"> Kansas Public Employees' Retirement System </td>
   <td style="text-align:left;"> Kansas </td>
   <td style="text-align:left;"> Public Plans Database </td>
   <td style="text-align:right;"> 0.040 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> -0.028 </td>
   <td style="text-align:right;"> 0.031 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> Projected Unit Credit </td>
   <td style="text-align:right;"> 0.78 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> 2002-12-31 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 9784862000 </td>
   <td style="text-align:right;"> 12613599000 </td>
   <td style="text-align:right;"> 282329785 </td>
   <td style="text-align:right;"> 0.789 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> Kansas </td>
   <td style="text-align:right;"> -7215024 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> Level Percent Closed </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> Expected value plus 1/3 of difference between market and expected </td>
   <td style="text-align:right;"> 44.39 </td>
   <td style="text-align:right;"> 72.37 </td>
   <td style="text-align:right;"> 72.37 </td>
   <td style="text-align:right;"> 10425 </td>
   <td style="text-align:right;"> 10425 </td>
   <td style="text-align:right;"> 32984 </td>
   <td style="text-align:right;"> 10.37 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 600463000 </td>
   <td style="text-align:right;"> 600463000 </td>
   <td style="text-align:left;"> http://www.kpers.org/active/benefits.html </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Multiemployer, cost sharing plan </td>
   <td style="text-align:right;"> 4865903000 </td>
   <td style="text-align:right;"> -7826064 </td>
   <td style="text-align:right;"> -53829235 </td>
   <td style="text-align:right;"> 76508361 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 224746447 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.04172 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 231464323 </td>
   <td style="text-align:right;"> 0.05034 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 0.08483 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 85223479 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> 2003-06-30 </td>
   <td style="text-align:right;"> 2006 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> Kansas </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> -0.02785 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0.035 </td>
   <td style="text-align:right;"> 221919646 </td>
   <td style="text-align:right;"> 145411285 </td>
   <td style="text-align:right;"> -16675173 </td>
   <td style="text-align:right;"> 0.08 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> -1214.021 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 8930442322 </td>
   <td style="text-align:right;"> 8930442322 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> -754195348 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 82257 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 557611 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0.04 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> Kansas Public Employees Retirement System </td>
   <td style="text-align:left;"> Kansas PERS </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 5056236500 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 4865903000 </td>
   <td style="text-align:right;"> 31217255 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> -39608946 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> -645716079 </td>
   <td style="text-align:right;"> -22075119 </td>
   <td style="text-align:right;"> 25878944 </td>
   <td style="text-align:right;"> -20861098 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> Plan members covered by Social Security </td>
   <td style="text-align:left;"> KS </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 35 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 147294 </td>
   <td style="text-align:right;"> 782349670 </td>
   <td style="text-align:right;"> 0.03450 </td>
   <td style="text-align:right;"> 4865903000 </td>
   <td style="text-align:right;"> -707371378 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 456210770 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0.09206 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 57597 </td>
   <td style="text-align:right;"> 40404 </td>
   <td style="text-align:right;"> 245295 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 57597 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0.12655 </td>
   <td style="text-align:left;"> Plan covers state and local employees </td>
   <td style="text-align:right;"> 2828736000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0.04 </td>
   <td style="text-align:right;"> 1962 </td>
  </tr>
</tbody>
</table>
### `filterData()`

5. `filterData()`: filters existing data (data.frame/data.table format) keeping & renaming set of commonly used variables in pension analysis. `filterData` has 3 arguments:

* `Data`: A data table already pulled with `pullData`, `pullStateData`, or other ways. 
* `fy`: Starting fiscal year for the data pulled from the Reason pension database.
* `source`: Set to `FALSE`. It should be set to `source = TRUE` if you filter data pulled with `pullSourceData` function.

Example of the workflow around the filtering function:


```r
state.data <- pullStateData(2001)
filtered <- filterData(state.data, 2010, FALSE)
filtered %>% 
  head() %>%
  kable() %>%
  kable_styling(full_width = FALSE, position = "left")
```

<table class="table" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;"> year </th>
   <th style="text-align:left;"> plan_name </th>
   <th style="text-align:left;"> state </th>
   <th style="text-align:left;"> return_1yr </th>
   <th style="text-align:left;"> actuarial_cost_method_in_gasb_reporting </th>
   <th style="text-align:left;"> funded_ratio </th>
   <th style="text-align:left;"> ava </th>
   <th style="text-align:left;"> mva </th>
   <th style="text-align:left;"> aal </th>
   <th style="text-align:left;"> tpl </th>
   <th style="text-align:left;"> adec </th>
   <th style="text-align:left;"> adec_paid_pct </th>
   <th style="text-align:left;"> statutory </th>
   <th style="text-align:left;"> statutory_pct </th>
   <th style="text-align:left;"> amortizaton_method </th>
   <th style="text-align:left;"> total_benefit_payments </th>
   <th style="text-align:left;"> benefit_payments </th>
   <th style="text-align:left;"> refunds </th>
   <th style="text-align:left;"> admin_exp </th>
   <th style="text-align:left;"> cost_structure </th>
   <th style="text-align:left;"> payroll </th>
   <th style="text-align:left;"> ee_contribution </th>
   <th style="text-align:left;"> ee_nc_pct </th>
   <th style="text-align:left;"> er_contribution </th>
   <th style="text-align:left;"> er_nc_pct </th>
   <th style="text-align:left;"> er_state_contribution </th>
   <th style="text-align:left;"> er_proj_adec_pct </th>
   <th style="text-align:left;"> other_contribution </th>
   <th style="text-align:left;"> other_additions </th>
   <th style="text-align:left;"> fy_contribution </th>
   <th style="text-align:left;"> inflation_assum </th>
   <th style="text-align:left;"> arr </th>
   <th style="text-align:left;"> dr </th>
   <th style="text-align:left;"> number_of_years_remaining_on_amortization_schedule </th>
   <th style="text-align:left;"> payroll_growth_assumption </th>
   <th style="text-align:left;"> total_amortization_payment_pct </th>
   <th style="text-align:left;"> total_contribution </th>
   <th style="text-align:left;"> total_nc_pct </th>
   <th style="text-align:left;"> total_number_of_members </th>
   <th style="text-align:left;"> total_proj_adec_pct </th>
   <th style="text-align:left;"> type_of_employees_covered </th>
   <th style="text-align:left;"> unfunded_actuarially_accrued_liabilities_dollar </th>
   <th style="text-align:left;"> wage_inflation </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2010 </td>
   <td style="text-align:left;"> Alabama Employees' Retirement System (ERS) </td>
   <td style="text-align:left;"> Alabama </td>
   <td style="text-align:left;"> 0.0847 </td>
   <td style="text-align:left;"> Entry Age Normal </td>
   <td style="text-align:left;"> 0.682 </td>
   <td style="text-align:left;"> 9739331000 </td>
   <td style="text-align:left;"> 8176732000 </td>
   <td style="text-align:left;"> 14284119000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 377898000 </td>
   <td style="text-align:left;"> 1.0 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> Level Percent Open </td>
   <td style="text-align:left;"> -759528000 </td>
   <td style="text-align:left;"> 778328440 </td>
   <td style="text-align:left;"> 24874000 </td>
   <td style="text-align:left;"> -10334000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 3619670000 </td>
   <td style="text-align:left;"> 194968000 </td>
   <td style="text-align:left;"> 0.0502 </td>
   <td style="text-align:left;"> 377898000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 147593000 </td>
   <td style="text-align:left;"> 0.0795 </td>
   <td style="text-align:left;"> 1790000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 0.08 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 29.0 </td>
   <td style="text-align:left;"> 0.045 </td>
   <td style="text-align:left;"> 0.0491 </td>
   <td style="text-align:left;"> 574656000 </td>
   <td style="text-align:left;"> 0.0806 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> Plan covers state and local employees </td>
   <td style="text-align:left;"> 4544788000 </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2011 </td>
   <td style="text-align:left;"> Alabama Employees' Retirement System (ERS) </td>
   <td style="text-align:left;"> Alabama </td>
   <td style="text-align:left;"> 0.0221 </td>
   <td style="text-align:left;"> Entry Age Normal </td>
   <td style="text-align:left;"> 0.658 </td>
   <td style="text-align:left;"> 9456158000 </td>
   <td style="text-align:left;"> 8130435000 </td>
   <td style="text-align:left;"> 14366796000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 394998000 </td>
   <td style="text-align:left;"> 1.0 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> Level Percent Open </td>
   <td style="text-align:left;"> -819755000 </td>
   <td style="text-align:left;"> 827273750 </td>
   <td style="text-align:left;"> 36798000 </td>
   <td style="text-align:left;"> -10002000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 3540681000 </td>
   <td style="text-align:left;"> 193697000 </td>
   <td style="text-align:left;"> 0.0501 </td>
   <td style="text-align:left;"> 394998000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 183221000 </td>
   <td style="text-align:left;"> 0.1126 </td>
   <td style="text-align:left;"> 2012000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 0.08 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 29.0 </td>
   <td style="text-align:left;"> 0.0325 </td>
   <td style="text-align:left;"> 0.0849 </td>
   <td style="text-align:left;"> 590707000 </td>
   <td style="text-align:left;"> 0.0778 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> Plan covers state and local employees </td>
   <td style="text-align:left;"> 4910638000 </td>
   <td style="text-align:left;"> 0.0325 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2012 </td>
   <td style="text-align:left;"> Alabama Employees' Retirement System (ERS) </td>
   <td style="text-align:left;"> Alabama </td>
   <td style="text-align:left;"> 0.1801 </td>
   <td style="text-align:left;"> Entry Age Normal </td>
   <td style="text-align:left;"> 0.657 </td>
   <td style="text-align:left;"> 9116551000 </td>
   <td style="text-align:left;"> 9188696000 </td>
   <td style="text-align:left;"> 13884995000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 317520000 </td>
   <td style="text-align:left;"> 1.0 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> Level Percent Open </td>
   <td style="text-align:left;"> -889210000 </td>
   <td style="text-align:left;"> 864958380 </td>
   <td style="text-align:left;"> 40746000 </td>
   <td style="text-align:left;"> -10616000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 3252003000 </td>
   <td style="text-align:left;"> 214933000 </td>
   <td style="text-align:left;"> 0.0726 </td>
   <td style="text-align:left;"> 317520000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 118646000 </td>
   <td style="text-align:left;"> 0.1198 </td>
   <td style="text-align:left;"> 1937000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 0.08 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 28.0 </td>
   <td style="text-align:left;"> 0.0325 </td>
   <td style="text-align:left;"> 0.096 </td>
   <td style="text-align:left;"> 534390000 </td>
   <td style="text-align:left;"> 0.0964 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> Plan covers state and local employees </td>
   <td style="text-align:left;"> 4768444000 </td>
   <td style="text-align:left;"> 0.0325 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2013 </td>
   <td style="text-align:left;"> Alabama Employees' Retirement System (ERS) </td>
   <td style="text-align:left;"> Alabama </td>
   <td style="text-align:left;"> 0.146 </td>
   <td style="text-align:left;"> Entry Age Normal </td>
   <td style="text-align:left;"> 0.657 </td>
   <td style="text-align:left;"> 9546459000 </td>
   <td style="text-align:left;"> 10091940000 </td>
   <td style="text-align:left;"> 14536600000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 338819000 </td>
   <td style="text-align:left;"> 1.0 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> Level Percent Closed </td>
   <td style="text-align:left;"> -940312000 </td>
   <td style="text-align:left;"> 898211880 </td>
   <td style="text-align:left;"> 44837000 </td>
   <td style="text-align:left;"> -9767000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 3400596000 </td>
   <td style="text-align:left;"> 221823000 </td>
   <td style="text-align:left;"> 0.0748 </td>
   <td style="text-align:left;"> 338819000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 125363000 </td>
   <td style="text-align:left;"> 0.1222 </td>
   <td style="text-align:left;"> 1823000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 0.08 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 28.0 </td>
   <td style="text-align:left;"> 0.0325 </td>
   <td style="text-align:left;"> 0.0971 </td>
   <td style="text-align:left;"> 562465000 </td>
   <td style="text-align:left;"> 0.0999 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> Plan covers state and local employees </td>
   <td style="text-align:left;"> 4990141000 </td>
   <td style="text-align:left;"> 0.0325 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2014 </td>
   <td style="text-align:left;"> Alabama Employees' Retirement System (ERS) </td>
   <td style="text-align:left;"> Alabama </td>
   <td style="text-align:left;"> 0.1202 </td>
   <td style="text-align:left;"> Entry Age Normal </td>
   <td style="text-align:left;"> 0.669 </td>
   <td style="text-align:left;"> 10134581000 </td>
   <td style="text-align:left;"> 10883952000 </td>
   <td style="text-align:left;"> 15138294000 </td>
   <td style="text-align:left;"> 15525291000 </td>
   <td style="text-align:left;"> 379163000 </td>
   <td style="text-align:left;"> 0.0 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> Level Percent Closed </td>
   <td style="text-align:left;"> -996414000 </td>
   <td style="text-align:left;"> 930223380 </td>
   <td style="text-align:left;"> 47937000 </td>
   <td style="text-align:left;"> -9612000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 3444341000 </td>
   <td style="text-align:left;"> 223135000 </td>
   <td style="text-align:left;"> 0.0746 </td>
   <td style="text-align:left;"> 391181000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 144736000 </td>
   <td style="text-align:left;"> 0.1195 </td>
   <td style="text-align:left;"> 2881000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 0.08 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 28.0 </td>
   <td style="text-align:left;"> 0.0325 </td>
   <td style="text-align:left;"> 0.0943 </td>
   <td style="text-align:left;"> 617197000 </td>
   <td style="text-align:left;"> 0.0998 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> Plan covers state and local employees </td>
   <td style="text-align:left;"> 5003713000 </td>
   <td style="text-align:left;"> 0.0325 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2015 </td>
   <td style="text-align:left;"> Alabama Employees' Retirement System (ERS) </td>
   <td style="text-align:left;"> Alabama </td>
   <td style="text-align:left;"> 0.0105 </td>
   <td style="text-align:left;"> Entry Age Normal </td>
   <td style="text-align:left;"> 0.673 </td>
   <td style="text-align:left;"> 10589258000 </td>
   <td style="text-align:left;"> 10551904000 </td>
   <td style="text-align:left;"> 15723720000 </td>
   <td style="text-align:left;"> 15961667000 </td>
   <td style="text-align:left;"> 411087000 </td>
   <td style="text-align:left;"> 1.0 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> Level Percent Closed </td>
   <td style="text-align:left;"> -1069539000 </td>
   <td style="text-align:left;"> 966982560 </td>
   <td style="text-align:left;"> 51024000 </td>
   <td style="text-align:left;"> -11136000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 3488017000 </td>
   <td style="text-align:left;"> 225767000 </td>
   <td style="text-align:left;"> 0.0744 </td>
   <td style="text-align:left;"> 410932000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 136977000 </td>
   <td style="text-align:left;"> 0.117 </td>
   <td style="text-align:left;"> 3487000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 0.08 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 28.0 </td>
   <td style="text-align:left;"> 0.0325 </td>
   <td style="text-align:left;"> 0.0921 </td>
   <td style="text-align:left;"> 640186000 </td>
   <td style="text-align:left;"> 0.0993 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> Plan covers state and local employees </td>
   <td style="text-align:left;"> 5134462000 </td>
   <td style="text-align:left;"> 0.0325 </td>
  </tr>
</tbody>
</table>
### `loadData`

6. `loadData`: loads the data for a specified plan from an Excel file. `loadData` has one argument:

`loadData(file_name)`

* `file_name`: A string enclosed in quotation marks containing a file name with path of a pension plan Excel data file.

```
data_from_file <- loadData('data/NorthCarolina_PensionDatabase_TSERS.xlsx')
```

### `selectedData()`

7. `selectedData()`: selects the only the variables used in historical analyses. `selectedData` has one argument, `wide_data`, that is required:

`selectedData(wide_data)`

* `wide_data`: a datasource in wide format

Back to the Kansas Public Employees' example. That is a lot of variables. The `selectedData()` function selects only a handful of needed variables:


```r
df <- selectedData(vtsrs_data)
#> Error: Can't subset columns that don't exist.
#> [31mx[39m Column `actuarial_valuation_date_for_gasb_schedules` doesn't exist.
df %>% 
  head() %>%
  kable() %>%
  kable_styling(full_width = FALSE, position = "left")
```

<table class="table" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;">  </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> function (x, df1, df2, ncp, log = FALSE) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> { </td>
  </tr>
  <tr>
   <td style="text-align:left;"> if (missing(ncp)) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> .Call(C_df, x, df1, df2, log) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> else .Call(C_dnf, x, df1, df2, ncp, log) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> } </td>
  </tr>
</tbody>
</table>

### `glPlot()`

8. `glPlot()`: creates the 'Gain/Loss' plot using a CSV file as an input. glPlot has two arguments:

`glPlot(filename, ylab_unit)`

* `filename`: a csv (comma separated value) file containing columns of gain loss category names with one row of values.
* `ylab_unit`: a string contained within quotation marks containing th y-axis label unit. The default value is "Billions"

Example of how it is used in a standard workflow:

```
filename <- "data/GainLoss_data.csv"
glPlot(filename)
```

### `linePlot()`

9. `linePlot()`: creates a plot comparing two variables, such as ADEC vs. Actual contributions. `linePlot()` has six arguments, with `data` being required:

`linePlot(data, .var1, .var2, labelY, label1, label2)`

* `data` a dataframe produced by the selectedData function or in the same format.
* `.var1` The name of the first variable to plat, default is adec_contribution_rates.
* `.var2` The name of the second variable to plot, default if actual_contribution_rates.
* `labelY` A label for the Y-axis.
* `label1` A label for the first variable.
* `label2` A label for the second variable.


```r
linePlot(df)
#> Error in UseMethod("select_"): no applicable method for 'select_' applied to an object of class "function"
```

### `debtPlot()`

10. `debtPlot()`: creates the "History of Volatile Solvency" or "Mountain of Debt" chart. `debtPlot` takes one argument:

`debtPlot(data)`

* `data`: a dataframe produced by the `selectedData()` function or in the same format containing year, uaal, funded ratio columns.


```r
debtPlot(df)
#> Error in UseMethod("filter_"): no applicable method for 'filter_' applied to an object of class "function"
```

### `savePlot()`

11. `savePlot()`: adds a source and save ggplot chart. `savePlot` takes five arguments:
`savePlot(plot = myplot, source = "The source for my data", save_filepath = "filename_that_my_plot_should_be_saved_to.png", width_pixels = 648, height_pixels = 384.48)`

* `plot`: The variable name of the plot you have created that you want to format and save
* `source`: The text you want to come after the text 'Source:' in the bottom left hand side of your side
* `save_filepath`: Exact filepath that you want the plot to be saved to
* `width_pixels`: Width in pixels that you want to save your chart to - defaults to 648
* `height_pixels`: Height in pixels that you want to save your chart to - defaults to 384.48

```
savePlot(debt_plot, source = "Source: KPERS", save_filepath = "output/test.png")
```


The BBC has created a wonderful data journalism cookbook for R graphics located here:
https://bbc.github.io/rcookbook/




