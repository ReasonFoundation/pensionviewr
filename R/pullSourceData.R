#' Pull source data
#'
#' @param plan_name A string enclosed in quotation marks containing a plan name as it is listed in the Reason pension database.
#' @param pl A datafram containing the list of plan names, states, and ids in the form produced by the planList() function.
#' @param fy A fiscal year starting point.
#' @return A wide data frame with each year as a row and variables as columns.
#' @export
#' @importFrom rlang .data
#' @examples
#' \dontrun{
#' pullData(pl)
#' pullSourceData(pl, "Kansas Public Employees' Retirement System", fy)
#' }
pullSourceData <- function(pl, plan_name, fy){
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
  # define the query to retrieve the plan data
  plan_id <- pl$id[pl$display_name == plan_name]
  query <- paste("select * from pull_plan_data(",plan_id,")")
  #paste0("select * from pull_plan_data('", str_replace(plan_name,"'", "''"), "')")
  
  result <- RPostgres::dbSendQuery(con, query)
  #RPostgres::dbBind(result, list(1))
  all_data <- RPostgres::dbFetch(result) %>%
    janitor::clean_names()
  RPostgres::dbClearResult(result)
  RPostgres::dbDisconnect(con)
  
  all_data %>%
    dplyr::group_by_at(dplyr::vars(-.data$attribute_value)) %>%  # group by everything other than the value column.
    dplyr::mutate(row_id = 1:dplyr::n()) %>%
    dplyr::filter(year >= fy) %>%
    dplyr::ungroup() %>%  # build group index
    tidyr::spread(.data$attribute_name, .data$attribute_value, convert = TRUE) %>%    # spread
    dplyr::select(-.data$row_id) %>%  # drop the index
    janitor::clean_names()
}
