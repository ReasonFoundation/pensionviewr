#' Filter Asset data
#'
#' @param data a data frame or data.table containing PPD's asset allocation data.
#' @param fy Numeric parameter containing a starting fiscal year as it is listed in the Reason pension database.
#' @param plan name of state-managed pension plan to filter end data for.
#' @return A wide data frame with each year as a row and variables as columns.
#' @export
#' @importFrom rlang .data
#' @examples
#' \dontrun{
#' filterAssets(data, fy = 2001, plan = NULL)
#' }
#' @author Anil Niraula <anil.niraula@reason.org>

filterAssets <- function(data, fy = 2001, plan = NULL){
  
  data <- data.frame(data)
  data[,5:74]  <- data[,5:74] %>% mutate_all(as.numeric)
  #View(data[,75])## TOTAL
  #View(reason.data$unfunded_actuarially_accrued_liabilities_dollar)
  
  ## Convert NA's to 0
  data <- data %>%
    replace(is.na(.), 0)
  
  #y <- as.numeric(length(data$total))
  
  #for (i in (1: y)){
  #  data$total[i] <- sum(data[i,5:75])  
  #}
  
  data$year <- as.numeric(data$year)
  
  #for (i in (1: y)){
  #  data$total[i] <- sum(data[i,5:75])  
  #}
  #View(colnames(data))
  
  equity <- data.frame(data %>% select(contains("equity"), 
                                         -contains("private"),
                                         -contains("private_debt"),
                                         -contains("alternative")))
  #View(equity)
  fixed <- data.frame(data %>% select(contains("fixed"),
                                        contains("treasury"),
                                        contains("inflation_linked_bonds"),
                                        contains("corporate_bonds")))
  
  private.equity <- data.frame(data %>% select(contains("private_equity")))
  
  real.estate <- data.frame(data %>% select(contains("estate")))
  
  cash <- data.frame(data %>% select(contains("short"),
                                       contains("cash")))
  
  infrastructure <- data.frame(data %>% select(contains("infrastructure")))
  
  hedge <- data.frame(data %>% select(contains("hedge"),
                                        -contains("equity")))
  
  x <- c(colnames(equity), 
         colnames(fixed),
         colnames(private.equity),
         colnames(real.estate),
         colnames(cash),
         colnames(infrastructure),
         colnames(hedge))
  
  other <- data.frame(data %>% select(-contains(x),
                                        -contains("year"),
                                        -contains("plan_id"),
                                        -contains("display_name"),
                                        -contains("state"),
                                        -contains("market")))
  
  
  #View(other)
  library(skimr)
  #skim(other)
  
  #View(colnames(data))
  #View(equity)
  
  data$private.equity <- 0
  data$real.estate <- 0
  data$hedge <- 0
  data$infrastructure <- 0
  data$other.alternatives <- 0
  data$equity <- 0
  data$fixed <- 0
  data$cash <- 0
  
  for(i in (1:length(data$equity))){
    
    data$private.equity[i] <- sum(private.equity[i,])
    data$real.estate[i] <- sum(real.estate[i,])
    data$hedge[i] <- sum(hedge[i,])
    data$infrastructure[i] <- sum(infrastructure[i,])
    data$other.alternatives[i] <- sum(other[i,])
    data$equity[i] <- sum(equity[i,])
    data$fixed[i] <- sum(fixed[i,])
    data$cash[i] <- sum(cash[i,])
    
  }
  
  
  assets <- data %>% select(year, display_name, state, 
                                                   private.equity,
                                                   real.estate,
                                                   hedge,
                                                   infrastructure,
                                                   other.alternatives,
                                                   equity,
                                                   fixed,
                                                   cash) 
  
  if(!is.null(plan)){
                                                                  
    assets <- assets %>% filter(display_name == plan) }
  
  
  assets$total <- 0
  #View(assets2) 
  y <- as.numeric(length(assets$total))
  
  assets[,4:11]  <- assets[,4:11] %>% mutate_all(as.numeric)
  
  for (i in (1: y)){
    assets$total[i] <- sum(assets[i,4:11])  
  }
  #View(assets1)
  ### calculate shortage to 100% allocation & assign 
  ### 50% to Equities & 50% to Other Alternatives
  assets$equity <- as.numeric(assets$equity)
  assets$other.alternatives <- as.numeric(assets$other.alternatives)
  assets$total <- as.numeric(assets$total)
  #View(assets1$total)
  
  
  assets <- assets %>% filter(year >= 2001)
  #View(assets1)
  colnames(assets) <- c("year",
                         "Plan",
                         "State",
                         "Private Equity",
                         "Real Estate",
                         "Hedge Funds",
                         "Infrastructure",
                         "Other Alternatives",
                         "Total Equity",
                         "Fixed Income",
                         "Cash Equivalents",
                         "Total"
  ) 
  assets
  
  
}
