#' Pull data sources
#'
#'Pulls each data point with all data sources this data point has
#'
#' @param plan_name 
#'
#' @return
#' @export
#'
#' @examples
#' pullSourceData(pl, "New Mexico Educational Retirement Board")
pullSourceData <- function(plan_name){
  con <- RPostgres::dbConnect(
    RPostgres::Postgres(),
    dbname = "d629vjn37pbl3l",
    host = "ec2-3-209-200-73.compute-1.amazonaws.com",
    port = 5432,
    user = "reason_readonly",
    password = "p88088bd28ea68027ee96c65996f7ea3b56db0e27d7c9928c05edc6c23ef2bc27",
    sslmode = "require")
  # define the query to retrieve the plan data
  
  if(str_count(plan_name)<6){
    query <- paste("select * from pull_data_state_only()
where year > '2001'
and attribute_name in ('1 Year Investment Return Percentage',
'1 Year Investment Return Percentage',
'Investment Return Assumption for GASB Reporting',
'Actuarially Accrued Liabilities Dollar',
'Total Normal Cost Percentage',
'Covered Payroll Dollar',
'Payroll Growth Assumption',
'Total Benefits Paid Dollar')")}else{
  
  plan_id <- pl$id[pl$display_name == plan_name]
  query <- paste("select * from pull_plan_data(",plan_id,")")
}
}