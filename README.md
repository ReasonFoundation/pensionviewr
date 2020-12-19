---
output: github_document
always_allow_html: yes
---
knitr::knit("README.Rmd")
<!-- README.md is generated from README.Rmd. Please edit that file -->



# pensionviewr

The goal of `pensionviewr` is to simplify the process of gathering and visualizing public pension plan data from the Reason pension database. This repo contains the functions of the `pensionviewr` package, which once installed locally, provides helpful functions for creating and exporting graphics made in ggplot in the style used by the Reason Pension Integrity Project team.

## Create Token:
To use devtools you'd need to authenticate yourself by
creating Personal Access Tokens (PAT):

  - Obtain a PAT by typing `usethis::browse_github_pat()`.
Click "Generate token" and Copy to Clipboard the displayed string of 40 letters/digits.
  - Find your .Renviron in your home directory by typing:
`usethis::edit_r_environ()`
  - Put your PAT in your .Renviron file. Have a line that looks like this:
`GITHUB_PAT=8c70fd8419398999c9ac5bacf3192882193cadf2` (but use your own PAT instead)
  - Save edited .Renviron file, and
  - Lastly, restart R & check your PAT by typing:
`Sys.getenv("GITHUB_PAT")`
## Installing pensionviewr

`pensionviewr` is not on CRAN, so you will have to install it directly from Github using `devtools`. 

If you do not have the `devtools` package installed, you will have to run the first line in the code below as well. 

``` r
install.packages('devtools')
devtools::install_github("ReasonFoundation/pensionviewr")
```

## Using the functions:

* The package has seven functions for data pulling and preparation: 
`planList()`, 
`pullData()`, 
`pullStateData()`,
`pullSourceData()`,
`filterData()`,
`masterView()`,
`loadData()`, and 
`selectedData()`.

* The package has four functions for plots: 
`glPlot()`, 
`linePlot()`, 
`areaPlot()`, and 
`savePlot()`.

* The package has Reason color palette: 
`palette_reason` (e.g. `palette_reason$Orange`))

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

* `pl`: A dataframe containing the list of plan names, states, and ids in the form produced by the `planList()` function.
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
   <th style="text-align:right;"> adec_as_a_percent_of_payroll </th>
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
   <th style="text-align:right;"> market_investment_return_mva_basis </th>
   <th style="text-align:right;"> market_value_of_assets_dollar </th>
   <th style="text-align:right;"> market_value_of_assets_net_of_fees_dollar </th>
   <th style="text-align:left;"> measurment_date_md </th>
   <th style="text-align:right;"> members_covered_by_social_security </th>
   <th style="text-align:right;"> membership_data_active </th>
   <th style="text-align:right;"> membership_data_inactive_vested </th>
   <th style="text-align:right;"> membership_data_retirees_and_beneficiaries </th>
   <th style="text-align:right;"> membership_data_total </th>
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
   <th style="text-align:right;"> net_pension_liability_assuming_1_percent_decrease_in_discount_rate </th>
   <th style="text-align:right;"> net_pension_liability_assuming_1_percent_increase_in_discount_rate </th>
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
   <th style="text-align:left;"> prior_measurment_date </th>
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
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
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
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
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
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
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
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
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
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
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
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
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
`pullStateData(fy)`

* `fy`: Starting fiscal year for the data pulled from the Reason pension database.

This could be the initial step for either making state-level pension analysis or then filter pulled data for a specific state plan.
Example of how it is used in a standard workflow:


