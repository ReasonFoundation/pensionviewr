#' Create the 'Gain/Loss' plot using a file as an input.
#'
#' @param url an http web link to csv (comma separated value) file containing columns of gain loss category names with one row of values.
#' @param interactive set to TRUE to create interactive waterfall chart
#' @param database Set to TRUE to pull data from pension database
#' @param fileName Define name of the Static chart to save (interactive = FALSE)
#' @param title Add chart title (text)
#' @param caption reason.org caption (set to TRUE)
#' @param yaxisScale Y axis scale to divide Gain/Loss data by to get $Billions (e.g., 1e-06)
#' @param yaxisMax Y axis maximum value (in $Billions)
#' @param lab1 Gain/Loss category label #1 
#' @param lab2 Gain/Loss category label #2 
#' @param lab3 Gain/Loss category label #3 
#' @param lab4 Gain/Loss category label #4 
#' @param lab5 Gain/Loss category label #5 
#' @param lab6 Gain/Loss category label #6 
#' @param lab7 Gain/Loss category label #7
#' @param lab8 Gain/Loss category label #8 (can set to NULL)
#' @param lab9 Gain/Loss category label #9 (can set to NULL)
#' @importFrom rlang .data
#' @export
#' @examples
#' \dontrun{
#' glPlot(url = "https://raw.githubusercontent.com/ReasonFoundation/GraphicsR/master/PERSI_GL2.csv", 
#' interactive =  TRUE,
#' database = FALSE,
#' fileName = "PERSI_GainLoss.png",
#' title = "",#"<b>Causes of Arkansas ERS Pension Debt (2001-2019)<b>",
#' yaxisMax = 4.5,
#' lab1 = "Investment<br>Returns", 
#' lab2 = "Changes to<br>Actuarial<br>Methods &<br>Assumptions",
#' lab3 = "Negative<br>Amortization",
#' lab4 = "Benefit<br>Changes<br>& Other",
#' lab6 = "Gains From<br>Pay<br>Increases<br>Not Given",
#' lab7 = "Net Change to<br>Unfunded<br>Liability",
#' lab8 = NULL,
#' lab9 = NULL)
#' }
#' @author Anil Niraula <anil.niraula@reason.org>

glPlot <- function(url = "https://raw.githubusercontent.com/ReasonFoundation/databaseR/master/apps/APERS_GL.csv", 
                   database = FALSE, 
                   interactive = FALSE, 
                   fileName = "GainLoss.png",
                   title = "<b>Causes of Arkansas ERS Pension Debt (2001-2019)<b>",
                   caption = FALSE,
                   yaxisScale = 1e-06,
                   yaxisMax = 4.5, 
                   lab1 = "Investment<br>Returns", 
                   lab2 = "Benefit<br>Changes<br> & Other",
                   lab3 = "Changes to<br>Actuarial<br>Methods &<br>Assumptions", 
                   lab4 = "Negative<br>Amortization",
                   lab5 = "Deviations from<br>Demographic<br>Assumptions",
                   lab6 = "Gains From<br>Pay<br>Increases<br>Not Given",
                   lab7 = NULL,
                   lab8 = NULL,
                   lab9 = NULL){
  
  #[1] Load Gain/Loss data from the provided url
  if(!isTRUE(database)){
    urlfile=url
    data <- read_csv(url(urlfile), col_names = TRUE, na = c(""), skip_empty_rows = TRUE, col_types = NULL)
    
    data <- data.frame(data)# convert to data.table
    data <-  data %>%
      replace(is.na(.), 0)
    data <- data.table(data)# conv
    #[2] Calculate Total Gain/Loss for each column (i.e. Net Change to UAL over the years)
    y = data[,lapply(.SD,sum),.SDcols=colnames(data)]*yaxisScale
    y <- as.data.table(y)# conv
    y = y[,!1]# sum values by each column
    y = t(y)#Saving needed columns and transposing table for graphics
  }
  #[3] Combine gain/loss data & categories to create interactive Waterfall chart w/ plotly
  #  x = list(lab1, lab2, lab3, lab4, lab5, lab6, lab7,  lab8,  lab9)
  
  x = list(lab1, lab2, lab3, if (!is_null(lab4)) {
    paste(lab4)
  }, if (!is_null(lab5)) {
    paste(lab5)
  }, if (!is_null(lab6)) {
    paste(lab6)
  }, if (!is_null(lab7)) {
    paste(lab7)
  }, if (!is_null(lab8)) {
    paste(lab8)
  }, if (!is_null(lab9)) {
    paste(lab9)
  })
  
    x <- unlist(x)
    
  data <- data.frame(x = factor(x, levels = x), y)
  data <- data %>% dplyr::mutate(measure = dplyr::case_when(.data$y > 
                                                              0 ~ "relative", .data$y < 0 ~ "negative"))
  data <- as.data.table(data)#
  data[length(data[,3]),]$measure <- "total"
  
  #  m <- list(
  #  l = 50,
  #  r = 0,
  #  b = 0,
  #  t = 50,
  #  pad = 4
  #  )
  
  #[4] Visualizing with Plotly
  
  fig <- plot_ly( data,
                  type = "waterfall",
                  measure = ~measure,
                  x = ~x,
                  textposition = "outside",
                  y= ~y,
                  decreasing = list(marker = list(color = palette_reason$Green)),
                  increasing = list(marker = list(color = palette_reason$Red)),
                  totals = list(marker = list(color = palette_reason$Orange)),
                  connector = list(line = list(color= palette_reason$SpaceGrey, width = 1))) 
  
  fig <- fig %>%
    layout(title = paste0(title),
           xaxis = list(title = "",tickfont = list(size = 11, face = "bold")),
           yaxis = list(title = "<b>Change in Unfunded Liability (in $Billions)<b>",
                        titlefont = list(size = 12), range = c(0,yaxisMax),
                        showgrid = FALSE,
                        tick0 = 0,
                        dtick = 0.5,
                        ticklen = 2,
                        linecolor = '#636363',
                        linewidth = 0.75),
           barmode = 'stack',
           autosize = F,
           width = 1000, height = 700,
           showlegend = F)
  
  #ADD caption
  if(isTRUE(caption)){
    fig <- fig %>% 
      layout(annotations = list(yref = 'paper', xref = "x", showarrow = F, 
                                y = 0, x = 5, text = "reason.org/pensions",
                                xanchor='right', yanchor='auto', xshift=0, yshift=0,
                                font=list(size=9, color="black")))}
  
  #`Save` as a `static` png file 
  #OR `show` as a `interactive` Plotly chart
  #if(!isTRUE(interactive)){
  #Save Plotly as a Static PNG on a local computer (to reference in rmarkdown later)
  #https://github.com/plotly/orca
  # orca(fig, paste0(fileName), width =  7 * 300, height = 4 * 300)}else{fig}
  if(!isTRUE(interactive)){
    #Save Plotly as a Static PNG on a local computer (to reference in rmarkdown later)
    #https://github.com/plotly/orca
    orca(fig, paste0(fileName))}else{fig}
}
