#' Create a line plot to visualize up to 5 variables, such as ADEC vs. Actual contributions.
#'
#' @param data a dataframe/data.table produced by pullData, pullStateData, or other ways that produces the same format.
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
#' @export
#' @examples
#' \dontrun{
#' linePlot(data, yaxisMin = -20, yaxisMax = 30, yaxisSeq = 5, yaxisScale = 100, format = "%", str = 20, labelY = NULL, lab1 = "Market Valued Return", lab2 = "Assumed Rate of Return",lab3 = "",lab4 = "",lab5 = "")
#' }
#' @importFrom rlang .data
#' @author Anil Niraula <anil.niraula@reason.org>, Swaroop Bhagavatula <swaroop.bhagavatula@reason.org>, Jen Sidorova <jen.sidorova@reason.org>

linePlot <- function (data, yaxisMin = 0, yaxisMax = NULL, yaxisSeq = 5, 
                      yaxisScale = 100, format = NULL, str = 20, labelY = NULL, 
                      lab1 = NULL, lab2 = NULL, lab3 = NULL, lab4 = NULL, lab5 = NULL) 
{
  reasontheme::set_reason_theme(style = "slide")
  
  data <- data.frame(data) %>% dplyr::mutate_all(dplyr::funs(as.numeric))
  
  #Geomean
  if (sum(data$return_1yr) > 0) {
    geomean <- function(x) {
      x <- as.vector(na.omit(x))
      x <- x + 1
      exp(mean(log(x))) - 1
    }
    returns <- as.numeric(data$return_1yr)
    nyear <- 10
    rolling <- geomean(returns[1:nyear])
    n <- length(na.omit(returns)) - nyear
    for (i in 1:n) {
      rolling <- rbind(rolling, geomean(returns[(i + 1):(i + nyear)]))
    }
    data <- data.table(data)
    rolling <- data.table(rolling)
    data <- data.table(rbind.fill(rolling, data))
    x <- data[!is.na(return_1yr), .N]
    data[(x + 1):(x + rolling[, .N])]$V1 <- data[(1:rolling[, .N])]$V1
    data <- data[!(1:rolling[, .N])]
    data$year <- as.numeric(data$year)
  }
  else {
    NULL
  }
  if (sum(data$return_1yr) > 0) {
    data <- data %>% select(year, return_1yr, ava_return, arr, V1)
  }
  else {
    NULL
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
  #Melting data from wide to long format
  graph <- data.table(melt(data, id.vars = "year"))
  
  lineColors <- c(palette_reason$Orange, palette_reason$Yellow, 
                  palette_reason$SatBlue, palette_reason$LightGrey)
  options(repr.plot.width = 1, repr.plot.height = 0.75)
  
  #Graphing
  ggplot2::ggplot(graph, ggplot2::aes(x = year, y = yaxisScale * 
  value, group = variable)) + 
    ggplot2::geom_line(ggplot2::aes(colour = str_wrap(factor(variable), 
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
          legend.position = c(0.33, 0.09))
}