```r
state.data <- pullStateData(2001)
New_Mexico.data <- state.data %>% filter(state == 'New Mexico')
NMERB.data <- state.data %>% filter(display_name == "New Mexico Educational Retirement Board")
state.data <- state.data %>% filter(year == 2019)#filter for 2019 for display
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
   <th style="text-align:left;"> employer_state_contribution_dollar </th>
   <th style="text-align:left;"> type_of_employees_covered </th>
   <th style="text-align:left;"> discount_rate_assumption </th>
   <th style="text-align:left;"> covered_payroll_dollar </th>
   <th style="text-align:left;"> actuarial_cost_method_in_gasb_reporting </th>
   <th style="text-align:left;"> actuarially_accrued_liabilities_dollar </th>
   <th style="text-align:left;"> number_of_years_remaining_on_amortization_schedule </th>
   <th style="text-align:left;"> market_assets_reported_for_asset_smoothing </th>
   <th style="text-align:left;"> total_benefits_paid_dollar </th>
   <th style="text-align:left;"> x1_year_investment_return_percentage </th>
   <th style="text-align:left;"> fiscal_year_of_contribution </th>
   <th style="text-align:left;"> benefit_payments_dollar </th>
   <th style="text-align:left;"> other_contribution_dollar </th>
   <th style="text-align:left;"> asset_valuation_method_for_gasb_reporting </th>
   <th style="text-align:left;"> employer_contribution_regular_dollar </th>
   <th style="text-align:left;"> refunds_dollar </th>
   <th style="text-align:left;"> total_normal_cost_percentage </th>
   <th style="text-align:left;"> unfunded_actuarially_accrued_liabilities_dollar </th>
   <th style="text-align:left;"> employee_normal_cost_percentage </th>
   <th style="text-align:left;"> total_normal_cost_dollar </th>
   <th style="text-align:left;"> statutory_payment_dollar </th>
   <th style="text-align:left;"> payroll_growth_assumption </th>
   <th style="text-align:left;"> market_value_of_assets_dollar </th>
   <th style="text-align:left;"> actuarial_value_of_assets_gasb_dollar </th>
   <th style="text-align:left;"> amortizaton_method </th>
   <th style="text-align:left;"> total_contribution_dollar </th>
   <th style="text-align:left;"> wage_inflation </th>
   <th style="text-align:left;"> market_investment_return_mva_basis </th>
   <th style="text-align:left;"> actuarially_required_contribution_paid_percentage </th>
   <th style="text-align:left;"> total_pension_liability_dollar </th>
   <th style="text-align:left;"> employers_projected_actuarial_required_contribution_percentage_of_payroll </th>
   <th style="text-align:left;"> statutory_payment_percentage </th>
   <th style="text-align:left;"> employee_contribution_dollar </th>
   <th style="text-align:left;"> employer_normal_cost_dollar </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Alabama Employees' Retirement System (ERS) </td>
   <td style="text-align:left;"> Alabama </td>
   <td style="text-align:left;"> 0.077 </td>
   <td style="text-align:left;"> 0.682 </td>
   <td style="text-align:left;"> 467553000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> -12934000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> Plan covers state and local employees </td>
   <td style="text-align:left;"> 0.077 </td>
   <td style="text-align:left;"> 3793957000 </td>
   <td style="text-align:left;"> Entry Age Normal </td>
   <td style="text-align:left;"> 18543542000 </td>
   <td style="text-align:left;"> 28.0 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> -1171825000 </td>
   <td style="text-align:left;"> 0.0278 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 1084915300 </td>
   <td style="text-align:left;"> 4187000 </td>
   <td style="text-align:left;"> 5-year smoothed market </td>
   <td style="text-align:left;"> 467553000 </td>
   <td style="text-align:left;"> 47683000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 5897753000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 12568473000 </td>
   <td style="text-align:left;"> 12240597000 </td>
   <td style="text-align:left;"> Level Percent Closed </td>
   <td style="text-align:left;"> 721993000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 1.0 </td>
   <td style="text-align:left;"> 18353891000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 254439719 </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> Alabama Teachers' Retirement System (TRS) </td>
   <td style="text-align:left;"> Alabama </td>
   <td style="text-align:left;"> 0.077 </td>
   <td style="text-align:left;"> 0.694 </td>
   <td style="text-align:left;"> 869336000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> -20583000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> Plan covers teachers </td>
   <td style="text-align:left;"> 0.077 </td>
   <td style="text-align:left;"> 7193832000 </td>
   <td style="text-align:left;"> Entry Age Normal </td>
   <td style="text-align:left;"> 37215470000 </td>
   <td style="text-align:left;"> 28.0 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> -2290375000 </td>
   <td style="text-align:left;"> 0.0263 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 2191704800 </td>
   <td style="text-align:left;"> 6234000 </td>
   <td style="text-align:left;"> 5-year smoothed market related value. </td>
   <td style="text-align:left;"> 869336000 </td>
   <td style="text-align:left;"> 58538000 </td>
   <td style="text-align:left;"> 0.09866 </td>
   <td style="text-align:left;"> 11394144000 </td>
   <td style="text-align:left;"> 0.07137 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 25619448000 </td>
   <td style="text-align:left;"> 25006419000 </td>
   <td style="text-align:left;"> Level Percent Closed </td>
   <td style="text-align:left;"> 1392245000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 1.0 </td>
   <td style="text-align:left;"> 36676350000 </td>
   <td style="text-align:left;"> 0.12084 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 522908600 </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:left;"> Alaska Public Employees Retirement System </td>
   <td style="text-align:left;"> Alaska </td>
   <td style="text-align:left;"> 0.0738 </td>
   <td style="text-align:left;"> 0.637 </td>
   <td style="text-align:left;"> 414243000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> -7429000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> Plan covers state and local employees </td>
   <td style="text-align:left;"> 0.0738 </td>
   <td style="text-align:left;"> 1049152000 </td>
   <td style="text-align:left;"> Entry Age Normal </td>
   <td style="text-align:left;"> 15039180000 </td>
   <td style="text-align:left;"> 25.0 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> -837381000 </td>
   <td style="text-align:left;"> 0.059 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 822390940 </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 5-year smoothed market </td>
   <td style="text-align:left;"> 350601000 </td>
   <td style="text-align:left;"> -10638000 </td>
   <td style="text-align:left;"> 0.1495 </td>
   <td style="text-align:left;"> 5462487000 </td>
   <td style="text-align:left;"> 0.06937 </td>
   <td style="text-align:left;"> 156862000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 9489405000 </td>
   <td style="text-align:left;"> 9430192000 </td>
   <td style="text-align:left;"> Level Percent Closed </td>
   <td style="text-align:left;"> 498067000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 0.054 </td>
   <td style="text-align:left;"> 1.0101799999999999 </td>
   <td style="text-align:left;"> 14963635000 </td>
   <td style="text-align:left;"> 0.42887 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 79609000 </td>
   <td style="text-align:left;"> 84080453 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:left;"> Alaska Teachers Retirement System </td>
   <td style="text-align:left;"> Alaska </td>
   <td style="text-align:left;"> 0.0738 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 154083000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> -3018000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> Plan covers teachers </td>
   <td style="text-align:left;"> 0.0738 </td>
   <td style="text-align:left;"> 392609000 </td>
   <td style="text-align:left;"> Entry Age Normal </td>
   <td style="text-align:left;"> 7276290000 </td>
   <td style="text-align:left;"> 25.0 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> -470414000 </td>
   <td style="text-align:left;"> 0.0639 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 470498280 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 5-year smoothed market </td>
   <td style="text-align:left;"> 36805000 </td>
   <td style="text-align:left;"> -2303000 </td>
   <td style="text-align:left;"> 0.1463 </td>
   <td style="text-align:left;"> 1734690000 </td>
   <td style="text-align:left;"> 0.046 </td>
   <td style="text-align:left;"> 57447000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 5511929000 </td>
   <td style="text-align:left;"> 5541600000 </td>
   <td style="text-align:left;"> Level Percent Closed </td>
   <td style="text-align:left;"> 199933000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 1.0654700000000001 </td>
   <td style="text-align:left;"> 7380472000 </td>
   <td style="text-align:left;"> 1.9817200000000001 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 35763000 </td>
   <td style="text-align:left;"> 39386984 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:right;"> 33 </td>
   <td style="text-align:left;"> Arizona Corrections Officers Retirement Plan </td>
   <td style="text-align:left;"> Arizona </td>
   <td style="text-align:left;"> 0.073 </td>
   <td style="text-align:left;"> 0.531 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 0.24026 </td>
   <td style="text-align:left;"> -1448000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> Plan covers police and/or fire </td>
   <td style="text-align:left;"> 0.073 </td>
   <td style="text-align:left;"> 547363066 </td>
   <td style="text-align:left;"> Entry Age Normal </td>
   <td style="text-align:left;"> 3884070116 </td>
   <td style="text-align:left;"> 17.0 </td>
   <td style="text-align:left;"> 1996273344 </td>
   <td style="text-align:left;"> -125481000 </td>
   <td style="text-align:left;"> 0.0545 </td>
   <td style="text-align:left;"> 2021.0 </td>
   <td style="text-align:left;"> 160313590 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 7-year smoothed market:; subject to a 20% corridor. </td>
   <td style="text-align:left;"> 137441000 </td>
   <td style="text-align:left;"> -28530000 </td>
   <td style="text-align:left;"> 0.15108 </td>
   <td style="text-align:left;"> 1820717876 </td>
   <td style="text-align:left;"> 0.08398 </td>
   <td style="text-align:left;"> 83256164 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 1996513000 </td>
   <td style="text-align:left;"> 2063352240 </td>
   <td style="text-align:left;"> Level Percent Closed </td>
   <td style="text-align:left;"> 176123000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 0.30738000000000004 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 48549598 </td>
   <td style="text-align:left;"> 36968238 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:left;"> Arizona Public Safety Personnel Retirement System </td>
   <td style="text-align:left;"> Arizona </td>
   <td style="text-align:left;"> 0.073 </td>
   <td style="text-align:left;"> 0.46399999999999997 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 0.37037 </td>
   <td style="text-align:left;"> -7251000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> Plan covers police and/or fire </td>
   <td style="text-align:left;"> 0.073 </td>
   <td style="text-align:left;"> 1419642895 </td>
   <td style="text-align:left;"> Entry Age Normal </td>
   <td style="text-align:left;"> 17393828992 </td>
   <td style="text-align:left;"> 17.0 </td>
   <td style="text-align:left;"> 7810990750 </td>
   <td style="text-align:left;"> -818430000 </td>
   <td style="text-align:left;"> 0.054 </td>
   <td style="text-align:left;"> 2021.0 </td>
   <td style="text-align:left;"> 850051750 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 7-year smoothed market value. 20% corridor. </td>
   <td style="text-align:left;"> 832026000 </td>
   <td style="text-align:left;"> -15633000 </td>
   <td style="text-align:left;"> 0.22053000000000003 </td>
   <td style="text-align:left;"> 9314789253 </td>
   <td style="text-align:left;"> 0.07769 </td>
   <td style="text-align:left;"> 335921280 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 0.035 </td>
   <td style="text-align:left;"> 7829913000 </td>
   <td style="text-align:left;"> 8097785858 </td>
   <td style="text-align:left;"> Level Percent Closed </td>
   <td style="text-align:left;"> 980958000 </td>
   <td style="text-align:left;"> 0.035 </td>
   <td style="text-align:left;"> 0.067 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 0.5132 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 121556582 </td>
   <td style="text-align:left;"> 217577090 </td>
  </tr>
</tbody>
</table>

### `pullSourceData()`

4. `pullSourceData()`: pulls pension data for a specific plan, along with `data_source_name` column in wide format from the Reason pension database. `pullSourceData(pl,plan_name, fy)` has 3 arguments:

* `pl`: A dataframe containing the list of plan names, states, and ids in the form produced by the `planList()` function.
* `plan_name`: A string enclosed in quotation marks containing a plan name as it is listed in the Reason pension database.
* `fy`: Starting fiscal year for the data pulled from the Reason pension database.

Example how this function is used:


```r
NMERB.source <- pullSourceData(pl, "New Mexico Educational Retirement Board", 2001)
NMERB.source %>% 
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
   <th style="text-align:right;"> x15_year_investment_return_percentage </th>
   <th style="text-align:right;"> x20_year_investment_return_percentage </th>
   <th style="text-align:right;"> x25_year_investment_return_percentage </th>
   <th style="text-align:right;"> x3_year_investment_return_percentage </th>
   <th style="text-align:right;"> x30_year_investment_return_percentage </th>
   <th style="text-align:right;"> x5_year_investment_return_percentage </th>
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
   <th style="text-align:right;"> adec_as_a_percent_of_payroll </th>
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
   <th style="text-align:right;"> average_benefit_of_beneficiaries </th>
   <th style="text-align:right;"> average_benefit_paid_to_service_retirees </th>
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
   <th style="text-align:right;"> changes_to_methods_assumptions_dollar </th>
   <th style="text-align:right;"> closed_plan </th>
   <th style="text-align:right;"> cost_sharing </th>
   <th style="text-align:left;"> cost_structure </th>
   <th style="text-align:right;"> covered_payroll_dollar </th>
   <th style="text-align:right;"> disability_benefits_paid_dollar </th>
   <th style="text-align:right;"> discount_rate_assumption </th>
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
   <th style="text-align:right;"> interest_on_debt_dollar </th>
   <th style="text-align:right;"> investment_expenses_dollar </th>
   <th style="text-align:right;"> investment_experience_dollar </th>
   <th style="text-align:right;"> investment_return_assumption_for_gasb_reporting </th>
   <th style="text-align:right;"> investments_held_in_trust_by_other_agencies_dollar </th>
   <th style="text-align:right;"> legislative_changes_dollar </th>
   <th style="text-align:right;"> local_employee_contribution_dollar </th>
   <th style="text-align:right;"> local_government_active_members </th>
   <th style="text-align:right;"> local_government_contribution_dollar </th>
   <th style="text-align:right;"> loss_from_investments_dollar </th>
   <th style="text-align:right;"> management_fees_for_securities_lending_dollar </th>
   <th style="text-align:right;"> market_assets_reported_for_asset_smoothing </th>
   <th style="text-align:right;"> market_funded_ratio_percentage </th>
   <th style="text-align:right;"> market_investment_return_mva_basis </th>
   <th style="text-align:right;"> market_value_of_assets_dollar </th>
   <th style="text-align:right;"> market_value_of_assets_net_of_fees_dollar </th>
   <th style="text-align:left;"> measurment_date_md </th>
   <th style="text-align:right;"> members_covered_by_social_security </th>
   <th style="text-align:right;"> membership_data_active </th>
   <th style="text-align:right;"> membership_data_inactive_vested </th>
   <th style="text-align:right;"> membership_data_retirees_and_beneficiaries </th>
   <th style="text-align:right;"> membership_data_total </th>
   <th style="text-align:right;"> monthly_lump_sum_payments_to_members_dollar </th>
   <th style="text-align:right;"> monthly_lump_sum_payments_to_survivors_dollar </th>
   <th style="text-align:right;"> monthly_payments_to_disabled_dollar </th>
   <th style="text-align:right;"> monthly_payments_to_retirees_dollar </th>
   <th style="text-align:right;"> monthly_payments_to_survivors_dollar </th>
   <th style="text-align:right;"> mortgage_investments_dollar </th>
   <th style="text-align:right;"> net_expenses_dollar </th>
   <th style="text-align:right;"> net_flows_reported_for_asset_smoothing </th>
   <th style="text-align:right;"> net_pension_liability_assuming_1_percent_decrease_in_discount_rate </th>
   <th style="text-align:right;"> net_pension_liability_assuming_1_percent_increase_in_discount_rate </th>
   <th style="text-align:right;"> net_pension_liability_dollar </th>
   <th style="text-align:right;"> net_position_dollar </th>
   <th style="text-align:right;"> non_investment_actuarial_experience_dollar </th>
   <th style="text-align:right;"> number_of_survivors </th>
   <th style="text-align:right;"> number_of_years_remaining_on_amortization_schedule </th>
   <th style="text-align:right;"> optional_benefits_available </th>
   <th style="text-align:right;"> other_actuarial_experience_dollar </th>
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
   <th style="text-align:right;"> present_value_of_future_benefits_for_inactive_vested_members_dollar </th>
   <th style="text-align:right;"> present_value_of_future_benefits_for_retired_members_dollar </th>
   <th style="text-align:left;"> prior_measurment_date </th>
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
   <th style="text-align:right;"> statutory_payment_dollar </th>
   <th style="text-align:right;"> statutory_payment_percentage </th>
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
   <th style="text-align:right;"> wage_inflation </th>
   <th style="text-align:right;"> year_of_inception </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2001 </td>
   <td style="text-align:right;"> 1473 </td>
   <td style="text-align:left;"> New Mexico Educational Retirement Board </td>
   <td style="text-align:left;"> New Mexico </td>
   <td style="text-align:left;"> Census </td>
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
   <td style="text-align:right;"> 8951000 </td>
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
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 1308289000 </td>
   <td style="text-align:right;"> 681939000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 104654000 </td>
   <td style="text-align:right;"> 0 </td>
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
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 45636000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 193695000 </td>
   <td style="text-align:right;"> 774624000 </td>
   <td style="text-align:right;"> 580929000 </td>
   <td style="text-align:right;"> 626350000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 1072736000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 19914 </td>
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
   <td style="text-align:right;"> 18201 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 1082000 </td>
   <td style="text-align:right;"> 60155 </td>
   <td style="text-align:right;"> 104433000 </td>
   <td style="text-align:right;"> 978573000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 27929602000 </td>
   <td style="text-align:right;"> 453371000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 2277 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 458224000 </td>
   <td style="text-align:right;"> 186029000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 346877000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 104654000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 45636000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 160442000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 3005398000 </td>
   <td style="text-align:right;"> 3005398000 </td>
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
   <td style="text-align:right;"> 7070802000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 1308289000 </td>
   <td style="text-align:right;"> -761401000 </td>
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
   <td style="text-align:right;"> 458224000 </td>
   <td style="text-align:right;"> 1419613000 </td>
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
   <td style="text-align:right;"> 1473 </td>
   <td style="text-align:left;"> New Mexico Educational Retirement Board </td>
   <td style="text-align:left;"> New Mexico </td>
   <td style="text-align:left;"> Public Plans Database </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Entry Age Normal </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> 2001-06-30 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 7418300000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> New Mexico </td>
   <td style="text-align:right;"> -3517803 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> Level Dollar Open </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> 5-year smoothed market value. </td>
   <td style="text-align:right;"> 44.9 </td>
   <td style="text-align:right;"> 15288 </td>
   <td style="text-align:right;"> 15939 </td>
   <td style="text-align:right;"> 30248 </td>
   <td style="text-align:right;"> 9.2 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 339158220 </td>
   <td style="text-align:right;"> 4235904 </td>
   <td style="text-align:right;"> 317670310 </td>
   <td style="text-align:left;"> https://www.nmerb.org/handbook.html </td>
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
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Multiple employer, cost sharing plan </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> -5440446 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 31142922 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 150068398 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.076 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 161524340 </td>
   <td style="text-align:right;"> 0.0512 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 0.0865 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> -978572992 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> 2001-06-30 </td>
   <td style="text-align:right;"> 2002 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> New Mexico </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
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
   <td style="text-align:right;"> -0.10100 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0.03 </td>
   <td style="text-align:right;"> 173709874 </td>
   <td style="text-align:right;"> 142566952 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> -4790177 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> -642.939 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 6667001941 </td>
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
   <td style="text-align:right;"> -380747394 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3689430 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> -12949806 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0.03 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> Educational Retirement Board of New Mexico </td>
   <td style="text-align:left;"> New Mexico Educational </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 3604455500 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> -23684106 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> -335155233 </td>
   <td style="text-align:right;"> -37826468 </td>
   <td style="text-align:right;"> 39773012 </td>
   <td style="text-align:right;"> -37183529 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> Plan members covered by Social Security </td>
   <td style="text-align:left;"> NM </td>
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
   <td style="text-align:right;"> 65 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 60155 </td>
   <td style="text-align:right;"> -492424583 </td>
   <td style="text-align:right;"> 0.0353 </td>
   <td style="text-align:right;"> 1.820e+08 </td>
   <td style="text-align:right;"> -340595679 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 311592738 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0.1272 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 22191 </td>
   <td style="text-align:right;"> 580 </td>
   <td style="text-align:right;"> 13401 </td>
   <td style="text-align:right;"> 4800 </td>
   <td style="text-align:right;"> 87146 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 19930 </td>
   <td style="text-align:right;"> 1681 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0.1625 </td>
   <td style="text-align:left;"> Plan covers teachers </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0.045 </td>
   <td style="text-align:right;"> 1937 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2001 </td>
   <td style="text-align:right;"> 1473 </td>
   <td style="text-align:left;"> New Mexico Educational Retirement Board </td>
   <td style="text-align:left;"> New Mexico </td>
   <td style="text-align:left;"> Reason </td>
   <td style="text-align:right;"> -0.111 </td>
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
   <td style="text-align:right;"> -76071151 </td>
   <td style="text-align:right;"> 0.9192099 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> 7418300000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 8070300000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 161524340 </td>
   <td style="text-align:right;"> 161524340 </td>
   <td style="text-align:right;"> 1 </td>
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
   <td style="text-align:right;"> 31870125 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> 1819600000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0.08 </td>
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
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 46181925 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 100065963 </td>
   <td style="text-align:right;"> 0.08 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0.095 </td>
   <td style="text-align:right;"> 6667000000 </td>
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
   <td style="text-align:right;"> -208007239 </td>
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
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 161500000 </td>
   <td style="text-align:right;"> 0.0865 </td>
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
   <td style="text-align:right;"> 652000000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2002 </td>
   <td style="text-align:right;"> 1473 </td>
   <td style="text-align:left;"> New Mexico Educational Retirement Board </td>
   <td style="text-align:left;"> New Mexico </td>
   <td style="text-align:left;"> Census </td>
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
   <td style="text-align:right;"> 8325000 </td>
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
   <td style="text-align:right;"> 1000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 601701000 </td>
   <td style="text-align:right;"> 438659000 </td>
   <td style="text-align:right;"> 189327000 </td>
   <td style="text-align:right;"> 79000 </td>
   <td style="text-align:right;"> 4000 </td>
   <td style="text-align:right;"> 4000 </td>
   <td style="text-align:right;"> NA </td>
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
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 50405000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 363111000 </td>
   <td style="text-align:right;"> 819111000 </td>
   <td style="text-align:right;"> 456000000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 992565000 </td>
   <td style="text-align:right;"> 23052 </td>
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
   <td style="text-align:right;"> 19931 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 725000 </td>
   <td style="text-align:right;"> 61091 </td>
   <td style="text-align:right;"> 123458000 </td>
   <td style="text-align:right;"> 746928000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> 61091 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 28508035000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3412081000 </td>
   <td style="text-align:right;"> 27482492000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 2000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 22250000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 849456000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 189248000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 50405000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 107511000 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 2898147000 </td>
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
   <td style="text-align:right;"> 6788966000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 1040360000 </td>
   <td style="text-align:right;"> -558763000 </td>
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
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1842021000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 1000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2002 </td>
   <td style="text-align:right;"> 1473 </td>
   <td style="text-align:left;"> New Mexico Educational Retirement Board </td>
   <td style="text-align:left;"> New Mexico </td>
   <td style="text-align:left;"> Public Plans Database </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Entry Age Normal </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> 2002-06-30 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 7595100000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> New Mexico </td>
   <td style="text-align:right;"> -3622362 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> Level Dollar Open </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> 5-year smoothed market value. </td>
   <td style="text-align:right;"> 45.2 </td>
   <td style="text-align:right;"> 15780 </td>
   <td style="text-align:right;"> 16463 </td>
   <td style="text-align:right;"> 32387 </td>
   <td style="text-align:right;"> 9.3 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 363888410 </td>
   <td style="text-align:right;"> 4405617 </td>
   <td style="text-align:right;"> 340775750 </td>
   <td style="text-align:left;"> https://www.nmerb.org/handbook.html </td>
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
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Multiple employer, cost sharing plan </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> -5048278 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 36924554 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 151378455 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.076 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 173863363 </td>
   <td style="text-align:right;"> 0.0512 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 0.0865 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> -746928008 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> 2002-06-30 </td>
   <td style="text-align:right;"> 2003 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> New Mexico </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
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
   <td style="text-align:right;"> -0.09418 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0.03 </td>
   <td style="text-align:right;"> 165914492 </td>
   <td style="text-align:right;"> 128989938 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> -4291673 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> -410.539 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 6013355928 </td>
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
   <td style="text-align:right;"> -399625267 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 27 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3450084 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> -8404063 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0.03 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> Educational Retirement Board of New Mexico </td>
   <td style="text-align:left;"> New Mexico Educational </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 3860532000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> -20103972 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> -362446278 </td>
   <td style="text-align:right;"> -19657478 </td>
   <td style="text-align:right;"> 22250077 </td>
   <td style="text-align:right;"> -19246939 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> Plan members covered by Social Security </td>
   <td style="text-align:left;"> NM </td>
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
   <td style="text-align:right;"> 65 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 61091 </td>
   <td style="text-align:right;"> -254020746 </td>
   <td style="text-align:right;"> 0.0353 </td>
   <td style="text-align:right;"> 1.979e+09 </td>
   <td style="text-align:right;"> -367494556 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 325241818 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0.1272 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 23052 </td>
   <td style="text-align:right;"> 589 </td>
   <td style="text-align:right;"> 14714 </td>
   <td style="text-align:right;"> 5217 </td>
   <td style="text-align:right;"> 89360 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 20699 </td>
   <td style="text-align:right;"> 1764 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0.1625 </td>
   <td style="text-align:left;"> Plan covers teachers </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0.045 </td>
   <td style="text-align:right;"> 1937 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2002 </td>
   <td style="text-align:right;"> 1473 </td>
   <td style="text-align:left;"> New Mexico Educational Retirement Board </td>
   <td style="text-align:left;"> New Mexico </td>
   <td style="text-align:left;"> Reason </td>
   <td style="text-align:right;"> -0.088 </td>
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
   <td style="text-align:right;"> -536122633 </td>
   <td style="text-align:right;"> 0.8682099 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> 7595100000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 8748000000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 173863363 </td>
   <td style="text-align:right;"> 173863363 </td>
   <td style="text-align:right;"> 1 </td>
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
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> 1978500000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0.08 </td>
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
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 48797047 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> -346520405 </td>
   <td style="text-align:right;"> 0.08 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 0.033 </td>
   <td style="text-align:right;"> 6013400000 </td>
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
   <td style="text-align:right;"> -189602228 </td>
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
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 173900000 </td>
   <td style="text-align:right;"> 0.0865 </td>
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
   <td style="text-align:right;"> 1152900000 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
