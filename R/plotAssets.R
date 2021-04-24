#' Plot Asset data
#'
#' @param data a data frame or data.table containing PPD's asset allocation data.
#' @param interactive set to `TRUE` to create interactive version of the chart.
#' @return A wide data frame with each year as a row and variables as columns.
#' @export
#' @importFrom rlang .data
#' @examples
#' \dontrun{
#' assetPlot(data = assets, interactive = FALSE)
#' }
#' @author Anil Niraula <anil.niraula@reason.org>

assetPlot <- function(data, interactive = FALSE){
  data <- data.table(data)
  alloc <- data.table(melt(data, id.vars = "year"))
  alloc$value <- as.numeric(alloc$value)
  alloc$value <- round(alloc$value*100,1)
  
  colors <- c(palette_reason$Red,
              palette_reason$LightRed,
              palette_reason$Orange,
              palette_reason$LightOrange,
              palette_reason$Yellow,
              palette_reason$DarkGrey,
              palette_reason$SatBlue,
              palette_reason$LightBlue)
  
  graph <- ggplot(alloc,aes(x = year, y = value, fill = variable, 
                            group = variable,
                            text = paste0("Fiscal Year: ", year, "<br>",
                                          "Class: ",variable, "<br>",
                                          "Allocation: ", value, "%")
  )) +
    geom_area(
      #text = paste0("Fiscal Year: ", year, "<br>",
      #"Class: ",variable, "<br>",
      # "Allocation: ",round(value *100,2), "%")), 
      cposition="stack", stat="identity")+
    scale_y_continuous(labels = function(x) paste0(x,"%"), name = "% of Total Portfolio")+
    scale_fill_manual(values=colors)+
    theme_bw()+
    theme(
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      axis.title.x=element_blank(),
      axis.line = element_line(colour = "black"),
      legend.title = element_blank(),
      plot.title = element_text(family = "Arial", size = 14, margin=margin(0,0,0,0)),
      axis.title.y = element_text(family = "Arial", size = 12, margin=margin(0,0,0,0))
    )#+ theme(legend.position = "none")
  
  if(isTRUE(interactive)){
    graph <- ggplotly(graph, tooltip = "text")
  }
  
  graph
}