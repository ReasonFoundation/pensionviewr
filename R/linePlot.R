#' Create a line plot to visualize up to 5 variables, such as ADEC vs. Actual contributions.
#'
#' @param data a dataframe/data.table produced by pullData, pullStateData, or other ways that produces the same format.
#' @param title Naming the chart (e.g. "Unfunded Liability Growth").
#' @param caption Set to TRUE to add "reason.org/pension" caption at the bottom right corner
#' @param grid Set to TRUE to add major gridlines
#' @param ticks Set to FALSE to remove ticks#'
#' @param font Directly paste name of a font (e.g. "Calibri") to change the default font of the text
#' @param treasury = Set to TRUE to show 30-Year treasury Yeilds on the secondary Y-axis
#' @param inv.returns = Set to FALSE to graph anything other than Investsment Return graph 
#' @param yaxisMin Value that sets Y-axis minimum. 
#' @param yaxisMax Value that sets Y-axis maximum. 
#' @param yaxisSeq  Value that sets space between Major breaks.
#' @param yaxisScale Value that sets Y-axis scale. Example: 100 for percentages or 1/1000 for thousands.
#' @param format Format of Y-axis scale. Examples: "%", "$", or something else.
#' @param str Value that sets number of strings at which to cut legend text at -- Default is 20.
#' @param labelY Title of the Y-axis.
#' @param lab1 Text label for the 1st variable - optional.
#' @param lab2 Text label for the 2nd variable - optional.
#' @param lab3 Text label for the 3rd variable - optional.
#' @param lab4 Text label for the 4th variable - optional.
#' @param lab5 Text label for the 5th variable - optional.
#' 
#' @export
#' @examples
#' \dontrun{
#' linePlot(data, title = NULL, caption = FALSE, grid = FALSE, ticks = TRUE, font = "Calibri",
#' yaxisMin = -20, yaxisMax = 30, yaxisSeq = 5, yaxisScale = 100, 
#' format = "%", str = 20, labelY = NULL, lab1 = "Market Valued Return", 
#' lab2 = "Assumed Rate of Return",lab3 = "",lab4 = "",lab5 = "")
#' }
#' @importFrom rlang .data
#' @author Anil Niraula <anil.niraula@reason.org>, Swaroop Bhagavatula <swaroop.bhagavatula@reason.org>, Jen Sidorova <jen.sidorova@reason.org>