</tbody>
</table>

### `filterData()`

5. `filterData()`: filters existing data (data.frame/data.table format) keeping & renaming set of commonly used variables in pension analysis. `filterData(Data, fy, source = FALSE)` has 4 arguments:

* `Data`: A data table already pulled with `pullData`, `pullStateData`, or other ways. 
* `fy`: Starting fiscal year for the data pulled from the Reason pension database.
* `employee`: Character designating type of employees covered (e.g. "teacher", "state", "local", "state and local", "police and fire").
* `source`: Set to `FALSE`. It should be set to `source = TRUE` if you filter data pulled with `pullSourceData` function.

Example of the workflow around the filtering function:


```r
state.data <- pullStateData(2001)
filtered <- filterData(state.data, 2010, NULL, FALSE)
filtered %>% 
  head() %>%
  kable() %>%
  kable_styling(full_width = FALSE, position = "left")
```

<table class="table" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:right;"> year </th>
   <th style="text-align:left;"> plan_name </th>
   <th style="text-align:left;"> state </th>
   <th style="text-align:left;"> return_1yr </th>
   <th style="text-align:left;"> ava_return </th>
   <th style="text-align:left;"> actuarial_cost_method_in_gasb_reporting </th>
   <th style="text-align:left;"> funded_ratio </th>
   <th style="text-align:left;"> ava </th>
   <th style="text-align:left;"> mva </th>
   <th style="text-align:left;"> mva_smooth </th>
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
   <th style="text-align:left;"> asset_valuation_method_for_gasb_reporting </th>
   <th style="text-align:left;"> payroll </th>
   <th style="text-align:left;"> ee_contribution </th>
   <th style="text-align:left;"> ee_nc_pct </th>
   <th style="text-align:left;"> er_contribution </th>
   <th style="text-align:left;"> er_nc_pct </th>
   <th style="text-align:left;"> er_state_contribution </th>
   <th style="text-align:left;"> er_proj_adec_pct </th>
   <th style="text-align:left;"> other_contribution </th>
   <th style="text-align:left;"> other_additions </th>
   <th style="text-align:right;"> fy_contribution </th>
   <th style="text-align:left;"> inflation_assum </th>
   <th style="text-align:left;"> arr </th>
   <th style="text-align:left;"> dr </th>
   <th style="text-align:left;"> number_of_years_remaining_on_amortization_schedule </th>
   <th style="text-align:left;"> payroll_growth_assumption </th>
   <th style="text-align:left;"> total_amortization_payment_pct </th>
   <th style="text-align:left;"> total_contribution </th>
   <th style="text-align:left;"> total_nc_pct </th>
   <th style="text-align:left;"> total_nc_dollar </th>
   <th style="text-align:left;"> total_number_of_members </th>
   <th style="text-align:left;"> total_proj_adec_pct </th>
   <th style="text-align:left;"> type_of_employees_covered </th>
   <th style="text-align:left;"> unfunded_actuarially_accrued_liabilities_dollar </th>
   <th style="text-align:left;"> wage_inflation </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 2010 </td>
   <td style="text-align:left;"> Alabama Employees' Retirement System (ERS) </td>
   <td style="text-align:left;"> Alabama </td>
   <td style="text-align:left;"> 0.0847 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> Entry Age Normal </td>
   <td style="text-align:left;"> 0.682 </td>
   <td style="text-align:left;"> 9739331000 </td>
   <td style="text-align:left;"> 8176732000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 14284119000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 377898000 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> Level Percent Open </td>
   <td style="text-align:left;"> -759528000 </td>
   <td style="text-align:left;"> 778328440 </td>
   <td style="text-align:left;"> 24874000 </td>
   <td style="text-align:left;"> -10334000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 5-year smoothed market related value. </td>
   <td style="text-align:left;"> 3619670000 </td>
   <td style="text-align:left;"> 196757338 </td>
   <td style="text-align:left;"> 0.0502 </td>
   <td style="text-align:left;"> 377898000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 147593000 </td>
   <td style="text-align:left;"> 0.0795 </td>
   <td style="text-align:left;"> 1790000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> 2013 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 0.08 </td>
   <td style="text-align:left;"> 0.08 </td>
   <td style="text-align:left;"> 29.0 </td>
   <td style="text-align:left;"> 0.045 </td>
   <td style="text-align:left;"> 0.0491 </td>
   <td style="text-align:left;"> 574656000 </td>
   <td style="text-align:left;"> 0.0806 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> Plan covers state and local employees </td>
   <td style="text-align:left;"> 4544788000 </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2011 </td>
   <td style="text-align:left;"> Alabama Employees' Retirement System (ERS) </td>
   <td style="text-align:left;"> Alabama </td>
   <td style="text-align:left;"> 0.0221 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> Entry Age Normal </td>
   <td style="text-align:left;"> 0.658 </td>
   <td style="text-align:left;"> 9456158000 </td>
   <td style="text-align:left;"> 8130435000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 14366796000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 394998000 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> Level Percent Open </td>
   <td style="text-align:left;"> -819755000 </td>
   <td style="text-align:left;"> 827273750 </td>
   <td style="text-align:left;"> 36798000 </td>
   <td style="text-align:left;"> -10002000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 5-year smoothed market related value. </td>
   <td style="text-align:left;"> 3540681000 </td>
   <td style="text-align:left;"> 195709253 </td>
   <td style="text-align:left;"> 0.0501 </td>
   <td style="text-align:left;"> 394998000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 183221000 </td>
   <td style="text-align:left;"> 0.1126 </td>
   <td style="text-align:left;"> 2012000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> 2014 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 0.08 </td>
   <td style="text-align:left;"> 0.08 </td>
   <td style="text-align:left;"> 29.0 </td>
   <td style="text-align:left;"> 0.0325 </td>
   <td style="text-align:left;"> 0.0849 </td>
   <td style="text-align:left;"> 590707000 </td>
   <td style="text-align:left;"> 0.0778 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> Plan covers state and local employees </td>
   <td style="text-align:left;"> 4910638000 </td>
   <td style="text-align:left;"> 0.0325 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2012 </td>
   <td style="text-align:left;"> Alabama Employees' Retirement System (ERS) </td>
   <td style="text-align:left;"> Alabama </td>
   <td style="text-align:left;"> 0.1801 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> Entry Age Normal </td>
   <td style="text-align:left;"> 0.657 </td>
   <td style="text-align:left;"> 9116551000 </td>
   <td style="text-align:left;"> 9188696000 </td>
   <td style="text-align:left;"> 9116551305 </td>
   <td style="text-align:left;"> 13884995000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 317520000 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> Level Percent Open </td>
   <td style="text-align:left;"> -889210000 </td>
   <td style="text-align:left;"> 864958380 </td>
   <td style="text-align:left;"> 40746000 </td>
   <td style="text-align:left;"> -10616000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> Market Value. </td>
   <td style="text-align:left;"> 3252003000 </td>
   <td style="text-align:left;"> 216870614 </td>
   <td style="text-align:left;"> 0.0726 </td>
   <td style="text-align:left;"> 317520000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 118646000 </td>
   <td style="text-align:left;"> 0.1198 </td>
   <td style="text-align:left;"> 1937000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> 2015 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 0.08 </td>
   <td style="text-align:left;"> 0.08 </td>
   <td style="text-align:left;"> 28.0 </td>
   <td style="text-align:left;"> 0.0325 </td>
   <td style="text-align:left;"> 0.096 </td>
   <td style="text-align:left;"> 534390000 </td>
   <td style="text-align:left;"> 0.0964 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> Plan covers state and local employees </td>
   <td style="text-align:left;"> 4768444000 </td>
   <td style="text-align:left;"> 0.0325 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2013 </td>
   <td style="text-align:left;"> Alabama Employees' Retirement System (ERS) </td>
   <td style="text-align:left;"> Alabama </td>
   <td style="text-align:left;"> 0.146 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> Entry Age Normal </td>
   <td style="text-align:left;"> 0.657 </td>
   <td style="text-align:left;"> 9546459000 </td>
   <td style="text-align:left;"> 10091940000 </td>
   <td style="text-align:left;"> 10012966727 </td>
   <td style="text-align:left;"> 14536600000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 338819000 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> Level Percent Closed </td>
   <td style="text-align:left;"> -940312000 </td>
   <td style="text-align:left;"> 898211880 </td>
   <td style="text-align:left;"> 44837000 </td>
   <td style="text-align:left;"> -9767000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> Market Value. </td>
   <td style="text-align:left;"> 3400596000 </td>
   <td style="text-align:left;"> 223646119 </td>
   <td style="text-align:left;"> 0.0748 </td>
   <td style="text-align:left;"> 338819000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 125363000 </td>
   <td style="text-align:left;"> 0.1222 </td>
   <td style="text-align:left;"> 1823000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 0.08 </td>
   <td style="text-align:left;"> 0.08 </td>
   <td style="text-align:left;"> 28.0 </td>
   <td style="text-align:left;"> 0.0325 </td>
   <td style="text-align:left;"> 0.0971 </td>
   <td style="text-align:left;"> 562465000 </td>
   <td style="text-align:left;"> 0.0999 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> Plan covers state and local employees </td>
   <td style="text-align:left;"> 4990141000 </td>
   <td style="text-align:left;"> 0.0325 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2014 </td>
   <td style="text-align:left;"> Alabama Employees' Retirement System (ERS) </td>
   <td style="text-align:left;"> Alabama </td>
   <td style="text-align:left;"> 0.1202 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> Entry Age Normal </td>
   <td style="text-align:left;"> 0.669 </td>
   <td style="text-align:left;"> 10134581000 </td>
   <td style="text-align:left;"> 10883952000 </td>
   <td style="text-align:left;"> 10803109967 </td>
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
   <td style="text-align:left;"> 5-year market related value. </td>
   <td style="text-align:left;"> 3444341000 </td>
   <td style="text-align:left;"> 226014854 </td>
   <td style="text-align:left;"> 0.0746 </td>
   <td style="text-align:left;"> 391181000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 144736000 </td>
   <td style="text-align:left;"> 0.1195 </td>
   <td style="text-align:left;"> 2881000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 0.08 </td>
   <td style="text-align:left;"> 0.08 </td>
   <td style="text-align:left;"> 28.0 </td>
   <td style="text-align:left;"> 0.0325 </td>
   <td style="text-align:left;"> 0.0943 </td>
   <td style="text-align:left;"> 617197000 </td>
   <td style="text-align:left;"> 0.0998 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> Plan covers state and local employees </td>
   <td style="text-align:left;"> 5003713000 </td>
   <td style="text-align:left;"> 0.0325 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2015 </td>
   <td style="text-align:left;"> Alabama Employees' Retirement System (ERS) </td>
   <td style="text-align:left;"> Alabama </td>
   <td style="text-align:left;"> 0.0105 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> Entry Age Normal </td>
   <td style="text-align:left;"> 0.673 </td>
   <td style="text-align:left;"> 10589258000 </td>
   <td style="text-align:left;"> 10551904000 </td>
   <td style="text-align:left;"> 10485255746 </td>
   <td style="text-align:left;"> 15723720000 </td>
   <td style="text-align:left;"> 15960732000 </td>
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
   <td style="text-align:left;"> 5-year market related value. </td>
   <td style="text-align:left;"> 3488017000 </td>
   <td style="text-align:left;"> 229253696 </td>
   <td style="text-align:left;"> 0.0744 </td>
   <td style="text-align:left;"> 410932000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 136977000 </td>
   <td style="text-align:left;"> 0.117 </td>
   <td style="text-align:left;"> 3487000 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 0.08 </td>
   <td style="text-align:left;"> 0.08 </td>
   <td style="text-align:left;"> 28.0 </td>
   <td style="text-align:left;"> 0.0325 </td>
   <td style="text-align:left;"> 0.0921 </td>
   <td style="text-align:left;"> 640186000 </td>
   <td style="text-align:left;"> 0.0993 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> Plan covers state and local employees </td>
   <td style="text-align:left;"> 5134462000 </td>
   <td style="text-align:left;"> 0.0325 </td>
  </tr>
