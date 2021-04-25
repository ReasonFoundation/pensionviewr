#' pullAssetData
#'
#' @param fy starting fiscal year to filter data for
#' @param mva = FALSE (Set to `TRUE` to also pull MVA for weighting)
#' @export
#' @examples
#' \dontrun{
#' pullAssetData(fy = 2001, mva = FALSE) 
#' }
#' @importFrom rlang .data
#' @author Anil Niraula <anil.niraula@reason.org>

pullAssetData <- function (fy, mva = FALSE) 
{
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
  
  query <- paste("select * from pull_data_state_only()\nwhere year > '", 
                 paste(fy - 1), "'\nand attribute_name in ('International Equity Actual Allocation',
\n'Domestic Equity Actual Allocation',
\n'Fixed Income + Alternatives Actual Allocation',
\n'Real Estate Actual Allocation',
\n'Domestic Fixed Income Actual Allocation',
\n'International Fixed Income Actual Allocation',
\n'Private Equity Actual Allocation',
\n'Absolute Return/Value Fund Actual Allocation',
\n'Farmland/Agriculture Actual Allocation',
\n'High Yield Fixed Income Actual Allocation',
\n'Fixed Income Actual Allocation',
\n'Cash/Short-term Actual Allocation',
\n'Inflation Linked Bonds/TIPS Actual Allocation',
\n'Misc. Equity Actual Allocation',
\n'Other” Actual Allocation',
\n'Large Cap Equity Actual Allocation',
\n'Micro Cap Equity Actual Allocation',
\n'Multi-Asset Class/Diversified Actual Allocation',
\n'REIT Actual Allocation',
\n'Real Assets/Real Return Actual Allocation',
\n'Credit Opportunities/Private Credit Actual Allocation',
\n'GTAA/GAA/Global Macro Hedge Actual Allocation',
\n'Risk Parity Actual Allocation',
\n'Opportunistic Equity Alternative Actual Allocation',
\n'Opportunistic Debt Alernatives Actual Allocation',
\n'Emerging Fixed Income Actual Allocation',
\n'Private Debt Actual Allocation',
\n'Equity Securities Lending Actual Allocation',
\n'Infrastructure Actual Allocation',
\n'MLP/Limited Partnership Actual Allocation',
\n'Investment Grade Fixed Income Actual Allocation',
\n'Loans Actual Allocation',
\n'Large Cap Domestic Equity Actual Allocation',
\n'Small Cap Domestic Equity Actual Allocation',
\n'Private Real Estate Actual Allocation',
\n'Timberland Actual Allocation',
\n'Hedge Funds Actual Allocation',
\n'Fixed Income Mortgages/Securitized Debt Actual Allocation',
\n'Inflation-Sensititive Actual Allocation',
\n'Global Fixed Income Actual Allocation',
\n'Private Placement Actual Allocation',
\n'Global Equity Actual Allocation',
\n'Core Fixed Income Actual Allocation',
\n'Opportunity/Opportunistic Actual Allocation',
\n'Commodities Actual Allocation',
\n'Core Real Estate Actual Allocation',
\n'Emerging International Equity Actual Allocation',
\n'Developed International Equity Actual Allocation',
\n'Relative Return/Value Fund Actual Allocation',
\n'US Treasury Actual Allocation',
\n'Covered Call Actual Allocation',
\n'Natural Resources Actual Allocation',
\n'Non-Core Fixed Income Actual Allocation',
\n'Opportunistic Fixed Income Actual Allocation',
\n'Corporate Bonds Actual Allocation',
\n'Misc. Alternatives Actual Allocation',
\n'Mid Cap Domestic Equity Actual Allocation',
\n'Small Cap Equity” Actual Allocation',
\n'Equity Hedge Actual Allocation',
\n'Non-Core Real Estate Actual Allocation',
\n'Fixed Income Funds of Funds Actual Allocation',
\n'Value Added Fixed Income Actual Allocation',
\n'Passive International Equity Actual Allocation',
\n'Active International Equity Actual Allocation',
\n'Core Equity Actual Allocation',
\n'Global Growth Equity Actual Allocation',
\n'Triple Net Lease Actual Allocation',
\n'Distressed Debt Actual Allocation',
\n'Distressed Lending Actual Allocation',
\n'GIPS Actual Allocation',
\n'Misc. Equity and Fixed Income Blends Actual Allocation',
\n'Opportunistic Equity Actual Allocation',
\n'Social Responsibility Equity Actual Allocation',
\n'Nominal Fixed Income Actual Allocation',
\n'Convertible Fixed Income Actual Allocation',
\n'Fixed Income ETI Actual Allocation',
\n'Structured Fixed Income Actual Allocation',
\n'Fixed Income Below Investment Grade Actual Allocation',
\n'Fixed Income + Cash Actual Allocation'",if(isTRUE(mva)){paste(",\n'Market Value of Assets Dollar'")},
                 ")")
  result <- RPostgres::dbSendQuery(con, query)
  all_data <- RPostgres::dbFetch(result) %>% janitor::clean_names()
  RPostgres::dbClearResult(result)
  RPostgres::dbDisconnect(con)
  
  all_data %>% dplyr::group_by_at(dplyr::vars(-.data$attribute_value)) %>% 
    dplyr::mutate(row_id = 1:dplyr::n()) %>% dplyr::ungroup() %>% 
    tidyr::pivot_wider(names_from = attribute_name, values_from = attribute_value) %>% 
    dplyr::select(-.data$row_id) %>% dplyr::arrange(display_name, 
                                                    year) %>% janitor::clean_names()
}