linePlot <- function (data, title = NULL, caption = FALSE, grid = FALSE, 
                      treasury = FALSE, inv.returns = TRUE, ticks = TRUE, font = NULL,
                      yaxisMin = 0, yaxisMax = NULL, yaxisSeq = 5, 
                      yaxisScale = 100, format = NULL, str = 20, labelY = NULL, 
                      lab1 = NULL, lab2 = NULL, lab3 = NULL, lab4 = NULL, lab5 = NULL) 
{
  reasontheme::set_reason_theme(style = "slide")
  x <- length(data$year)
  data <- data.frame(data) %>% dplyr::mutate_all(as.numeric)
  
  ###TREASURY
  
  if(isTRUE(treasury)){
    urlfile <- "https://raw.githubusercontent.com/ReasonFoundation/databaseR/master/files/treasury.csv"
    treasury <- read_csv(url(urlfile), col_names = TRUE, na = c(""), skip_empty_rows = TRUE, col_types = NULL)
    treasury$year <- as.numeric(treasury$year)
    data$year <- as.numeric(data$year)
    treasury <- data.table(
      treasury %>% filter(year > min(data$year-1)))
    data <- data %>% select(year, dr)
    
    data <- data.table(data)
    data <- cbind(data, treasury[,2])
    data <- data.frame(data) %>% dplyr::mutate_all(as.numeric)
    data <- as.data.table(data)
    data$alt.discount <- NA
    data$year <- as.numeric(data$year)
    diff <- (data[year == min(data$year)]$dr - data[year == min(data$year)]$`X30.treasury`)
    data$alt.discount <- data$`X30.treasury` + diff
    data <- data.table(data)
    data$year <- as.numeric(data$year)
  }
  
  #Geomean function
  geomean <- function(x) {
    x <- as.vector(na.omit(x))
    x <- x + 1
    exp(mean(log(x))) - 1
  }
  
  if (isTRUE(inv.returns)) {
  
    data$return_1yr <- as.numeric(data$return_1yr)
    returns <- data$return_1yr
    last <- length(returns)
    #View(returns)
    rolling <- matrix(NA,last,1)
    rolling[last] <- as.numeric(geomean(returns[(last-9):last]))
    #as.numeric(geomean(returns[(last-10):(last-1)]))
    for (i in 1:(last-10)) {
      rolling[last-i] <- geomean(returns[(last-9-i):(last-i)])
    }
    rolling <- data.table(rolling)
    returns[(last-9):last]
    returns[(last-9+1):(last-1)]
    
    data <- data.table(cbind(data, rolling))
    data <- data %>% select(year, return_1yr, ava_return, 
                            arr, V1)
  }
  
  colnames(data) <- c("year", if (!is_null(lab1)) {
    paste(lab1)
  }, if (!is_null(lab2)) {
    paste(lab2)
  }, if (!is_null(lab3)) {
    paste(lab3)
  }, if (!is_null(lab4)) {
    paste(lab4)
  }, if (!is_null(lab5)) {
    paste(lab5)
  })
  
  graph <- data.table(melt(data, id.vars = "year"))
  
  lineColors <- c(palette_reason$Orange, palette_reason$Yellow, 
                  palette_reason$SatBlue, palette_reason$LightGrey, palette_reason$LightGreen)
  options(repr.plot.width = 1, repr.plot.height = 0.75)
  ggplot2::ggplot(graph, ggplot2::aes(x = year, y = yaxisScale * 
                                        value, group = variable)) + ggplot2::geom_line(ggplot2::aes(colour = str_wrap(factor(variable), 
                                                                                                                      str)), size = 1.5) + ggplot2::geom_hline(yintercept = 0, 
                                                                                                                                                               color = "black") + ggplot2::scale_colour_manual(values = lineColors) + 
    ggplot2::scale_y_continuous(breaks = seq(yaxisMin, if (!is.null(yaxisMax)) {
      yaxisMax
    }
    else {
      max(graph$value) * yaxisScale * 1.2
    }, by = yaxisSeq), limits = c(yaxisMin, if (!is.null(yaxisMax)) {
      yaxisMax
    } else {
      max(graph$value) * yaxisScale * 1.2
    }), labels = function(b) {
      if (format == "%") {
        paste0(round(b, 0), "%")
      }
      else if (format == "$") {
        paste0("$", round(b, 0))
      }
      else {
        paste0(format, round(b, 0))
      }
    }, expand = c(0, 0)) + ggplot2::scale_x_continuous(breaks = seq(min(graph$year), 
                                                                    max(graph$year), by = 2), expand = c(0, 0)) + labs(x = element_blank(), 
                                                                                                                       y = labelY) + theme(legend.text = element_text(size = 13)) + 
    theme(legend.direction = "vertical", legend.box = "horizontal", 
          legend.position = if(isTRUE(treasury)){c(0.1, 1)}else{c(0.33, 0.09)})+
    labs(title = paste(title), 
         caption = ifelse(isTRUE(caption),paste("reason.org/pensions"),paste(""))
    )+
    ggplot2::theme(axis.ticks = if(isFALSE(ticks)){ggplot2::element_blank()}else{ggplot2::element_line()}
    )+
    ggplot2::theme(axis.ticks.x = element_line(size = 0.5, color="black"))+
    ggplot2::theme(axis.ticks.y = element_line(size = 0.5, color="black"))+
    ggplot2::theme(axis.text=element_text(size=12),
                   axis.title=element_text(size=12,face="bold"))+
    ggplot2::theme(text = element_text(family = if(!is_null(font)){paste(font)}else{paste("Arial")}, size = 9))+ 
    ##Adding Gridlines
    ggplot2::theme(panel.grid.major.y = element_line(colour= ifelse(isTRUE(grid), 
                                                                    paste(palette_reason$SpaceGrey),"white"),size = (1))) 
  
  # 
}
