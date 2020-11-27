#' View mapped/unmapped columns per data source
#'
#' @param source data source (e.g. "Reason", "Public Plans Database", "Census").
#' @param expand TRUE or FALSE (default) allowing to see either currently mapped or all unmapped variables
#' @return A wide data frame with each column names, sources, and other details.
#' @export
#' @importFrom rlang .data
#' @examples
#' \dontrun{
#' masterView("Reason", TRUE)
#' }
#' @author Anil Niraula <anil.niraula@reason.org>

masterView <- function(source = NULL, expand = FALSE){
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
  
  
  query <- paste("select * from", 
                 if(isTRUE(expand)){paste("plan_attribute")}
                 else{paste("master_priority_view")}
  )
  
  result <- RPostgres::dbSendQuery(con, query)
  #RPostgres::dbBind(result, list(1))
  all_data <- RPostgres::dbFetch(result) %>%
    janitor::clean_names()
  RPostgres::dbClearResult(result)
  RPostgres::dbDisconnect(con)
  
  if(is.null(source)){
    all_data <- data.frame(all_data)
    
  }else if(!is.null(source) & !isTRUE(expand)){
    all_data <- data.frame(all_data %>% 
                           dplyr::filter(data_source_name == source)) %>%
                           janitor::clean_names()
    
  }else if(!is.null(source) & source == "Reason" & isTRUE(expand)){
    all_data <- data.frame(all_data %>% 
                           dplyr::filter(data_source_id == 3)) %>%
                           janitor::clean_names()}
  
  else{all_data <- data.frame(all_data)
  }
  
}
