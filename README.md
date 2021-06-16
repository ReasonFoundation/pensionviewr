---
output: github_document
always_allow_html: yes
---

# pensionviewr

The goal of `pensionviewr` is to simplify the process of gathering and visualizing public pension plan data from the Reason pension database. This repo contains the functions of the `pensionviewr` package, which once installed locally, provides helpful functions for creating and exporting graphics made in ggplot in the style used by the Reason Pension Integrity Project team.

## Create Token:
To use devtools you'd need to authenticate yourself by
creating Personal Access Tokens (PAT):

  - Obtain a PAT by typing `usethis::browse_github_pat()`.
Click "Generate token" and Copy to Clipboard the displayed string of 40 letters/digits.
  - Find your .Renviron in your home directory by typing:
`usethis::edit_r_environ()`
  - Put your PAT in your .Renviron file. Have a line that looks like this:
`GITHUB_PAT=8c70fd8419398999c9ac5bacf3192882193cadf2` (but use your own PAT instead)
  - Save edited .Renviron file, and
  - Lastly, restart R & check your PAT by typing:
`Sys.getenv("GITHUB_PAT")`
## Installing pensionviewr

`pensionviewr` is not on CRAN, so you will have to install it directly from Github using `devtools`. 

If you do not have the `devtools` package installed, you will have to run the first line in the code below as well. 

``` r
install.packages('devtools')
devtools::install_github("ReasonFoundation/pensionviewr")
```

## Using the functions:

* The package has seven functions for data pulling and preparation: 
`planList()`, 
`pullData()`, 
`pullStateData()`,
`pullSourceData()`,
`filterData()`,
`masterView()`,
`loadData()`, and 
`selectedData()`.

* The package has four functions for plots: 
`glPlot()`, 
`linePlot()`, 
`areaPlot()`, 
`barPlot()`, and
`savePlot()`.

* The package has Reason color palette: 
`palette_reason` (e.g. `palette_reason$Orange`))

A basic explanation and summary here:

### `planList()`

1. `planList()`: returns a stripped down list of the pension plans in the database along with their state and the internal databse id.

Example of how it is used in a standard workflow:

```{r planList}
pl <- planList()
pl %>% 
  head() %>%
  kable() %>%
  kable_styling(full_width = FALSE, position = "left")
```

### `pullData()`

2. `pullData()`:  pulls the data for a specified plan from the Reason pension database. `pullData` has two arguments:
`pullData(pl, plan_name)`

* `pl`: A dataframe containing the list of plan names, states, and ids in the form produced by the `planList()` function.
* `plan_name`: A string enclosed in quotation marks containing a plan name as it is listed in the Reason pension database.

Example of how it is used in a standard workflow:

The next step would be to load the data for the specific plan of interest. Let's use the Vermont State Retirement System as an example. Let's first see what plans in Vermont are available:

```{r Kansas}
VT <- pl %>% filter(state == 'Vermont')
VT %>% 
  kable() %>%
  kable_styling(full_width = FALSE, position = "left")
```

The full plan name we are interested in is there listed as "Vermont State Retirement System". We can pull the data for it now:

```{r pullData}
vtsrs_data <- pullData(pl, plan_name = "Vermont State Retirement System")
vtsrs_data %>% 
  head() %>%
  kable() %>%
  kable_styling(full_width = FALSE, position = "left")
```

### `pullStateData()`

3. `pullStateData()`: pulls all state-level pension data in wide format from the Reason pension database. `pullStateData` has a single argument:
`pullStateData(fy)`

* `fy`: Starting fiscal year for the data pulled from the Reason pension database.

This could be the initial step for either making state-level pension analysis or then filter pulled data for a specific state plan.
Example of how it is used in a standard workflow:

```{r pullStateData}
state.data <- pullStateData(2001)
New_Mexico.data <- state.data %>% filter(state == 'New Mexico')
NMERB.data <- state.data %>% filter(display_name == "New Mexico Educational Retirement Board")
state.data <- state.data %>% filter(year == 2019)#filter for 2019 for display
state.data %>% 
  head() %>%
  kable() %>%
  kable_styling(full_width = FALSE, position = "left")
```

