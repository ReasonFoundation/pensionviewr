#' Filter Asset data
#'
#' @param assets data frame or data.table containing PPD's asset allocation data.
#' @param fy Numeric parameter containing a starting fiscal year as it is listed in the Reason pension database.
#' @param plan name of state-managed pension plan to filter end data for.
#' @return A wide data frame with each year as a row and variables as columns.
#' @export
#' @importFrom rlang .data
#' @examples
#' \dontrun{
#' filterAssets(assets, fy = 2001, plan = NULL)
#' }
#' @author Anil Niraula <anil.niraula@reason.org>

filterAssets <- function(assets, fy = 2001, plan = NULL){
  
  assets <- data.frame(x)
  assets[,5:74]  <- assets[,5:74] %>% mutate_all(as.numeric)
  #View(assets[,75])## TOTAL
  #View(reason.data$unfunded_actuarially_accrued_liabilities_dollar)
  
  ## Convert NA's to 0
  assets <- assets %>%
    replace(is.na(.), 0)
  
  #y <- as.numeric(length(assets$total))
  
  #for (i in (1: y)){
  #  assets$total[i] <- sum(assets[i,5:75])  
  #}
  
  assets$year <- as.numeric(assets$year)
  
  #for (i in (1: y)){
  #  assets$total[i] <- sum(assets[i,5:75])  
  #}
  #View(colnames(assets))
  
  equity <- data.frame(assets %>% select(contains("equity"), 
                                         -contains("private"),
                                         -contains("private_debt"),
                                         -contains("alternative")))
  #View(equity)
  fixed <- data.frame(assets %>% select(contains("fixed"),
                                        contains("treasury"),
                                        contains("inflation_linked_bonds"),
                                        contains("corporate_bonds")))
  
  private.equity <- data.frame(assets %>% select(contains("private_equity")))
  
  real.estate <- data.frame(assets %>% select(contains("estate")))
  
  cash <- data.frame(assets %>% select(contains("short"),
                                       contains("cash")))
  
  infrastructure <- data.frame(assets %>% select(contains("infrastructure")))
  
  hedge <- data.frame(assets %>% select(contains("hedge"),
                                        -contains("equity")))
  
  x <- c(colnames(equity), 
         colnames(fixed),
         colnames(private.equity),
         colnames(real.estate),
         colnames(cash),
         colnames(infrastructure),
         colnames(hedge))
  
  other <- data.frame(assets %>% select(-contains(x),
                                        -contains("year"),
                                        -contains("plan_id"),
                                        -contains("display_name"),
                                        -contains("state"),
                                        -contains("market")))
  
  
  #View(other)
  library(skimr)
  #skim(other)
  
  #View(colnames(assets))
  #View(equity)
  
  assets$private.equity <- 0
  assets$real.estate <- 0
  assets$hedge <- 0
  assets$infrastructure <- 0
  assets$other.alternatives <- 0
  assets$equity <- 0
  assets$fixed <- 0
  assets$cash <- 0
  
  for(i in (1:length(assets$equity))){
    
    assets$private.equity[i] <- sum(private.equity[i,])
    assets$real.estate[i] <- sum(real.estate[i,])
    assets$hedge[i] <- sum(hedge[i,])
    assets$infrastructure[i] <- sum(infrastructure[i,])
    assets$other.alternatives[i] <- sum(other[i,])
    assets$equity[i] <- sum(equity[i,])
    assets$fixed[i] <- sum(fixed[i,])
    assets$cash[i] <- sum(cash[i,])
    
  }
  
  
  assets1 <- assets %>% select(year, display_name, state, 
                                                   private.equity,
                                                   real.estate,
                                                   hedge,
                                                   infrastructure,
                                                   other.alternatives,
                                                   equity,
                                                   fixed,
                                                   cash) 
  
  if(!is.null(plan)){
                                                                  
    assets1 <- assets1 %>% filter(display_name == plan) }
  
  
  assets1$total <- 0
  #View(assets2) 
  y <- as.numeric(length(assets1$total))
  
  assets1[,4:11]  <- assets1[,4:11] %>% mutate_all(as.numeric)
  
  for (i in (1: y)){
    assets1$total[i] <- sum(assets1[i,4:11])  
  }
  #View(assets1)
  ### calculate shortage to 100% allocation & assign 
  ### 50% to Equities & 50% to Other Alternatives
  assets1$equity <- as.numeric(assets1$equity)
  assets1$other.alternatives <- as.numeric(assets1$other.alternatives)
  assets1$total <- as.numeric(assets1$total)
  #View(assets1$total)
  
  
  assets1 <- assets1 %>% filter(year >= 2001) %>% select(-total)
  #View(assets1)
  colnames(assets1) <- c("year",
                         "Plan",
                         "State",
                         "Private Equity",
                         "Real Estate",
                         "Hedge Funds",
                         "Infrastructure",
                         "Other Alternatives",
                         "Total Equity",
                         "Fixed Income",
                         "Cash Equivalents"
  ) 
  assets1
  
  
}