</tbody>
</table>

### `masterView()`

6. `masterView()`: Allows to view already mapped & unmapped columns/variables per data source.
`masterView(source = NULL, expand = FALSE)` has 2 arguments:

* `source`: Name of the main data sources: "Reason", "Public Plans Database", "Census".
* `expand`: Set to `FALSE` (default) to see mapped variables. Change to `TRUE` if you want to see all unmapped variables.

Example of how to use this function:


```r
view.reason <- masterView("Reason", FALSE)
view.reason %>% 
  head() %>%
  kable() %>%
  kable_styling(full_width = FALSE, position = "left")
```

<table class="table" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:right;"> master_attribute_id </th>
   <th style="text-align:left;"> master_attribute_name </th>
   <th style="text-align:right;"> priority </th>
   <th style="text-align:right;"> plan_attribute_id </th>
   <th style="text-align:left;"> attribute_name </th>
   <th style="text-align:left;"> attribute_column_name </th>
   <th style="text-align:left;"> data_source_name </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Market Value of Assets Dollar </td>
   <td style="text-align:right;"> 100 </td>
   <td style="text-align:right;"> 10996 </td>
   <td style="text-align:left;"> Market Value of Assets </td>
   <td style="text-align:left;"> mva </td>
   <td style="text-align:left;"> Reason </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> Actuarially Accrued Liabilities Dollar </td>
   <td style="text-align:right;"> 100 </td>
   <td style="text-align:right;"> 10990 </td>
   <td style="text-align:left;"> Actuarial Acrrued Liability </td>
   <td style="text-align:left;"> aal </td>
   <td style="text-align:left;"> Reason </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> Covered Payroll Dollar </td>
   <td style="text-align:right;"> 100 </td>
   <td style="text-align:right;"> 10993 </td>
   <td style="text-align:left;"> Covered Payroll </td>
   <td style="text-align:left;"> payroll </td>
   <td style="text-align:left;"> Reason </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> 1 Year Investment Return Percentage </td>
   <td style="text-align:right;"> 100 </td>
   <td style="text-align:right;"> 10981 </td>
   <td style="text-align:left;"> Market Investment Return (MVA Basis) </td>
   <td style="text-align:left;"> market_return </td>
   <td style="text-align:left;"> Reason </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:left;"> Actuarial Funded Ratio Percentage </td>
   <td style="text-align:right;"> 100 </td>
   <td style="text-align:right;"> 10992 </td>
   <td style="text-align:left;"> GASB 25 Funded Ratio </td>
   <td style="text-align:left;"> fundedratio_old </td>
   <td style="text-align:left;"> Reason </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:left;"> Actuarial Value of Assets Dollar </td>
   <td style="text-align:right;"> 100 </td>
   <td style="text-align:right;"> 10989 </td>
   <td style="text-align:left;"> Actuarial Value of Assets </td>
   <td style="text-align:left;"> ava </td>
   <td style="text-align:left;"> Reason </td>
  </tr>