### `pullSourceData()`

4. `pullSourceData()`: pulls pension data for a specific plan, along with `data_source_name` column in wide format from the Reason pension database. `pullSourceData(pl,plan_name, fy)` has 3 arguments:

* `pl`: A dataframe containing the list of plan names, states, and ids in the form produced by the `planList()` function.
* `plan_name`: A string enclosed in quotation marks containing a plan name as it is listed in the Reason pension database.
* `fy`: Starting fiscal year for the data pulled from the Reason pension database.

Example how this function is used:

```{r pullSourceData}
NMERB.source <- pullSourceData(pl, "New Mexico Educational Retirement Board", 2001)
NMERB.source %>% 
  head() %>%
  kable() %>%
  kable_styling(full_width = FALSE, position = "left")
```

### `filterData()`

5. `filterData()`: filters existing data (data.frame/data.table format) keeping & renaming set of commonly used variables in pension analysis. `filterData(Data, fy, source = FALSE)` has 4 arguments:

* `Data`: A data table already pulled with `pullData`, `pullStateData`, or other ways. 
* `fy`: Starting fiscal year for the data pulled from the Reason pension database.
* `employee`: Character designating type of employees covered (e.g. "teacher", "state", "local", "state and local", "police and fire").
* `source`: Set to `FALSE`. It should be set to `source = TRUE` if you filter data pulled with `pullSourceData` function.

Example of the workflow around the filtering function:

```{r filterData}
state.data <- pullStateData(2001)
filtered <- filterData(state.data, 2010)
filtered %>% 
  head() %>%
  kable() %>%
  kable_styling(full_width = FALSE, position = "left")
```

### `masterView()`

6. `masterView()`: allows to view list of mapped & unmapped columns in pension database per data source.
`masterView(source = NULL, expand = FALSE)` has 2 arguments:

* `source`: main data sources: "Reason", "Public Plans Database", "Census".
* `expand`: Set to `FALSE` (default) to see mapped variables. Change to `TRUE` if you want to see all unmapped variables.

Example of how to use this function:

```{r masterView}
view.reason <- masterView("Reason", FALSE)
view.reason %>% 
  head() %>%
  kable() %>%
  kable_styling(full_width = FALSE, position = "left")
```

### `loadData`

7. `loadData`: loads the data for a specified plan from an Excel file. `loadData` has one argument:

`loadData(file_name)`

* `file_name`: A string enclosed in quotation marks containing a file name with path of a pension plan Excel data file.

```
data_from_file <- loadData('data/NorthCarolina_PensionDatabase_TSERS.xlsx')
```

### `selectedData()`

8. `selectedData()`: selects the only the variables used in historical analyses. `selectedData` has one argument, `wide_data`, that is required:

`selectedData(wide_data)`

* `wide_data`: a datasource in wide format

Back to the Kansas Public Employees' example. That is a lot of variables. The `selectedData()` function selects only a handful of needed variables:

```
df <- selectedData(vtsrs_data)
df %>% 
  head() %>%
  kable() %>%
  kable_styling(full_width = FALSE, position = "left")
```

### `glPlot()`

9. `glPlot()`: creates the 'Gain/Loss' plot using a CSV file as an input. glPlot has two arguments:

`glPlot(filename, ylab_unit)`

* `filename`: a csv (comma separated value) file containing columns of gain loss category names with one row of values.
* `ylab_unit`: a string contained within quotation marks containing th y-axis label unit. The default value is "Billions"

Example of how it is used in a standard workflow:

`filename <- "data/GainLoss_data.csv"`
`glPlot(filename)`

### `linePlot()`

10. `linePlot()`: creates a line chart comparing up to 5 variables, such as ADEC vs. Actual contributions. `linePlot()` has 22 arguments, with `data` being required:

`linePlot(data, title, caption, grid, interactive, Ytitle, treasury, inv.returns, ticks, font, yaxisMin, yaxisMax, yaxisSeq, yaxisScale, format, str, labelY, lab1, lab2, lab3, lab4, lab5)`

* `data` a dataframe produced by the filterData function or in the same format.
* `title` naming the chart (e.g. "Unfunded Liability Growth").
* `caption` set to `TRUE` to add "reason.org/pensions" caption at the bottom right corner
* `grid` set to `TRUE` to add major gridlines
* `ticks` set to `FALSE` to remove ticks
* `interactive` set to `TRUE` to create interactive plot
* `Ytitle` naming the Y-axis title
* `treasury` if set to `TRUE` shows 30-Year treasury Yields on the secondary Y-axis
* `inv.returns` if set to `FALSE` allows to graph anything other than Investment Return graph 
* `yaxisMin` minimum value for Y-axis 
* `yaxisMax` maximum value for Y-axis 
* `yaxisSeq` value that sets space between Major breaks.
* `yaxisScale` value that sets Y-axis scale. Example: 100 for percentages or 1/1000 for thousands.
* `format` format of Y-axis scale. Examples: "%", "$", or something else.
* `str` value that sets number of strings at which to cut legend text -- Defaulted to 20.
* `labelY` title of the Y-axis.
* `lab1` text label for the 1st variable - optional.
* `lab2` text label for the 2nd variable - optional.
* `lab3` text label for the 3rd variable - optional.
* `lab4` text label for the 4th variable - optional.
* `lab5` text label for the 5th variable - optional.

Example of how it is used in a standard workflow:
```
graph <- linePlot(data = PERSI.data, title = "", inv.returns = TRUE, treasury = FALSE,
                  interactive = TRUE, Ytitle = NULL,
                  font = "Calibri", yaxisMin = -21, yaxisMax = 21, yaxisSeq = 3,
                  yaxisScale = 100, format = "%", str = 60,
                  labelY = "", 
                  lab1 = "Market Valued Returns (Actual)", 
                  lab2 = "Actuarially Valued Investment Return (Smoothed by Plan)", 
                  lab3 = "Assumed Rate of Return", 
                  lab4 = "10-Year Geometric Rolling Average")
```

### `areaPlot()`

11. `areaPlot()`: creates Mountain of Debt or S&P500 chart. `areaPlot` has seven arguments, with `data` being required:

`areaPlot(data, title, caption, grid, ticks, sp500, font)`

* `data` a dataframe or data.table produced by the pullStateData function or in the same format.
* `title` naming the chart (e.g. "Unfunded Liability Growth").
* `caption` set to `TRUE` to add "reason.org/pensions" caption at the bottom right corner
* `grid` set to TRUE to add major gridlines
* `ticks` Set to `FALSE` to remove ticks
* `sp500` default is `FALSE` for Mountain of Debt chart. Set sp500 to `TRUE` to visualize annual S&P500 Index values on the secondary Y-axis
* `font` directly paste name of a font (e.g. "Calibri") to change the default font of the text

Example of how it is used in a standard workflow:
```
debt <- areaPlot(PERSI.debt, caption = F, grid = F, ticks = F, sp500 = F, font = "Calibri")
```
### `barPlot()`

12. `barPlot()`:  creates bar charts for Compound Gain/Loss, Net Amortization, Stochastic, and ADEC vs. ERCs. `barPlot()` has 24 arguments, with `data` not being required for G/L or Stochastic charts:

`barplot(data, net.amo, contributions, compound.gl, gl.url, stochastic.alpha, Ymax, Ymin, Ybreak, yaxisScale, interactive, font, lab1, lab2, lab3, lab4, lab5, lab6, lab7, lab8, lab9)`