</tbody>
</table>

### `loadData`

7. `loadData`: loads the data for a specified plan from an Excel file. `loadData` has one argument:

`loadData(file_name)`

* `file_name`: A string enclosed in quotation marks containing a file name with path of a pension plan Excel data file.

```
data_from_file <- loadData('data/NorthCarolina_PensionDatabase_TSERS.xlsx')
```

### `selectedData()`

8. `selectedData()`: selects the only the variables used in historical analyses. `selectedData` has one argument, `wide_data`, that is required:

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

9. `glPlot()`: creates the 'Gain/Loss' plot using a CSV file as an input. glPlot has two arguments:

`glPlot(filename, ylab_unit)`

* `filename`: a csv (comma separated value) file containing columns of gain loss category names with one row of values.
* `ylab_unit`: a string contained within quotation marks containing th y-axis label unit. The default value is "Billions"

Example of how it is used in a standard workflow:

`filename <- "data/GainLoss_data.csv"`
`glPlot(filename)`

### `linePlot()`

10. `linePlot()`: creates a plot comparing two variables, such as ADEC vs. Actual contributions. `linePlot()` has six arguments, with `data` being required:

`linePlot(data, .var1, .var2, labelY, label1, label2)`

* `data` a dataframe produced by the selectedData function or in the same format.
* `.var1` The name of the first variable to plat, default is adec_contribution_rates.
* `.var2` The name of the second variable to plot, default if actual_contribution_rates.
* `labelY` A label for the Y-axis.
* `label1` A label for the first variable.
* `label2` A label for the second variable.

### `areaPlot()`

11. `areaPlot()`: creates the "Mountain of Debt" chart or S&P500 chart. `areaPlot` has seven arguments, with `data` being required:

`areaPlot(data, title, caption, grid, ticks, sp500, font)`

* `data` a dataframe or data.table produced by the pullStateData function or in the same format.
* `title` naming the chart (e.g. "Unfunded Liability Growth").
* `caption` set to TRUE to add "reason.org/pensions" caption at the bottom right corner
* `grid` set to TRUE to add major gridlines
* `ticks` Set to FALSE to remove ticks
* `sp500` default is FALSE ti create Mounain of Debt chart. Set sp500 to TRUE to visualize annual S&P500 Index values on the secondary Y-axis
* `font` directly paste name of a font (e.g. "Calibri") to change the default font of the text

Example of how it is used in a standard workflow:
```
debt <- areaPlot(PERSI.debt, caption = F, grid = F, ticks = F, sp500 = F, font = "Calibri")
```

### `savePlot()`

12. `savePlot()`: adds a source and save ggplot chart. `savePlot` takes five arguments:
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