* `data`: data used for the bar chart (default it set to `NULL`) 
* `net.amo`: Set to `TRUE` to graph Net Amortization bar chart 
* `contributions`: Set to `TRUE` to graph ADEC vs. Actual Contribution bar chart 
* `compound.gl`: Set to `TRUE` to graph Compound Change in Gain/Loss bar chart 
* `gl.url`: Provide a url to GitHub or Dropbox file with Compound Gain/Loss data
* `str`: Length of legend text (default set to 25 characters),
* `stochastic`: Set to `TRUE` to graph Stochastic projections bar chart 
* `stochastic.url`: provide url to the file with Stochastic data outputs 
* `Ymax`: Set the Y-axis maximum value 
* `Ymin`: Set the Y-axis minimum value  
* `Ybreak`: Set the chucks for Y-axis breaks
* `yaxisScale`: Set the Y-axis scale (e.g., 1/1000000 – in $Millions)
* `stochastic.alpha`: Set the transparency for the blue color used for Stochastic bar chart (e.g., 0.95  - 5% transparent)
* `interactive`: Set to ‘TRUE`  to create an interactive, as opposed to static, chart (using ggplotly)
* `lab1`: Gain/Loss chart Legend 1 (e.g., "Investment Experience")
* `lab2`: Gain/Loss chart Legend 2 (e.g., "Benefit Changes")
* `lab3`: Gain/Loss chart Legend 3 (e.g.,"Changes to Actuarial Methods & Assumptions")
* `lab4`: Gain/Loss chart Legend 4 (e.g., "Deviations from Demographic Assumptions")
* `lab5`: Gain/Loss chart Legend 5 (e.g.,"Negative Amortization")
* `lab6`: Gain/Loss chart Legend 6 (e.g., "Gains From Pay Increases Not Given")
* `lab7`: Gain/Loss chart Legend 7 (e.g., "Net Change to Unfunded Liability")
* `lab8`: Gain/Loss chart Legend 8 (e.g., NULL)
* `lab9`: Gain/Loss chart Legend 9 (e.g., NULL)

Example of how it is used in a standard workflow:

```
barPlot <- function(
  data = NULL, 
  net.amo = FALSE, 
  contributions = FALSE, 
  compound.gl = TRUE,
  gl.url = "https://raw.githubusercontent.com/ReasonFoundation/GraphicsR/master/PERSI_GL2.csv",
  str = 25,
  stochastic = FALSE, 
  stochastic.url = "https://raw.githubusercontent.com/ReasonFoundation/databaseR/master/files/perctest2.csv",
  stochastic.alpha = 0.40,
  Ymax = 25,
  Ymin = 0,
  Ybreak = 5,
  yaxisScale = 1/1000000000, 
  interactive = FALSE,
  font = "Calibri",
  lab1 = "Investment Experience", 
  lab2 = "Benefit Changes",
  lab3 = "Changes to Actuarial Methods & Assumptions",
  lab4 = "Deviations from Demographic Assumptions",
  lab5 = "Negative Amortization",
  lab6 = "Gains From Pay Increases Not Given",
  lab7 = "Net Change to Unfunded Liability",
  lab8 = NULL,
  lab9 = NULL)
  
```

### `savePlot()`

13. `savePlot()`: adds a source and save ggplot chart. `savePlot` takes five arguments:
`savePlot(plot = myplot, source = "The source for my data", save_filepath = "filename_that_my_plot_should_be_saved_to.png", width_pixels = 648, height_pixels = 384.48)`

* `plot`: The variable name of the plot you have created that you want to format and save
* `source`: The text you want to come after the text 'Source:' in the bottom left hand side of your side
* `save_filepath`: Exact filepath that you want the plot to be saved to
* `width_pixels`: Width in pixels that you want to save your chart to - defaults to 648
* `height_pixels`: Height in pixels that you want to save your chart to - defaults to 384.48

```
savePlot(debt_plot, source = "Source: KPERS", save_filepath = "output/test.png")
```


The BBC has created a wonderful data journalism cookbook for R graphics located here:
https://bbc.github.io/rcookbook/
