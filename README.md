
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pensionviewr

The goal of `pensionviewr` is to simplify the process of gathering and
visualizing public pension plan data from the Reason pension database.
This repo contains the functions of the `pensionviewr` package, which
once installed locally, provides helpful functions for creating and
exporting graphics made in ggplot in the style used by the Reason
Pension Integrity Project team.

## Create Token:

To use devtools you’d need to authenticate yourself by creating Personal
Access Tokens (PAT):

  - Obtain a PAT by typing `usethis::browse_github_pat()`. Click
    “Generate token” and Copy to Clipboard the displayed string of 40
    letters/digits.
  - Find your .Renviron in your home directory by typing:
    `usethis::edit_r_environ()`
  - Put your PAT in your .Renviron file. Have a line that looks like
    this: `GITHUB_PAT=8c70fd8419398999c9ac5bacf3192882193cadf2` (but use
    your own PAT instead)
  - Save edited .Renviron file, and
  - Lastly, restart R & check your PAT by typing:
    `Sys.getenv("GITHUB_PAT")` \#\# Installing pensionviewr

`pensionviewr` is not on CRAN, so you will have to install it directly
from Github using `devtools`.

If you do not have the `devtools` package installed, you will have to
run the first line in the code below as well.

``` r
install.packages('devtools')
devtools::install_github("ReasonFoundation/pensionviewr")
```

## Using the functions:

  - The package has seven functions for data pulling and preparation:
    `planList()`, `pullData()`, `pullStateData()`, `pullSourceData()`,
    `filterData()`, `masterView()`, `loadData()`, and `selectedData()`.

  - The package has four functions for plots: `glPlot()`, `linePlot()`,
    `areaPlot()`, `barPlot()`, and `savePlot()`.

  - The package has Reason color palette: `palette_reason`
    (e.g. `palette_reason$Orange`))

A basic explanation and summary here:

### `planList()`

1.  `planList()`: returns a stripped down list of the pension plans in
    the database along with their state and the internal databse id.

Example of how it is used in a standard workflow:

``` r
pl <- planList()
pl %>% 
  head() %>%
  kable() %>%
  kable_styling(full_width = FALSE, position = "left")
```

<table class="table" style="width: auto !important; ">

<thead>

<tr>

<th style="text-align:right;">

id

</th>

<th style="text-align:left;">

display\_name

</th>

<th style="text-align:left;">

state

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

Alabama Clerks & Registrars Supernumerary Fund

</td>

<td style="text-align:left;">

Alabama

</td>

</tr>

<tr>

<td style="text-align:right;">

1

</td>

<td style="text-align:left;">

Alabama Employees’ Retirement System (ERS)

</td>

<td style="text-align:left;">

Alabama

</td>

</tr>

<tr>

<td style="text-align:right;">

3

</td>

<td style="text-align:left;">

Alabama Judicial Retirement Fund (JRF)

</td>

<td style="text-align:left;">

Alabama

</td>

</tr>

<tr>

<td style="text-align:right;">

4

</td>

<td style="text-align:left;">

Alabama Peace Officers Annuity Benefit Fund

</td>

<td style="text-align:left;">

Alabama

</td>

</tr>

<tr>

<td style="text-align:right;">

5

</td>

<td style="text-align:left;">

Alabama Port Authority Hourly Pension Plan

</td>

<td style="text-align:left;">

Alabama

</td>

</tr>

<tr>

<td style="text-align:right;">

6

</td>

<td style="text-align:left;">

Alabama Port Authority Terminal Railway Plan

</td>

<td style="text-align:left;">

Alabama

</td>

</tr>

</tbody>

</table>

### `pullData()`

2.  `pullData()`: pulls the data for a specified plan from the Reason
    pension database. `pullData` has two arguments: `pullData(pl,
    plan_name)`

<!-- end list -->

  - `pl`: A dataframe containing the list of plan names, states, and ids
    in the form produced by the `planList()` function.
  - `plan_name`: A string enclosed in quotation marks containing a plan
    name as it is listed in the Reason pension database.

Example of how it is used in a standard workflow:

The next step would be to load the data for the specific plan of
interest. Let’s use the Vermont State Retirement System as an example.
Let’s first see what plans in Vermont are available:

``` r
VT <- pl %>% filter(state == 'Vermont')
VT %>% 
  kable() %>%
  kable_styling(full_width = FALSE, position = "left")
```

<table class="table" style="width: auto !important; ">

<thead>

<tr>

<th style="text-align:right;">

id

</th>

<th style="text-align:left;">

display\_name

</th>

<th style="text-align:left;">

state

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:right;">

1945

</td>

<td style="text-align:left;">

Burlington Employees Retirement System

</td>

<td style="text-align:left;">

Vermont

</td>

</tr>

<tr>

<td style="text-align:right;">

1946

</td>

<td style="text-align:left;">

City Of South Burlington Employees Pension Plan

</td>

<td style="text-align:left;">

Vermont

</td>

</tr>

<tr>

<td style="text-align:right;">

1947

</td>

<td style="text-align:left;">

City Of St. Albans Pension Plan

</td>

<td style="text-align:left;">

Vermont

</td>

</tr>

<tr>

<td style="text-align:right;">

1950

</td>

<td style="text-align:left;">

Rockingham & Bellows Falls Employees’ Pension

</td>

<td style="text-align:left;">

Vermont

</td>

</tr>

<tr>

<td style="text-align:right;">

1948

</td>

<td style="text-align:left;">

Rutland City Pension Plan

</td>

<td style="text-align:left;">

Vermont

</td>

</tr>

<tr>

<td style="text-align:right;">

1949

</td>

<td style="text-align:left;">

St. Johnsbury Town Pension Plan

</td>

<td style="text-align:left;">

Vermont

</td>

</tr>

<tr>

<td style="text-align:right;">

1944

</td>

<td style="text-align:left;">

Vermont Municipal Employees Retirement System

</td>

<td style="text-align:left;">

Vermont

</td>

</tr>

<tr>

<td style="text-align:right;">

1942

</td>

<td style="text-align:left;">

Vermont State Retirement System

</td>

<td style="text-align:left;">

Vermont

</td>

</tr>

<tr>

<td style="text-align:right;">

1943

</td>

<td style="text-align:left;">

Vermont State Teachers’ Retirement System

</td>

<td style="text-align:left;">

Vermont

</td>

</tr>

<tr>

<td style="text-align:right;">

1951

</td>

<td style="text-align:left;">

Windsor Town Pension Plan

</td>

<td style="text-align:left;">

Vermont

</td>

</tr>

</tbody>

</table>

The full plan name we are interested in is there listed as “Vermont
State Retirement System”. We can pull the data for it now:

``` r
vtsrs_data <- pullData(pl, plan_name = "Vermont State Retirement System")
vtsrs_data %>% 
  head() %>%
  kable() %>%
  kable_styling(full_width = FALSE, position = "left")
```

<table class="table" style="width: auto !important; ">

<thead>

<tr>

<th style="text-align:left;">

year

</th>

<th style="text-align:right;">

plan\_id

</th>

<th style="text-align:left;">

display\_name

</th>

<th style="text-align:left;">

state

</th>

<th style="text-align:right;">

x1\_year\_investment\_return\_percentage

</th>

<th style="text-align:right;">

x10\_year\_investment\_return\_percentage

</th>

<th style="text-align:right;">

x3\_year\_investment\_return\_percentage

</th>

<th style="text-align:right;">

x5\_year\_investment\_return\_percentage

</th>

<th style="text-align:right;">

x7\_year\_investment\_return\_percentage

</th>

<th style="text-align:right;">

absolute\_return\_value\_fund\_actual\_allocation

</th>

<th style="text-align:right;">

absolute\_return\_value\_fund\_return

</th>

<th style="text-align:right;">

absolute\_return\_value\_fund\_target\_allocation

</th>

<th style="text-align:right;">

actuarial\_assets\_reported\_for\_asset\_smoothing

</th>

<th style="text-align:right;">

actuarial\_cost\_method\_code\_names\_for\_gasb

</th>

<th style="text-align:left;">

actuarial\_cost\_method\_in\_gasb\_reporting

</th>

<th style="text-align:right;">

actuarial\_experience\_dollar

</th>

<th style="text-align:left;">

actuarial\_firm

</th>

<th style="text-align:right;">

actuarial\_funded\_ratio\_percentage

</th>

<th style="text-align:left;">

actuarial\_valuation\_report\_date

</th>

<th style="text-align:right;">

actuarial\_value\_of\_assets\_dollar

</th>

<th style="text-align:right;">

actuarial\_value\_of\_assets\_gasb\_dollar

</th>

<th style="text-align:right;">

actuarially\_accrued\_liabilities\_dollar

</th>

<th style="text-align:right;">

actuarially\_determined\_contribution\_dollar

</th>

<th style="text-align:right;">

actuarially\_determined\_contribution\_missed\_dollar

</th>

<th style="text-align:right;">

actuarially\_required\_contribution\_dollar

</th>

<th style="text-align:right;">

actuarially\_required\_contribution\_paid\_dollar

</th>

<th style="text-align:right;">

actuarially\_required\_contribution\_paid\_percentage

</th>

<th style="text-align:right;">

adec\_as\_a\_percent\_of\_payroll

</th>

<th style="text-align:right;">

administering\_government\_type

</th>

<th style="text-align:left;">

administrating\_jurisdiction

</th>

<th style="text-align:right;">

administrative\_expense\_dollar

</th>

<th style="text-align:right;">

administrative\_expense\_in\_normal\_cost\_dollar

</th>

<th style="text-align:right;">

administrative\_expenses\_percentage

</th>

<th style="text-align:right;">

age\_of\_retirement\_experience\_dollar

</th>

<th style="text-align:right;">

amortization\_payment\_total\_amount

</th>

<th style="text-align:left;">

amortizaton\_method

</th>

<th style="text-align:right;">

amounts\_transmitted\_to\_federal\_social\_security\_system\_dollar

</th>

<th style="text-align:right;">

are\_most\_members\_covered\_by\_social\_security

</th>

<th style="text-align:right;">

asset\_smoothing\_baseline

</th>

<th style="text-align:right;">

asset\_smoothing\_baseline\_add\_or\_subtract\_gain\_loss

</th>

<th style="text-align:right;">

asset\_smoothing\_period\_for\_gasb\_reporting

</th>

<th style="text-align:right;">

asset\_valuation\_method\_code\_for\_gasb\_reporting

</th>

<th style="text-align:right;">

asset\_valuation\_method\_code\_for\_plan\_reporting

</th>

<th style="text-align:left;">

asset\_valuation\_method\_for\_gasb\_reporting

</th>

<th style="text-align:right;">

average\_age\_of\_actives

</th>

<th style="text-align:right;">

average\_benefit\_of\_beneficiaries

</th>

<th style="text-align:right;">

average\_salary\_of\_actives

</th>

<th style="text-align:right;">

average\_tenure\_of\_actives

</th>

<th style="text-align:right;">

basis\_of\_membership\_and\_participation

</th>

<th style="text-align:right;">

benefit\_payments\_dollar

</th>

<th style="text-align:right;">

benefits\_paid\_to\_disability\_retirees\_dollar

</th>

<th style="text-align:right;">

benefits\_paid\_to\_service\_retirees\_dollar

</th>

<th style="text-align:left;">

benefits\_website

</th>

<th style="text-align:right;">

blended\_discount\_rate

</th>

<th style="text-align:right;">

bonds\_corporate\_book\_value\_dollar

</th>

<th style="text-align:right;">

bonds\_corporate\_other\_book\_value\_dollar

</th>

<th style="text-align:right;">

bonds\_corporate\_other\_dollar

</th>

<th style="text-align:right;">

bonds\_federally\_sponsored\_investments\_dollar

</th>

<th style="text-align:right;">

cash\_and\_short\_term\_investments\_dollar

</th>

<th style="text-align:right;">

cash\_on\_hand\_and\_demand\_deposits\_dollar

</th>

<th style="text-align:right;">

cash\_short\_term\_actual\_allocation

</th>

<th style="text-align:right;">

cash\_short\_term\_return

</th>

<th style="text-align:right;">

census\_coverage\_type

</th>

<th style="text-align:right;">

census\_retirement\_system\_code

</th>

<th style="text-align:right;">

changes\_to\_methods\_assumptions\_dollar

</th>

<th style="text-align:right;">

closed\_plan

</th>

<th style="text-align:right;">

commodities\_actual\_allocation

</th>

<th style="text-align:right;">

commodities\_return

</th>

<th style="text-align:right;">

commodities\_target\_allocation

</th>

<th style="text-align:right;">

contribution\_rate\_effective\_fy

</th>

<th style="text-align:right;">

core\_fixed\_income\_actual\_allocation

</th>

<th style="text-align:right;">

core\_fixed\_income\_return

</th>

<th style="text-align:right;">

core\_fixed\_income\_target\_allocation

</th>

<th style="text-align:right;">

cost\_sharing

</th>

<th style="text-align:left;">

cost\_structure

</th>

<th style="text-align:right;">

covered\_payroll\_dollar

</th>

<th style="text-align:right;">

current\_gain\_loss\_amount

</th>

<th style="text-align:right;">

death\_benefits\_paid\_dollar

</th>

<th style="text-align:right;">

depreciation\_expense\_dollar

</th>

<th style="text-align:right;">

developed\_international\_equity\_actual\_allocation

</th>

<th style="text-align:right;">

developed\_international\_equity\_return

</th>

<th style="text-align:right;">

developed\_international\_equity\_target\_allocation

</th>

<th style="text-align:right;">

disability\_benefits\_paid\_dollar

</th>

<th style="text-align:right;">

disability\_claim\_experience\_total\_dollar

</th>

<th style="text-align:left;">

discount\_rate\_assumption

</th>

<th style="text-align:right;">

dividends\_income\_dollar

</th>

<th style="text-align:right;">

do\_employees\_contribute

</th>

<th style="text-align:right;">

domestic\_equity\_actual\_allocation

</th>

<th style="text-align:right;">

domestic\_equity\_return

</th>

<th style="text-align:right;">

domestic\_equity\_target\_allocation

</th>

<th style="text-align:right;">

domestic\_fixed\_income\_actual\_allocation

</th>

<th style="text-align:right;">

emerging\_fixed\_income\_actual\_allocation

</th>

<th style="text-align:right;">

emerging\_fixed\_income\_return

</th>

<th style="text-align:right;">

emerging\_fixed\_income\_target\_allocation

</th>

<th style="text-align:right;">

emerging\_international\_equity\_actual\_allocation

</th>

<th style="text-align:right;">

emerging\_international\_equity\_return

</th>

<th style="text-align:right;">

emerging\_international\_equity\_target\_allocation

</th>

<th style="text-align:right;">

employee\_contribution\_dollar

</th>

<th style="text-align:right;">

employee\_group\_id

</th>

<th style="text-align:right;">

employee\_normal\_cost\_percentage

</th>

<th style="text-align:right;">

employee\_normal\_cost\_percentage\_estimated\_categorical

</th>

<th style="text-align:right;">

employees\_receiving\_lump\_sum\_payments

</th>

<th style="text-align:right;">

employer\_contribution\_regular\_dollar

</th>

<th style="text-align:right;">

employer\_normal\_cost\_percentage

</th>

<th style="text-align:right;">

employer\_normal\_cost\_percentage\_estimated\_categorical

</th>

<th style="text-align:right;">

employer\_regular\_contribution\_dollar

</th>

<th style="text-align:right;">

employer\_state\_contribution\_dollar

</th>

<th style="text-align:right;">

employer\_type

</th>

<th style="text-align:right;">

employers\_projected\_actuarial\_required\_contribution\_percentage\_of\_payroll

</th>

<th style="text-align:right;">

estimated\_actuarial\_assets\_indicator

</th>

<th style="text-align:right;">

estimated\_actuarial\_funded\_ratio\_indicator

</th>

<th style="text-align:right;">

estimated\_actuarial\_liabilities\_indicator

</th>

<th style="text-align:right;">

estimated\_employers\_projected\_actuarial\_required\_contribution\_categorical

</th>

<th style="text-align:right;">

expected\_return\_method

</th>

<th style="text-align:right;">

fair\_value\_change\_investments

</th>

<th style="text-align:right;">

federal\_agency\_securities\_investments\_dollar

</th>

<th style="text-align:right;">

federal\_government\_securities\_investments\_dollar

</th>

<th style="text-align:right;">

federal\_treasury\_securities\_investments\_dollar

</th>

<th style="text-align:right;">

federally\_sponsored\_agnecy\_securities\_investments\_dollar

</th>

<th style="text-align:left;">

fiscal\_year\_end\_date

</th>

<th style="text-align:right;">

fiscal\_year\_of\_contribution

</th>

<th style="text-align:right;">

fiscal\_year\_type

</th>

<th style="text-align:right;">

fixed\_income\_actual\_allocation

</th>

<th style="text-align:right;">

fixed\_income\_return

</th>

<th style="text-align:right;">

fixed\_income\_target\_allocation

</th>

<th style="text-align:right;">

foreign\_and\_international\_securities\_investments\_1997\_2001\_dollar

</th>

<th style="text-align:right;">

foreign\_and\_international\_securities\_investments\_2001\_present\_dollar

</th>

<th style="text-align:right;">

former\_active\_members\_retired\_on\_account\_of\_age\_or\_service

</th>

<th style="text-align:right;">

former\_active\_members\_retired\_on\_account\_of\_disability

</th>

<th style="text-align:left;">

full\_state\_name

</th>

<th style="text-align:right;">

funding\_method\_code\_1\_for\_gasb\_reporting

</th>

<th style="text-align:right;">

funding\_method\_code\_2\_for\_gasb\_reporting

</th>

<th style="text-align:right;">

gain\_from\_investments\_dollar

</th>

<th style="text-align:right;">

gain\_loss\_base\_1

</th>

<th style="text-align:right;">

gain\_loss\_base\_2

</th>

<th style="text-align:right;">

gain\_loss\_concept

</th>

<th style="text-align:right;">

gain\_loss\_period

</th>

<th style="text-align:right;">

gain\_loss\_recognition

</th>

<th style="text-align:right;">

gain\_or\_loss\_due\_to\_changes\_in\_benefits

</th>

<th style="text-align:right;">

gain\_or\_loss\_due\_to\_changes\_in\_cola\_provisions

</th>

<th style="text-align:right;">

gain\_or\_loss\_due\_to\_normal\_cost\_prior\_year

</th>

<th style="text-align:right;">

gain\_loss\_periods\_phased\_in\_for\_asset\_smoothing

</th>

<th style="text-align:right;">

geometric\_growth\_percentage

</th>

<th style="text-align:right;">

geometric\_return\_percentage

</th>

<th style="text-align:right;">

global\_equity\_actual\_allocation

</th>

<th style="text-align:right;">

global\_equity\_return

</th>

<th style="text-align:right;">

global\_equity\_target\_allocation

</th>

<th style="text-align:right;">

global\_fixed\_income\_actual\_allocation

</th>

<th style="text-align:right;">

global\_fixed\_income\_return

</th>

<th style="text-align:right;">

global\_fixed\_income\_target\_allocation

</th>

<th style="text-align:right;">

gross\_or\_net\_investment\_returns\_categorical

</th>

<th style="text-align:right;">

gtaa\_gaa\_global\_macro\_hedge\_actual\_allocation

</th>

<th style="text-align:right;">

gtaa\_gaa\_global\_macro\_hedge\_return

</th>

<th style="text-align:right;">

gtaa\_gaa\_global\_macro\_hedge\_target\_allocation

</th>

<th style="text-align:right;">

hedge\_funds\_actual\_allocation

</th>

<th style="text-align:right;">

hedge\_funds\_return

</th>

<th style="text-align:right;">

hedge\_funds\_target\_allocation

</th>

<th style="text-align:right;">

high\_yield\_fixed\_income\_actual\_allocation

</th>

<th style="text-align:right;">

high\_yield\_fixed\_income\_return

</th>

<th style="text-align:right;">

high\_yield\_fixed\_income\_target\_allocation

</th>

<th style="text-align:right;">

inactive\_members

</th>

<th style="text-align:right;">

inflation\_linked\_bonds\_tips\_actual\_allocation

</th>

<th style="text-align:right;">

inflation\_linked\_bonds\_tips\_return

</th>

<th style="text-align:right;">

inflation\_linked\_bonds\_tips\_target\_allocation

</th>

<th style="text-align:right;">

inflation\_rate\_assumption\_for\_gasb\_reporting

</th>

<th style="text-align:right;">

interest\_and\_dividends\_income\_dollar

</th>

<th style="text-align:right;">

interest\_income\_dollar

</th>

<th style="text-align:right;">

interest\_on\_debt\_dollar

</th>

<th style="text-align:right;">

international\_equity\_actual\_allocation

</th>

<th style="text-align:right;">

international\_equity\_return

</th>

<th style="text-align:right;">

international\_equity\_target\_allocation

</th>

<th style="text-align:right;">

investment\_expenses\_dollar

</th>

<th style="text-align:right;">

investment\_experience\_dollar

</th>

<th style="text-align:left;">

investment\_return\_assumption\_for\_gasb\_reporting

</th>

<th style="text-align:right;">

investments\_held\_in\_trust\_by\_other\_agencies\_dollar

</th>

<th style="text-align:right;">

large\_cap\_domestic\_equity\_actual\_allocation

</th>

<th style="text-align:right;">

large\_cap\_domestic\_equity\_return

</th>

<th style="text-align:right;">

large\_cap\_domestic\_equity\_target\_allocation

</th>

<th style="text-align:right;">

local\_employee\_contribution\_dollar

</th>

<th style="text-align:right;">

local\_government\_active\_members

</th>

<th style="text-align:right;">

local\_government\_contribution\_dollar

</th>

<th style="text-align:right;">

loss\_from\_investments\_dollar

</th>

<th style="text-align:right;">

market\_assets\_reported\_for\_asset\_smoothing

</th>

<th style="text-align:right;">

market\_funded\_ratio\_percentage

</th>

<th style="text-align:right;">

market\_investment\_return\_mva\_basis

</th>

<th style="text-align:right;">

market\_value\_of\_assets\_dollar

</th>

<th style="text-align:right;">

market\_value\_of\_assets\_net\_of\_fees\_dollar

</th>

<th style="text-align:left;">

measurment\_date\_md

</th>

<th style="text-align:right;">

members\_covered\_by\_social\_security

</th>

<th style="text-align:right;">

membership\_data\_active

</th>

<th style="text-align:right;">

membership\_data\_inactive\_vested

</th>

<th style="text-align:right;">

membership\_data\_retirees\_and\_beneficiaries

</th>

<th style="text-align:right;">

membership\_data\_total

</th>

<th style="text-align:right;">

monthly\_lump\_sum\_payments\_to\_members\_dollar

</th>

<th style="text-align:right;">

monthly\_lump\_sum\_payments\_to\_survivors\_dollar

</th>

<th style="text-align:right;">

monthly\_payments\_to\_disabled\_dollar

</th>

<th style="text-align:right;">

monthly\_payments\_to\_retirees\_dollar

</th>

<th style="text-align:right;">

monthly\_payments\_to\_survivors\_dollar

</th>

<th style="text-align:right;">

mortality\_rate\_experience\_total\_dollar

</th>

<th style="text-align:right;">

mortgage\_investments\_dollar

</th>

<th style="text-align:right;">

multi\_asset\_class\_diversified\_return

</th>

<th style="text-align:left;">

multiple\_discount\_rates

</th>

<th style="text-align:right;">

net\_expenses\_dollar

</th>

<th style="text-align:right;">

net\_flows\_reported\_for\_asset\_smoothing

</th>

<th style="text-align:right;">

net\_pension\_liability\_assuming\_1\_percent\_decrease\_in\_discount\_rate

</th>

<th style="text-align:right;">

net\_pension\_liability\_assuming\_1\_percent\_increase\_in\_discount\_rate

</th>

<th style="text-align:right;">

net\_pension\_liability\_dollar

</th>

<th style="text-align:right;">

net\_position\_dollar

</th>

<th style="text-align:right;">

number\_of\_survivors

</th>

<th style="text-align:right;">

number\_of\_years\_remaining\_on\_amortization\_schedule

</th>

<th style="text-align:right;">

optional\_benefits\_available

</th>

<th style="text-align:right;">

other\_actuarial\_experience\_dollar

</th>

<th style="text-align:right;">

other\_actuarially\_accured\_liabilities\_dollar

</th>

<th style="text-align:right;">

other\_benefits\_paid\_dollar

</th>

<th style="text-align:right;">

other\_contribution\_dollar

</th>

<th style="text-align:right;">

other\_deductions\_dollar

</th>

<th style="text-align:right;">

other\_investments\_dollar

</th>

<th style="text-align:right;">

other\_investments\_income\_dollar

</th>

<th style="text-align:right;">

other\_payments\_dollar

</th>

<th style="text-align:right;">

other\_receipts\_paid\_dollar

</th>

<th style="text-align:right;">

other\_securities\_investments\_dollar

</th>

<th style="text-align:right;">

other\_actual\_allocation

</th>

<th style="text-align:right;">

payroll\_growth\_assumption

</th>

<th style="text-align:right;">

percent\_of\_gain\_loss\_to\_be\_phased\_in\_this\_year

</th>

<th style="text-align:left;">

plan\_full\_name

</th>

<th style="text-align:left;">

plan\_name

</th>

<th style="text-align:right;">

plan\_type

</th>

<th style="text-align:right;">

present\_value\_of\_future\_benefits\_for\_active\_members\_dollar

</th>

<th style="text-align:right;">

present\_value\_of\_future\_benefits\_for\_retired\_members\_dollar

</th>

<th style="text-align:left;">

prior\_measurment\_date

</th>

<th style="text-align:right;">

private\_debt\_actual\_allocation

</th>

<th style="text-align:right;">

private\_debt\_return

</th>

<th style="text-align:right;">

private\_debt\_target\_allocation

</th>

<th style="text-align:right;">

private\_equity\_actual\_allocation

</th>

<th style="text-align:right;">

private\_equity\_return

</th>

<th style="text-align:right;">

private\_equity\_target\_allocation

</th>

<th style="text-align:right;">

real\_estate\_actual\_allocation

</th>

<th style="text-align:right;">

real\_estate\_investments\_dollar

</th>

<th style="text-align:right;">

real\_estate\_return

</th>

<th style="text-align:right;">

real\_estate\_target\_allocation

</th>

<th style="text-align:right;">

receipts\_for\_transmittal\_to\_federal\_social\_security\_system\_dollar

</th>

<th style="text-align:right;">

refunds\_dollar

</th>

<th style="text-align:right;">

rehire\_experiennce\_dollar

</th>

<th style="text-align:right;">

rentals\_from\_state\_government\_dollar

</th>

<th style="text-align:right;">

retirement\_benefits\_paid\_dollar

</th>

<th style="text-align:right;">

risk\_parity\_actual\_allocation

</th>

<th style="text-align:right;">

risk\_parity\_return

</th>

<th style="text-align:right;">

risk\_parity\_target\_allocation

</th>

<th style="text-align:right;">

salary\_experience\_dollar

</th>

<th style="text-align:right;">

securities\_lending\_dollar

</th>

<th style="text-align:right;">

securities\_lending\_income\_dollar

</th>

<th style="text-align:right;">

short\_term\_investments\_dollar

</th>

<th style="text-align:right;">

small\_cap\_domestic\_equity\_actual\_allocation

</th>

<th style="text-align:right;">

small\_cap\_domestic\_equity\_return

</th>

<th style="text-align:right;">

small\_cap\_domestic\_equity\_target\_allocation

</th>

<th style="text-align:right;">

smoothing\_reset

</th>

<th style="text-align:left;">

social\_security\_coverage\_of\_plan\_members

</th>

<th style="text-align:left;">

state\_abbreviation

</th>

<th style="text-align:right;">

state\_and\_local\_government\_securitites\_investments\_dollar

</th>

<th style="text-align:right;">

state\_contribution\_for\_employee\_dollar

</th>

<th style="text-align:right;">

state\_contribution\_to\_own\_system\_on\_behalf\_of\_employees\_dollar

</th>

<th style="text-align:right;">

state\_employee\_contribution\_dollar

</th>

<th style="text-align:right;">

state\_government\_active\_members

</th>

<th style="text-align:right;">

stocks\_corporate\_book\_value\_dollar

</th>

<th style="text-align:right;">

stocks\_corporate\_dollar

</th>

<th style="text-align:right;">

survivior\_benefits\_paid\_dollar

</th>

<th style="text-align:right;">

survivors\_receiving\_lump\_sum\_payments

</th>

<th style="text-align:right;">

system\_id

</th>

<th style="text-align:right;">

tier\_id

</th>

<th style="text-align:right;">

timberland\_actual\_allocation

</th>

<th style="text-align:right;">

timberland\_return

</th>

<th style="text-align:right;">

time\_or\_savings\_deposits\_dollar

</th>

<th style="text-align:right;">

total\_active\_members

</th>

<th style="text-align:right;">

total\_additions\_dollar

</th>

<th style="text-align:right;">

total\_amortization\_payment\_percentage

</th>

<th style="text-align:right;">

total\_amount\_of\_active\_salaries\_payroll\_in\_dollars

</th>

<th style="text-align:right;">

total\_benefits\_paid\_dollar

</th>

<th style="text-align:right;">

total\_cash\_and\_securities\_investments\_dollar

</th>

<th style="text-align:right;">

total\_contribution\_dollar

</th>

<th style="text-align:right;">

total\_corporate\_bonds\_investments\_dollar

</th>

<th style="text-align:right;">

total\_earnings\_on\_investments\_dollar

</th>

<th style="text-align:right;">

total\_normal\_cost\_percentage

</th>

<th style="text-align:right;">

total\_normal\_cost\_percentage\_estimated\_categorical

</th>

<th style="text-align:right;">

total\_number\_of\_beneficiaries

</th>

<th style="text-align:right;">

total\_number\_of\_disability\_retirees

</th>

<th style="text-align:right;">

total\_number\_of\_inactive\_non\_vested

</th>

<th style="text-align:right;">

total\_number\_of\_inactive\_vested

</th>

<th style="text-align:right;">

total\_number\_of\_members

</th>

<th style="text-align:right;">

total\_number\_of\_other\_beneficiaries

</th>

<th style="text-align:right;">

total\_number\_of\_service\_retirees

</th>

<th style="text-align:right;">

total\_number\_of\_survivor\_beneficiaries

</th>

<th style="text-align:right;">

total\_other\_investments\_dollar

</th>

<th style="text-align:right;">

total\_other\_securities\_investments\_dollar

</th>

<th style="text-align:right;">

total\_pension\_liability\_dollar

</th>

<th style="text-align:right;">

total\_projected\_actuarial\_required\_contribution\_percentage\_of\_payroll

</th>

<th style="text-align:left;">

type\_of\_employees\_covered

</th>

<th style="text-align:right;">

unfunded\_actuarially\_accrued\_liabilities\_dollar

</th>

<th style="text-align:right;">

us\_treasury\_actual\_allocation

</th>

<th style="text-align:right;">

us\_treasury\_target\_allocation

</th>

<th style="text-align:right;">

vesting\_period

</th>

<th style="text-align:right;">

withdrawal\_experience\_dollar

</th>

<th style="text-align:right;">

year\_of\_inception

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

1987

</td>

<td style="text-align:right;">

1942

</td>

<td style="text-align:left;">

Vermont State Retirement System

</td>

<td style="text-align:left;">

Vermont

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

10937000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

55374000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

40324000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

16763000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

33406000

</td>

<td style="text-align:right;">

33406000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

159000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

72891000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

9570

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

12432000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

1988

</td>

<td style="text-align:right;">

1942

</td>

<td style="text-align:left;">

Vermont State Retirement System

</td>

<td style="text-align:left;">

Vermont

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

11939000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

74255000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

16755000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

17446000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

18254000

</td>

<td style="text-align:right;">

17970000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

1035000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

91137000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

10846

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

24801000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

1989

</td>

<td style="text-align:right;">

1942

</td>

<td style="text-align:left;">

Vermont State Retirement System

</td>

<td style="text-align:left;">

Vermont

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

12952000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

65332000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

36288000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

19053000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

52105000

</td>

<td style="text-align:right;">

46494000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

245000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

97577000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

9344

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

39059000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

1990

</td>

<td style="text-align:right;">

1942

</td>

<td style="text-align:left;">

Vermont State Retirement System

</td>

<td style="text-align:left;">

Vermont

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

14194000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

81205000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

24321000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

20993000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

42673000

</td>

<td style="text-align:right;">

33514000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

225000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

138437000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

9445

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

33700000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

1991

</td>

<td style="text-align:right;">

1942

</td>

<td style="text-align:left;">

Vermont State Retirement System

</td>

<td style="text-align:left;">

Vermont

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

16525000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

80874000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

11709000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

17681000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

41568000

</td>

<td style="text-align:right;">

41568000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

503000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

169474000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

9163

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

24380000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

1992

</td>

<td style="text-align:right;">

1942

</td>

<td style="text-align:left;">

Vermont State Retirement System

</td>

<td style="text-align:left;">

Vermont

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

18238000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

78964000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

33116000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

17523000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

40497000

</td>

<td style="text-align:right;">

40497000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

239000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

174366000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

9138

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

29164000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

</tr>

</tbody>

</table>

### `pullStateData()`

3.  `pullStateData()`: pulls all state-level pension data in wide format
    from the Reason pension database. `pullStateData` has a single
    argument: `pullStateData(fy)`

<!-- end list -->

  - `fy`: Starting fiscal year for the data pulled from the Reason
    pension database.

This could be the initial step for either making state-level pension
analysis or then filter pulled data for a specific state plan. Example
of how it is used in a standard workflow:

``` r
state.data <- pullStateData(2001)
New_Mexico.data <- state.data %>% filter(state == 'New Mexico')
NMERB.data <- state.data %>% filter(display_name == "New Mexico Educational Retirement Board")
state.data <- state.data %>% filter(year == 2019)#filter for 2019 for display
state.data %>% 
  head() %>%
  kable() %>%
  kable_styling(full_width = FALSE, position = "left")
```

<table class="table" style="width: auto !important; ">

<thead>

<tr>

<th style="text-align:left;">

year

</th>

<th style="text-align:right;">

plan\_id

</th>

<th style="text-align:left;">

display\_name

</th>

<th style="text-align:left;">

state

</th>

<th style="text-align:left;">

employee\_contribution\_dollar

</th>

<th style="text-align:left;">

actuarial\_funded\_ratio\_percentage

</th>

<th style="text-align:left;">

actuarially\_required\_contribution\_dollar

</th>

<th style="text-align:left;">

actuarially\_accrued\_liabilities\_dollar

</th>

<th style="text-align:left;">

employer\_state\_contribution\_dollar

</th>

<th style="text-align:left;">

type\_of\_employees\_covered

</th>

<th style="text-align:left;">

discount\_rate\_assumption

</th>

<th style="text-align:left;">

covered\_payroll\_dollar

</th>

<th style="text-align:left;">

actuarial\_cost\_method\_in\_gasb\_reporting

</th>

<th style="text-align:left;">

actuarial\_value\_of\_assets\_gasb\_dollar

</th>

<th style="text-align:left;">

number\_of\_years\_remaining\_on\_amortization\_schedule

</th>

<th style="text-align:left;">

actuarially\_required\_contribution\_paid\_percentage

</th>

<th style="text-align:left;">

market\_assets\_reported\_for\_asset\_smoothing

</th>

<th style="text-align:left;">

total\_pension\_liability\_dollar

</th>

<th style="text-align:left;">

total\_benefits\_paid\_dollar

</th>

<th style="text-align:left;">

fiscal\_year\_of\_contribution

</th>

<th style="text-align:left;">

asset\_valuation\_method\_for\_gasb\_reporting

</th>

<th style="text-align:left;">

employer\_contribution\_regular\_dollar

</th>

<th style="text-align:left;">

total\_normal\_cost\_percentage

</th>

<th style="text-align:left;">

unfunded\_actuarially\_accrued\_liabilities\_dollar

</th>

<th style="text-align:left;">

employee\_normal\_cost\_percentage

</th>

<th style="text-align:left;">

total\_amortization\_payment\_percentage

</th>

<th style="text-align:left;">

total\_normal\_cost\_dollar

</th>

<th style="text-align:left;">

statutory\_payment\_dollar

</th>

<th style="text-align:left;">

payroll\_growth\_assumption

</th>

<th style="text-align:left;">

employers\_projected\_actuarial\_required\_contribution\_percentage\_of\_payroll

</th>

<th style="text-align:left;">

amortizaton\_method

</th>

<th style="text-align:left;">

wage\_inflation

</th>

<th style="text-align:left;">

refunds\_dollar

</th>

<th style="text-align:left;">

market\_investment\_return\_mva\_basis

</th>

<th style="text-align:left;">

market\_value\_of\_assets\_dollar

</th>

<th style="text-align:left;">

statutory\_payment\_percentage

</th>

<th style="text-align:left;">

investment\_return\_assumption\_for\_gasb\_reporting

</th>

<th style="text-align:left;">

administrative\_expense\_dollar

</th>

<th style="text-align:left;">

benefit\_payments\_dollar

</th>

<th style="text-align:left;">

total\_contribution\_dollar

</th>

<th style="text-align:left;">

x1\_year\_investment\_return\_percentage

</th>

<th style="text-align:left;">

other\_contribution\_dollar

</th>

<th style="text-align:left;">

employer\_normal\_cost\_dollar

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

2019

</td>

<td style="text-align:right;">

1

</td>

<td style="text-align:left;">

Alabama Employees’ Retirement System (ERS)

</td>

<td style="text-align:left;">

Alabama

</td>

<td style="text-align:left;">

254439719

</td>

<td style="text-align:left;">

0.682

</td>

<td style="text-align:left;">

467553000

</td>

<td style="text-align:left;">

18543542000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

Plan covers state and local employees

</td>

<td style="text-align:left;">

0.077

</td>

<td style="text-align:left;">

3793957000

</td>

<td style="text-align:left;">

Entry Age Normal

</td>

<td style="text-align:left;">

12645789000

</td>

<td style="text-align:left;">

27.0

</td>

<td style="text-align:left;">

1.0

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

18353891000

</td>

<td style="text-align:left;">

\-1171825000

</td>

<td style="text-align:left;">

2022.0

</td>

<td style="text-align:left;">

5-year smoothed market

</td>

<td style="text-align:left;">

467553000

</td>

<td style="text-align:left;">

0.0861

</td>

<td style="text-align:left;">

5897753000

</td>

<td style="text-align:left;">

0.0714

</td>

<td style="text-align:left;">

0.143

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

0.1577

</td>

<td style="text-align:left;">

Level Percent Closed

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

47683000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

12568473000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

0.077

</td>

<td style="text-align:left;">

\-12934000

</td>

<td style="text-align:left;">

1130927500

</td>

<td style="text-align:left;">

721993000

</td>

<td style="text-align:left;">

0.0278

</td>

<td style="text-align:left;">

4187000

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

2019

</td>

<td style="text-align:right;">

2

</td>

<td style="text-align:left;">

Alabama Teachers’ Retirement System (TRS)

</td>

<td style="text-align:left;">

Alabama

</td>

<td style="text-align:left;">

522908600

</td>

<td style="text-align:left;">

0.694

</td>

<td style="text-align:left;">

869336000

</td>

<td style="text-align:left;">

37215470000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

Plan covers teachers

</td>

<td style="text-align:left;">

0.077

</td>

<td style="text-align:left;">

7193832000

</td>

<td style="text-align:left;">

Entry Age Normal

</td>

<td style="text-align:left;">

25821326000

</td>

<td style="text-align:left;">

27.0

</td>

<td style="text-align:left;">

1.0

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

36676350000

</td>

<td style="text-align:left;">

\-2290375000

</td>

<td style="text-align:left;">

2022.0

</td>

<td style="text-align:left;">

5-year smoothed market related value.

</td>

<td style="text-align:left;">

869336000

</td>

<td style="text-align:left;">

0.09118

</td>

<td style="text-align:left;">

11394144000

</td>

<td style="text-align:left;">

0.0708

</td>

<td style="text-align:left;">

0.1008

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

0.12119

</td>

<td style="text-align:left;">

Level Percent Closed

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

58538000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

25619448000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

0.077

</td>

<td style="text-align:left;">

\-20583000

</td>

<td style="text-align:left;">

2266860000

</td>

<td style="text-align:left;">

1392245000

</td>

<td style="text-align:left;">

0.0263

</td>

<td style="text-align:left;">

6234000

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

2019

</td>

<td style="text-align:right;">

25

</td>

<td style="text-align:left;">

Alaska Public Employees Retirement System

</td>

<td style="text-align:left;">

Alaska

</td>

<td style="text-align:left;">

79609000

</td>

<td style="text-align:left;">

0.637

</td>

<td style="text-align:left;">

414243000

</td>

<td style="text-align:left;">

15039180000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

Plan covers state and local employees

</td>

<td style="text-align:left;">

0.0738

</td>

<td style="text-align:left;">

1049152000

</td>

<td style="text-align:left;">

Entry Age Normal

</td>

<td style="text-align:left;">

9576693000

</td>

<td style="text-align:left;">

25.0

</td>

<td style="text-align:left;">

1.0101799999999999

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

14963635000

</td>

<td style="text-align:left;">

\-837381000

</td>

<td style="text-align:left;">

2022.0

</td>

<td style="text-align:left;">

5-year smoothed market

</td>

<td style="text-align:left;">

350601000

</td>

<td style="text-align:left;">

0.1477

</td>

<td style="text-align:left;">

5462487000

</td>

<td style="text-align:left;">

0.06964

</td>

<td style="text-align:left;">

0.39342

</td>

<td style="text-align:left;">

148395000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

0.47148

</td>

<td style="text-align:left;">

Level Percent Closed

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

\-10638000

</td>

<td style="text-align:left;">

0.054

</td>

<td style="text-align:left;">

9489405000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

0.0738

</td>

<td style="text-align:left;">

\-7429000

</td>

<td style="text-align:left;">

868825690

</td>

<td style="text-align:left;">

498067000

</td>

<td style="text-align:left;">

0.059

</td>

<td style="text-align:left;">

0

</td>

<td style="text-align:left;">

78445281

</td>

</tr>

<tr>

<td style="text-align:left;">

2019

</td>

<td style="text-align:right;">

24

</td>

<td style="text-align:left;">

Alaska Teachers Retirement System

</td>

<td style="text-align:left;">

Alaska

</td>

<td style="text-align:left;">

35763000

</td>

<td style="text-align:left;">

</td>

<td style="text-align:left;">

154083000

</td>

<td style="text-align:left;">

7388020000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

Plan covers teachers

</td>

<td style="text-align:left;">

0.0738

</td>

<td style="text-align:left;">

392601000

</td>

<td style="text-align:left;">

Entry Age Normal

</td>

<td style="text-align:left;">

5563931000

</td>

<td style="text-align:left;">

25.0

</td>

<td style="text-align:left;">

1.0654700000000001

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

7380472000

</td>

<td style="text-align:left;">

\-470414000

</td>

<td style="text-align:left;">

2022.0

</td>

<td style="text-align:left;">

5-year smoothed market

</td>

<td style="text-align:left;">

36805000

</td>

<td style="text-align:left;">

0.1467

</td>

<td style="text-align:left;">

1824089000

</td>

<td style="text-align:left;">

0.0436

</td>

<td style="text-align:left;">

0.36413

</td>

<td style="text-align:left;">

53688000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

0.46723000000000003

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

\-2303000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

5511929000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

0.0738

</td>

<td style="text-align:left;">

\-3018000

</td>

<td style="text-align:left;">

487631500

</td>

<td style="text-align:left;">

199933000

</td>

<td style="text-align:left;">

0.0639

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

37728785

</td>

</tr>

<tr>

<td style="text-align:left;">

2019

</td>

<td style="text-align:right;">

33

</td>

<td style="text-align:left;">

Arizona Corrections Officers Retirement Plan

</td>

<td style="text-align:left;">

Arizona

</td>

<td style="text-align:left;">

48549598

</td>

<td style="text-align:left;">

0.531

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

3884070116

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

Plan covers police and/or fire

</td>

<td style="text-align:left;">

0.073

</td>

<td style="text-align:left;">

547363066

</td>

<td style="text-align:left;">

Entry Age Normal

</td>

<td style="text-align:left;">

2063352240

</td>

<td style="text-align:left;">

17.0

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

1996273344

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

\-125481000

</td>

<td style="text-align:left;">

2021.0

</td>

<td style="text-align:left;">

7-year smoothed market:; subject to a 20% corridor.

</td>

<td style="text-align:left;">

137441000

</td>

<td style="text-align:left;">

0.15108

</td>

<td style="text-align:left;">

1820717876

</td>

<td style="text-align:left;">

0.08398

</td>

<td style="text-align:left;">

0.24026

</td>

<td style="text-align:left;">

83256164

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

0.30738000000000004

</td>

<td style="text-align:left;">

Level Percent Closed

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

\-28530000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

1996513000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

0.073

</td>

<td style="text-align:left;">

\-1448000

</td>

<td style="text-align:left;">

160313590

</td>

<td style="text-align:left;">

176123000

</td>

<td style="text-align:left;">

0.0545

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

36968238

</td>

</tr>

<tr>

<td style="text-align:left;">

2019

</td>

<td style="text-align:right;">

30

</td>

<td style="text-align:left;">

Arizona Public Safety Personnel Retirement System

</td>

<td style="text-align:left;">

Arizona

</td>

<td style="text-align:left;">

121556582

</td>

<td style="text-align:left;">

0.46399999999999997

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

17393828992

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

Plan covers police and/or fire

</td>

<td style="text-align:left;">

0.073

</td>

<td style="text-align:left;">

1419642895

</td>

<td style="text-align:left;">

Entry Age Normal

</td>

<td style="text-align:left;">

8097785858

</td>

<td style="text-align:left;">

17.0

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

7810990750

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

\-818430000

</td>

<td style="text-align:left;">

2021.0

</td>

<td style="text-align:left;">

7-year smoothed market value. 20% corridor.

</td>

<td style="text-align:left;">

832026000

</td>

<td style="text-align:left;">

0.22053000000000003

</td>

<td style="text-align:left;">

9314789253

</td>

<td style="text-align:left;">

0.07769

</td>

<td style="text-align:left;">

0.37037

</td>

<td style="text-align:left;">

335921280

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

0.035

</td>

<td style="text-align:left;">

0.5132

</td>

<td style="text-align:left;">

Level Percent Closed

</td>

<td style="text-align:left;">

0.035

</td>

<td style="text-align:left;">

\-15633000

</td>

<td style="text-align:left;">

0.067

</td>

<td style="text-align:left;">

7829913000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

0.073

</td>

<td style="text-align:left;">

\-7251000

</td>

<td style="text-align:left;">

850051750

</td>

<td style="text-align:left;">

980958000

</td>

<td style="text-align:left;">

0.054

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

217577090

</td>

</tr>

</tbody>

</table>

### `pullSourceData()`

4.  `pullSourceData()`: pulls pension data for a specific plan, along
    with `data_source_name` column in wide format from the Reason
    pension database. `pullSourceData(pl,plan_name, fy)` has 3
    arguments:

<!-- end list -->

  - `pl`: A dataframe containing the list of plan names, states, and ids
    in the form produced by the `planList()` function.
  - `plan_name`: A string enclosed in quotation marks containing a plan
    name as it is listed in the Reason pension database.
  - `fy`: Starting fiscal year for the data pulled from the Reason
    pension database.

Example how this function is used:

``` r
NMERB.source <- pullSourceData(pl, "New Mexico Educational Retirement Board", 2001)
NMERB.source %>% 
  head() %>%
  kable() %>%
  kable_styling(full_width = FALSE, position = "left")
```

<table class="table" style="width: auto !important; ">

<thead>

<tr>

<th style="text-align:left;">

year

</th>

<th style="text-align:right;">

plan\_id

</th>

<th style="text-align:left;">

display\_name

</th>

<th style="text-align:left;">

state

</th>

<th style="text-align:left;">

data\_source\_name

</th>

<th style="text-align:right;">

x1\_year\_investment\_return\_percentage

</th>

<th style="text-align:right;">

x10\_year\_investment\_return\_percentage

</th>

<th style="text-align:right;">

x15\_year\_investment\_return\_percentage

</th>

<th style="text-align:right;">

x20\_year\_investment\_return\_percentage

</th>

<th style="text-align:right;">

x25\_year\_investment\_return\_percentage

</th>

<th style="text-align:right;">

x3\_year\_investment\_return\_percentage

</th>

<th style="text-align:right;">

x30\_year\_investment\_return\_percentage

</th>

<th style="text-align:right;">

x5\_year\_investment\_return\_percentage

</th>

<th style="text-align:right;">

absolute\_return\_value\_fund\_actual\_allocation

</th>

<th style="text-align:right;">

absolute\_return\_value\_fund\_return

</th>

<th style="text-align:right;">

absolute\_return\_value\_fund\_target\_allocation

</th>

<th style="text-align:right;">

actual\_cola

</th>

<th style="text-align:right;">

actuarial\_assets\_reported\_for\_asset\_smoothing

</th>

<th style="text-align:right;">

actuarial\_cost\_method\_code\_names\_for\_gasb

</th>

<th style="text-align:left;">

actuarial\_cost\_method\_in\_gasb\_reporting

</th>

<th style="text-align:right;">

actuarial\_experience\_dollar

</th>

<th style="text-align:left;">

actuarial\_firm

</th>

<th style="text-align:right;">

actuarial\_funded\_ratio\_percentage

</th>

<th style="text-align:left;">

actuarial\_valuation\_report\_date

</th>

<th style="text-align:right;">

actuarial\_value\_of\_assets\_dollar

</th>

<th style="text-align:right;">

actuarial\_value\_of\_assets\_gasb\_dollar

</th>

<th style="text-align:right;">

actuarially\_accrued\_liabilities\_dollar

</th>

<th style="text-align:right;">

actuarially\_determined\_contribution\_dollar

</th>

<th style="text-align:right;">

actuarially\_determined\_contribution\_missed\_dollar

</th>

<th style="text-align:right;">

actuarially\_required\_contribution\_dollar

</th>

<th style="text-align:right;">

actuarially\_required\_contribution\_paid\_dollar

</th>

<th style="text-align:right;">

actuarially\_required\_contribution\_paid\_percentage

</th>

<th style="text-align:right;">

adec\_as\_a\_percent\_of\_payroll

</th>

<th style="text-align:right;">

administering\_government\_type

</th>

<th style="text-align:left;">

administrating\_jurisdiction

</th>

<th style="text-align:right;">

administrative\_expense\_dollar

</th>

<th style="text-align:right;">

administrative\_expense\_in\_normal\_cost\_dollar

</th>

<th style="text-align:right;">

administrative\_expenses\_percentage

</th>

<th style="text-align:right;">

amortization\_payment\_total\_amount

</th>

<th style="text-align:left;">

amortizaton\_method

</th>

<th style="text-align:right;">

amounts\_transmitted\_to\_federal\_social\_security\_system\_dollar

</th>

<th style="text-align:right;">

are\_most\_members\_covered\_by\_social\_security

</th>

<th style="text-align:right;">

asset\_smoothing\_baseline

</th>

<th style="text-align:right;">

asset\_smoothing\_baseline\_add\_or\_subtract\_gain\_loss

</th>

<th style="text-align:right;">

asset\_smoothing\_period\_for\_gasb\_reporting

</th>

<th style="text-align:right;">

asset\_valuation\_method\_code\_for\_gasb\_reporting

</th>

<th style="text-align:right;">

asset\_valuation\_method\_code\_for\_plan\_reporting

</th>

<th style="text-align:left;">

asset\_valuation\_method\_for\_gasb\_reporting

</th>

<th style="text-align:right;">

average\_age\_of\_actives

</th>

<th style="text-align:right;">

average\_benefit\_of\_beneficiaries

</th>

<th style="text-align:right;">

average\_benefit\_paid\_to\_service\_retirees

</th>

<th style="text-align:right;">

average\_salary\_of\_actives

</th>

<th style="text-align:right;">

average\_tenure\_of\_actives

</th>

<th style="text-align:right;">

basis\_of\_membership\_and\_participation

</th>

<th style="text-align:right;">

benefit\_payments\_dollar

</th>

<th style="text-align:right;">

benefits\_paid\_to\_disability\_retirees\_dollar

</th>

<th style="text-align:right;">

benefits\_paid\_to\_service\_retirees\_dollar

</th>

<th style="text-align:left;">

benefits\_website

</th>

<th style="text-align:right;">

blended\_discount\_rate

</th>

<th style="text-align:right;">

bonds\_corporate\_book\_value\_dollar

</th>

<th style="text-align:right;">

bonds\_corporate\_other\_book\_value\_dollar

</th>

<th style="text-align:right;">

bonds\_corporate\_other\_dollar

</th>

<th style="text-align:right;">

bonds\_federally\_sponsored\_investments\_dollar

</th>

<th style="text-align:right;">

cash\_and\_short\_term\_investments\_dollar

</th>

<th style="text-align:right;">

cash\_on\_hand\_and\_demand\_deposits\_dollar

</th>

<th style="text-align:right;">

cash\_short\_term\_actual\_allocation

</th>

<th style="text-align:right;">

cash\_short\_term\_return

</th>

<th style="text-align:right;">

cash\_short\_term\_target\_allocation

</th>

<th style="text-align:right;">

census\_coverage\_type

</th>

<th style="text-align:right;">

census\_retirement\_system\_code

</th>

<th style="text-align:right;">

changes\_to\_methods\_assumptions\_dollar

</th>

<th style="text-align:right;">

closed\_plan

</th>

<th style="text-align:right;">

contribution\_rate\_effective\_fy

</th>

<th style="text-align:right;">

cost\_sharing

</th>

<th style="text-align:left;">

cost\_structure

</th>

<th style="text-align:right;">

covered\_payroll\_dollar

</th>

<th style="text-align:right;">

disability\_benefits\_paid\_dollar

</th>

<th style="text-align:right;">

discount\_rate\_assumption

</th>

<th style="text-align:right;">

dividends\_income\_dollar

</th>

<th style="text-align:right;">

do\_employees\_contribute

</th>

<th style="text-align:right;">

domestic\_equity\_actual\_allocation

</th>

<th style="text-align:right;">

domestic\_equity\_return

</th>

<th style="text-align:right;">

domestic\_equity\_target\_allocation

</th>

<th style="text-align:right;">

employee\_contribution\_dollar

</th>

<th style="text-align:right;">

employee\_group\_id

</th>

<th style="text-align:right;">

employee\_normal\_cost\_percentage

</th>

<th style="text-align:right;">

employee\_normal\_cost\_percentage\_estimated\_categorical

</th>

<th style="text-align:right;">

employees\_receiving\_lump\_sum\_payments

</th>

<th style="text-align:right;">

employer\_contribution\_regular\_dollar

</th>

<th style="text-align:right;">

employer\_normal\_cost\_percentage

</th>

<th style="text-align:right;">

employer\_normal\_cost\_percentage\_estimated\_categorical

</th>

<th style="text-align:right;">

employer\_regular\_contribution\_dollar

</th>

<th style="text-align:right;">

employer\_state\_contribution\_dollar

</th>

<th style="text-align:right;">

employer\_type

</th>

<th style="text-align:right;">

employers\_projected\_actuarial\_required\_contribution\_percentage\_of\_payroll

</th>

<th style="text-align:right;">

estimated\_actuarial\_assets\_indicator

</th>

<th style="text-align:right;">

estimated\_actuarial\_funded\_ratio\_indicator

</th>

<th style="text-align:right;">

estimated\_actuarial\_liabilities\_indicator

</th>

<th style="text-align:right;">

estimated\_employers\_projected\_actuarial\_required\_contribution\_categorical

</th>

<th style="text-align:right;">

fair\_value\_change\_investments

</th>

<th style="text-align:right;">

federal\_agency\_securities\_investments\_dollar

</th>

<th style="text-align:right;">

federal\_government\_securities\_investments\_dollar

</th>

<th style="text-align:right;">

federal\_treasury\_securities\_investments\_dollar

</th>

<th style="text-align:right;">

federally\_sponsored\_agnecy\_securities\_investments\_dollar

</th>

<th style="text-align:left;">

fiscal\_year\_end\_date

</th>

<th style="text-align:right;">

fiscal\_year\_of\_contribution

</th>

<th style="text-align:right;">

fiscal\_year\_type

</th>

<th style="text-align:right;">

fixed\_income\_actual\_allocation

</th>

<th style="text-align:right;">

fixed\_income\_return

</th>

<th style="text-align:right;">

fixed\_income\_target\_allocation

</th>

<th style="text-align:right;">

foreign\_and\_international\_securities\_investments\_1997\_2001\_dollar

</th>

<th style="text-align:right;">

foreign\_and\_international\_securities\_investments\_2001\_present\_dollar

</th>

<th style="text-align:right;">

former\_active\_members\_retired\_on\_account\_of\_age\_or\_service

</th>

<th style="text-align:right;">

former\_active\_members\_retired\_on\_account\_of\_disability

</th>

<th style="text-align:left;">

full\_state\_name

</th>

<th style="text-align:right;">

funding\_method\_code\_1\_for\_gasb\_reporting

</th>

<th style="text-align:right;">

funding\_method\_code\_2\_for\_gasb\_reporting

</th>

<th style="text-align:right;">

gain\_from\_investments\_dollar

</th>

<th style="text-align:right;">

gain\_loss\_base\_1

</th>

<th style="text-align:right;">

gain\_loss\_base\_2

</th>

<th style="text-align:right;">

gain\_loss\_concept

</th>

<th style="text-align:right;">

gain\_loss\_period

</th>

<th style="text-align:right;">

gain\_loss\_recognition

</th>

<th style="text-align:right;">

gain\_or\_loss\_due\_to\_changes\_in\_benefits

</th>

<th style="text-align:right;">

gain\_or\_loss\_due\_to\_changes\_in\_cola\_provisions

</th>

<th style="text-align:right;">

gain\_or\_loss\_due\_to\_normal\_cost\_prior\_year

</th>

<th style="text-align:right;">

gain\_or\_loss\_due\_to\_other\_interest

</th>

<th style="text-align:right;">

gain\_loss\_periods\_phased\_in\_for\_asset\_smoothing

</th>

<th style="text-align:left;">

gain\_loss\_values\_to\_be\_included\_in\_smoothed\_asset\_calculation

</th>

<th style="text-align:right;">

gain\_loss\_values\_used\_in\_smoothing

</th>

<th style="text-align:right;">

geometric\_growth\_percentage

</th>

<th style="text-align:right;">

geometric\_return\_percentage

</th>

<th style="text-align:right;">

gross\_or\_net\_investment\_returns\_categorical

</th>

<th style="text-align:right;">

gtaa\_gaa\_global\_macro\_hedge\_actual\_allocation

</th>

<th style="text-align:right;">

gtaa\_gaa\_global\_macro\_hedge\_return

</th>

<th style="text-align:right;">

gtaa\_gaa\_global\_macro\_hedge\_target\_allocation

</th>

<th style="text-align:right;">

hedge\_funds\_actual\_allocation

</th>

<th style="text-align:right;">

hedge\_funds\_target\_allocation

</th>

<th style="text-align:right;">

inactive\_members

</th>

<th style="text-align:right;">

inflation\_rate\_assumption\_for\_gasb\_reporting

</th>

<th style="text-align:right;">

interest\_and\_dividends\_income\_dollar

</th>

<th style="text-align:right;">

interest\_income\_dollar

</th>

<th style="text-align:right;">

interest\_on\_debt\_dollar

</th>

<th style="text-align:right;">

international\_equity\_actual\_allocation

</th>

<th style="text-align:right;">

international\_equity\_return

</th>

<th style="text-align:right;">

international\_equity\_target\_allocation

</th>

<th style="text-align:right;">

investment\_expenses\_dollar

</th>

<th style="text-align:right;">

investment\_experience\_dollar

</th>

<th style="text-align:right;">

investment\_return\_assumption\_for\_gasb\_reporting

</th>

<th style="text-align:right;">

investments\_held\_in\_trust\_by\_other\_agencies\_dollar

</th>

<th style="text-align:right;">

local\_employee\_contribution\_dollar

</th>

<th style="text-align:right;">

local\_government\_active\_members

</th>

<th style="text-align:right;">

local\_government\_contribution\_dollar

</th>

<th style="text-align:right;">

loss\_from\_investments\_dollar

</th>

<th style="text-align:right;">

management\_fees\_for\_securities\_lending\_dollar

</th>

<th style="text-align:right;">

market\_assets\_reported\_for\_asset\_smoothing

</th>

<th style="text-align:right;">

market\_funded\_ratio\_percentage

</th>

<th style="text-align:right;">

market\_investment\_return\_mva\_basis

</th>

<th style="text-align:right;">

market\_value\_of\_assets\_dollar

</th>

<th style="text-align:right;">

market\_value\_of\_assets\_net\_of\_fees\_dollar

</th>

<th style="text-align:left;">

measurment\_date\_md

</th>

<th style="text-align:right;">

members\_covered\_by\_social\_security

</th>

<th style="text-align:right;">

membership\_data\_active

</th>

<th style="text-align:right;">

membership\_data\_inactive\_vested

</th>

<th style="text-align:right;">

membership\_data\_retirees\_and\_beneficiaries

</th>

<th style="text-align:right;">

membership\_data\_total

</th>

<th style="text-align:right;">

monthly\_lump\_sum\_payments\_to\_members\_dollar

</th>

<th style="text-align:right;">

monthly\_lump\_sum\_payments\_to\_survivors\_dollar

</th>

<th style="text-align:right;">

monthly\_payments\_to\_disabled\_dollar

</th>

<th style="text-align:right;">

monthly\_payments\_to\_retirees\_dollar

</th>

<th style="text-align:right;">

monthly\_payments\_to\_survivors\_dollar

</th>

<th style="text-align:right;">

mortgage\_investments\_dollar

</th>

<th style="text-align:left;">

multiple\_discount\_rates

</th>

<th style="text-align:right;">

net\_expenses\_dollar

</th>

<th style="text-align:right;">

net\_flows\_reported\_for\_asset\_smoothing

</th>

<th style="text-align:right;">

net\_pension\_liability\_assuming\_1\_percent\_decrease\_in\_discount\_rate

</th>

<th style="text-align:right;">

net\_pension\_liability\_assuming\_1\_percent\_increase\_in\_discount\_rate

</th>

<th style="text-align:right;">

net\_pension\_liability\_dollar

</th>

<th style="text-align:right;">

net\_position\_dollar

</th>

<th style="text-align:right;">

non\_investment\_actuarial\_experience\_dollar

</th>

<th style="text-align:right;">

number\_of\_survivors

</th>

<th style="text-align:right;">

number\_of\_years\_remaining\_on\_amortization\_schedule

</th>

<th style="text-align:right;">

optional\_benefits\_available

</th>

<th style="text-align:right;">

other\_actuarially\_accured\_liabilities\_dollar

</th>

<th style="text-align:right;">

other\_additions\_dollar

</th>

<th style="text-align:right;">

other\_benefits\_paid\_dollar

</th>

<th style="text-align:right;">

other\_contribution\_dollar

</th>

<th style="text-align:right;">

other\_deductions\_dollar

</th>

<th style="text-align:right;">

other\_investments\_dollar

</th>

<th style="text-align:right;">

other\_investments\_income\_dollar

</th>

<th style="text-align:right;">

other\_payments\_dollar

</th>

<th style="text-align:right;">

other\_receipts\_paid\_dollar

</th>

<th style="text-align:right;">

other\_securities\_investments\_dollar

</th>

<th style="text-align:right;">

payroll\_growth\_assumption

</th>

<th style="text-align:right;">

percent\_of\_gain\_loss\_to\_be\_phased\_in\_this\_year

</th>

<th style="text-align:left;">

plan\_full\_name

</th>

<th style="text-align:left;">

plan\_name

</th>

<th style="text-align:right;">

plan\_type

</th>

<th style="text-align:right;">

present\_value\_of\_future\_benefits\_for\_active\_members\_dollar

</th>

<th style="text-align:right;">

present\_value\_of\_future\_benefits\_for\_inactive\_vested\_members\_dollar

</th>

<th style="text-align:right;">

present\_value\_of\_future\_benefits\_for\_retired\_members\_dollar

</th>

<th style="text-align:left;">

prior\_measurment\_date

</th>

<th style="text-align:right;">

private\_equity\_actual\_allocation

</th>

<th style="text-align:right;">

private\_equity\_return

</th>

<th style="text-align:right;">

private\_equity\_target\_allocation

</th>

<th style="text-align:right;">

real\_assets\_real\_return\_actual\_allocation

</th>

<th style="text-align:right;">

real\_assets\_real\_return\_return

</th>

<th style="text-align:right;">

real\_assets\_real\_return\_target\_allocation

</th>

<th style="text-align:right;">

real\_estate\_actual\_allocation

</th>

<th style="text-align:right;">

real\_estate\_investments\_dollar

</th>

<th style="text-align:right;">

real\_estate\_return

</th>

<th style="text-align:right;">

real\_estate\_target\_allocation

</th>

<th style="text-align:right;">

receipts\_for\_transmittal\_to\_federal\_social\_security\_system\_dollar

</th>

<th style="text-align:right;">

refunds\_dollar

</th>

<th style="text-align:right;">

rentals\_from\_state\_government\_dollar

</th>

<th style="text-align:right;">

retirement\_benefits\_paid\_dollar

</th>

<th style="text-align:right;">

risk\_parity\_actual\_allocation

</th>

<th style="text-align:right;">

risk\_parity\_return

</th>

<th style="text-align:right;">

risk\_parity\_target\_allocation

</th>

<th style="text-align:right;">

securities\_lending\_dollar

</th>

<th style="text-align:right;">

securities\_lending\_income\_dollar

</th>

<th style="text-align:right;">

securities\_lending\_rebates\_dollar

</th>

<th style="text-align:right;">

short\_term\_investments\_dollar

</th>

<th style="text-align:right;">

smoothing\_reset

</th>

<th style="text-align:left;">

social\_security\_coverage\_of\_plan\_members

</th>

<th style="text-align:left;">

state\_abbreviation

</th>

<th style="text-align:right;">

state\_and\_local\_government\_securitites\_investments\_dollar

</th>

<th style="text-align:right;">

state\_contribution\_for\_employee\_dollar

</th>

<th style="text-align:right;">

state\_contribution\_to\_own\_system\_on\_behalf\_of\_employees\_dollar

</th>

<th style="text-align:right;">

state\_employee\_contribution\_dollar

</th>

<th style="text-align:right;">

state\_government\_active\_members

</th>

<th style="text-align:right;">

statutory\_payment\_dollar

</th>

<th style="text-align:right;">

statutory\_payment\_percentage

</th>

<th style="text-align:right;">

stocks\_corporate\_book\_value\_dollar

</th>

<th style="text-align:right;">

stocks\_corporate\_dollar

</th>

<th style="text-align:right;">

survivior\_benefits\_paid\_dollar

</th>

<th style="text-align:right;">

survivors\_receiving\_lump\_sum\_payments

</th>

<th style="text-align:right;">

system\_id

</th>

<th style="text-align:right;">

tier\_id

</th>

<th style="text-align:right;">

time\_or\_savings\_deposits\_dollar

</th>

<th style="text-align:right;">

total\_active\_members

</th>

<th style="text-align:right;">

total\_additions\_dollar

</th>

<th style="text-align:right;">

total\_amortization\_payment\_percentage

</th>

<th style="text-align:right;">

total\_amount\_of\_active\_salaries\_payroll\_in\_dollars

</th>

<th style="text-align:right;">

total\_benefits\_paid\_dollar

</th>

<th style="text-align:right;">

total\_cash\_and\_securities\_investments\_dollar

</th>

<th style="text-align:right;">

total\_contribution\_dollar

</th>

<th style="text-align:right;">

total\_corporate\_bonds\_investments\_dollar

</th>

<th style="text-align:right;">

total\_earnings\_on\_investments\_dollar

</th>

<th style="text-align:right;">

total\_normal\_cost\_percentage

</th>

<th style="text-align:right;">

total\_normal\_cost\_percentage\_estimated\_categorical

</th>

<th style="text-align:right;">

total\_number\_of\_beneficiaries

</th>

<th style="text-align:right;">

total\_number\_of\_disability\_retirees

</th>

<th style="text-align:right;">

total\_number\_of\_inactive\_non\_vested

</th>

<th style="text-align:right;">

total\_number\_of\_inactive\_vested

</th>

<th style="text-align:right;">

total\_number\_of\_members

</th>

<th style="text-align:right;">

total\_number\_of\_other\_beneficiaries

</th>

<th style="text-align:right;">

total\_number\_of\_service\_retirees

</th>

<th style="text-align:right;">

total\_number\_of\_survivor\_beneficiaries

</th>

<th style="text-align:right;">

total\_other\_investments\_dollar

</th>

<th style="text-align:right;">

total\_other\_securities\_investments\_dollar

</th>

<th style="text-align:right;">

total\_pension\_liability\_dollar

</th>

<th style="text-align:right;">

total\_projected\_actuarial\_required\_contribution\_percentage\_of\_payroll

</th>

<th style="text-align:left;">

type\_of\_employees\_covered

</th>

<th style="text-align:right;">

unfunded\_actuarially\_accrued\_liabilities\_dollar

</th>

<th style="text-align:right;">

vesting\_period

</th>

<th style="text-align:right;">

wage\_inflation

</th>

<th style="text-align:right;">

year\_of\_inception

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

2001

</td>

<td style="text-align:right;">

1473

</td>

<td style="text-align:left;">

New Mexico Educational Retirement Board

</td>

<td style="text-align:left;">

New Mexico

</td>

<td style="text-align:left;">

Census

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

8951000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

1308289000

</td>

<td style="text-align:right;">

681939000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

104654000

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

45636000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

193695000

</td>

<td style="text-align:right;">

774624000

</td>

<td style="text-align:right;">

580929000

</td>

<td style="text-align:right;">

626350000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

1072736000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

19914

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

18201

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

1082000

</td>

<td style="text-align:right;">

60155

</td>

<td style="text-align:right;">

104433000

</td>

<td style="text-align:right;">

978573000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

27929602000

</td>

<td style="text-align:right;">

453371000

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

2277

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

458224000

</td>

<td style="text-align:right;">

186029000

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

346877000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

104654000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

45636000

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

160442000

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

3005398000

</td>

<td style="text-align:right;">

3005398000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

7070802000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

1308289000

</td>

<td style="text-align:right;">

\-761401000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

458224000

</td>

<td style="text-align:right;">

1419613000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

2001

</td>

<td style="text-align:right;">

1473

</td>

<td style="text-align:left;">

New Mexico Educational Retirement Board

</td>

<td style="text-align:left;">

New Mexico

</td>

<td style="text-align:left;">

PPD Investment Data

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0.016

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0.507

</td>

<td style="text-align:right;">

\-0.277

</td>

<td style="text-align:right;">

0.53

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0.315

</td>

<td style="text-align:right;">

0.116

</td>

<td style="text-align:right;">

0.3

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0.162

</td>

<td style="text-align:right;">

\-0.248

</td>

<td style="text-align:right;">

0.17

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

2001

</td>

<td style="text-align:right;">

1473

</td>

<td style="text-align:left;">

New Mexico Educational Retirement Board

</td>

<td style="text-align:left;">

New Mexico

</td>

<td style="text-align:left;">

Public Plans Database

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

1

</td>

<td style="text-align:left;">

Entry Age Normal

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

2001-06-30

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

7418300000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:left;">

New Mexico

</td>

<td style="text-align:right;">

\-3517803

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

Level Dollar Open

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

1

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

5-year smoothed market value.

</td>

<td style="text-align:right;">

44.9

</td>

<td style="text-align:right;">

15288

</td>

<td style="text-align:right;">

15939

</td>

<td style="text-align:right;">

30248

</td>

<td style="text-align:right;">

9.2

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

339158220

</td>

<td style="text-align:right;">

4235904

</td>

<td style="text-align:right;">

317670310

</td>

<td style="text-align:left;">

<https://www.nmerb.org/handbook.html>

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

1

</td>

<td style="text-align:left;">

Multiple employer, cost sharing plan

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

\-5440446

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

31142922

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

0.076

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

161524340

</td>

<td style="text-align:right;">

0.0512

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

2

</td>

<td style="text-align:right;">

0.0865

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

\-978573000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

2001-06-30

</td>

<td style="text-align:right;">

2002

</td>

<td style="text-align:right;">

1

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

New Mexico

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

1

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

\-0.101

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0.03

</td>

<td style="text-align:right;">

173709880

</td>

<td style="text-align:right;">

142566950

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

\-4790177

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

\-642.939

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

6667002000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

\-380747410

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

12

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

3689430

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

\-12949806

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0.03

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

Educational Retirement Board of New Mexico

</td>

<td style="text-align:left;">

New Mexico Educational

</td>

<td style="text-align:right;">

2

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

3604455500

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

\-23684105

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

\-335155220

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

\-37826469

</td>

<td style="text-align:right;">

39773012

</td>

<td style="text-align:right;">

\-37183527

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

Plan members covered by Social Security

</td>

<td style="text-align:left;">

NM

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

66

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

60155

</td>

<td style="text-align:right;">

\-492424590

</td>

<td style="text-align:right;">

0.0353

</td>

<td style="text-align:right;">

1.82e+08

</td>

<td style="text-align:right;">

\-340595690

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

311592750

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0.1272

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

22191

</td>

<td style="text-align:right;">

580

</td>

<td style="text-align:right;">

13401

</td>

<td style="text-align:right;">

4800

</td>

<td style="text-align:right;">

87146

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

19930

</td>

<td style="text-align:right;">

1681

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0.1625

</td>

<td style="text-align:left;">

Plan covers teachers

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0.045

</td>

<td style="text-align:right;">

1937

</td>

</tr>

<tr>

<td style="text-align:left;">

2001

</td>

<td style="text-align:right;">

1473

</td>

<td style="text-align:left;">

New Mexico Educational Retirement Board

</td>

<td style="text-align:left;">

New Mexico

</td>

<td style="text-align:left;">

Reason

</td>

<td style="text-align:right;">

\-0.111

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0.02

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

\-76071151

</td>

<td style="text-align:left;">

GABRIEL, ROEDER, SMITH & COMPANY

</td>

<td style="text-align:right;">

0.919

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

7418300000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

8070300000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

161524340

</td>

<td style="text-align:right;">

161524340

</td>

<td style="text-align:right;">

1

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0.0005276

</td>

<td style="text-align:right;">

\-98800000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

31870125

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

2002

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

1819600000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0.08

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

153719801

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

220238258

</td>

<td style="text-align:right;">

\-3800236

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

49982161

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

100065963

</td>

<td style="text-align:right;">

0.08

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0.095

</td>

<td style="text-align:right;">

6667001941

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

No

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

\-208007239

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

159064846

</td>

<td style="text-align:right;">

0.0865

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

6.52e+08

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

2001

</td>

<td style="text-align:right;">

1473

</td>

<td style="text-align:left;">

New Mexico Educational Retirement Board

</td>

<td style="text-align:left;">

New Mexico

</td>

<td style="text-align:left;">

Reason

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

GABRIEL, ROEDER, SMITH & COMPANY

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

2002

</td>

<td style="text-align:right;">

1473

</td>

<td style="text-align:left;">

New Mexico Educational Retirement Board

</td>

<td style="text-align:left;">

New Mexico

</td>

<td style="text-align:left;">

Census

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

8325000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

1000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

601701000

</td>

<td style="text-align:right;">

438659000

</td>

<td style="text-align:right;">

189327000

</td>

<td style="text-align:right;">

79000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

4000

</td>

<td style="text-align:right;">

4000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

1000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

50405000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

363111000

</td>

<td style="text-align:right;">

819111000

</td>

<td style="text-align:right;">

456000000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

992565000

</td>

<td style="text-align:right;">

23052

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

19931

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

725000

</td>

<td style="text-align:right;">

61091

</td>

<td style="text-align:right;">

123458000

</td>

<td style="text-align:right;">

746928000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

61091

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

28508035000

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

3412081000

</td>

<td style="text-align:right;">

27482492000

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

2000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

22250000

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

849456000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

189248000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

50405000

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

107511000

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

2898147000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

6788966000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

1040360000

</td>

<td style="text-align:right;">

\-558763000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

1842021000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

1000

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

NA

</td>

</tr>

</tbody>

</table>

### `filterData()`

5.  `filterData()`: filters existing data (data.frame/data.table format)
    keeping & renaming set of commonly used variables in pension
    analysis. `filterData(Data, fy, source = FALSE)` has 4 arguments:

<!-- end list -->

  - `Data`: A data table already pulled with `pullData`,
    `pullStateData`, or other ways.
  - `fy`: Starting fiscal year for the data pulled from the Reason
    pension database.
  - `employee`: Character designating type of employees covered
    (e.g. “teacher”, “state”, “local”, “state and local”, “police and
    fire”).
  - `source`: Set to `FALSE`. It should be set to `source = TRUE` if you
    filter data pulled with `pullSourceData` function.

Example of the workflow around the filtering function:

``` r
state.data <- pullStateData(2001)
filtered <- filterData(state.data, 2010)
filtered %>% 
  head() %>%
  kable() %>%
  kable_styling(full_width = FALSE, position = "left")
```

<table class="table" style="width: auto !important; ">

<thead>

<tr>

<th style="text-align:right;">

year

</th>

<th style="text-align:left;">

plan\_name

</th>

<th style="text-align:left;">

state

</th>

<th style="text-align:left;">

return\_1yr

</th>

<th style="text-align:left;">

ava\_return

</th>

<th style="text-align:left;">

actuarial\_cost\_method\_in\_gasb\_reporting

</th>

<th style="text-align:left;">

funded\_ratio

</th>

<th style="text-align:left;">

ava

</th>

<th style="text-align:left;">

mva

</th>

<th style="text-align:left;">

mva\_smooth

</th>

<th style="text-align:left;">

aal

</th>

<th style="text-align:left;">

tpl

</th>

<th style="text-align:left;">

adec

</th>

<th style="text-align:left;">

adec\_paid\_pct

</th>

<th style="text-align:left;">

statutory

</th>

<th style="text-align:left;">

statutory\_pct

</th>

<th style="text-align:left;">

amortizaton\_method

</th>

<th style="text-align:left;">

total\_benefit\_payments

</th>

<th style="text-align:left;">

benefit\_payments

</th>

<th style="text-align:left;">

refunds

</th>

<th style="text-align:left;">

admin\_exp

</th>

<th style="text-align:left;">

cost\_structure

</th>

<th style="text-align:left;">

asset\_valuation\_method\_for\_gasb\_reporting

</th>

<th style="text-align:left;">

payroll

</th>

<th style="text-align:left;">

ee\_contribution

</th>

<th style="text-align:left;">

ee\_nc\_pct

</th>

<th style="text-align:left;">

er\_contribution

</th>

<th style="text-align:left;">

er\_nc\_pct

</th>

<th style="text-align:left;">

er\_state\_contribution

</th>

<th style="text-align:left;">

er\_proj\_adec\_pct

</th>

<th style="text-align:left;">

other\_contribution

</th>

<th style="text-align:left;">

other\_additions

</th>

<th style="text-align:right;">

fy\_contribution

</th>

<th style="text-align:left;">

inflation\_assum

</th>

<th style="text-align:left;">

arr

</th>

<th style="text-align:left;">

dr

</th>

<th style="text-align:left;">

number\_of\_years\_remaining\_on\_amortization\_schedule

</th>

<th style="text-align:left;">

payroll\_growth\_assumption

</th>

<th style="text-align:left;">

total\_amortization\_payment\_pct

</th>

<th style="text-align:left;">

total\_contribution

</th>

<th style="text-align:left;">

total\_nc\_pct

</th>

<th style="text-align:left;">

total\_nc\_dollar

</th>

<th style="text-align:left;">

total\_number\_of\_members

</th>

<th style="text-align:left;">

total\_proj\_adec\_pct

</th>

<th style="text-align:left;">

type\_of\_employees\_covered

</th>

<th style="text-align:left;">

unfunded\_actuarially\_accrued\_liabilities\_dollar

</th>

<th style="text-align:left;">

wage\_inflation

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:right;">

2010

</td>

<td style="text-align:left;">

Alabama Employees’ Retirement System (ERS)

</td>

<td style="text-align:left;">

Alabama

</td>

<td style="text-align:left;">

0.0847

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

Entry Age Normal

</td>

<td style="text-align:left;">

0.682

</td>

<td style="text-align:left;">

9739331000

</td>

<td style="text-align:left;">

8176732000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

14284119000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

377898000

</td>

<td style="text-align:left;">

1

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

Level Percent Open

</td>

<td style="text-align:left;">

\-759528000

</td>

<td style="text-align:left;">

778328440

</td>

<td style="text-align:left;">

24874000

</td>

<td style="text-align:left;">

\-10334000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

5-year smoothed market related value.

</td>

<td style="text-align:left;">

3619670000

</td>

<td style="text-align:left;">

196757338

</td>

<td style="text-align:left;">

0.0502

</td>

<td style="text-align:left;">

377898000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

147593000

</td>

<td style="text-align:left;">

0.0795

</td>

<td style="text-align:left;">

1790000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

2013

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

0.08

</td>

<td style="text-align:left;">

0.08

</td>

<td style="text-align:left;">

29.0

</td>

<td style="text-align:left;">

0.045

</td>

<td style="text-align:left;">

0.0491

</td>

<td style="text-align:left;">

574656000

</td>

<td style="text-align:left;">

0.0806

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

Plan covers state and local employees

</td>

<td style="text-align:left;">

4544788000

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:right;">

2011

</td>

<td style="text-align:left;">

Alabama Employees’ Retirement System (ERS)

</td>

<td style="text-align:left;">

Alabama

</td>

<td style="text-align:left;">

0.0221

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

Entry Age Normal

</td>

<td style="text-align:left;">

0.658

</td>

<td style="text-align:left;">

9456158000

</td>

<td style="text-align:left;">

8130435000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

14366796000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

394998000

</td>

<td style="text-align:left;">

1

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

Level Percent Open

</td>

<td style="text-align:left;">

\-819755000

</td>

<td style="text-align:left;">

827273750

</td>

<td style="text-align:left;">

36798000

</td>

<td style="text-align:left;">

\-10002000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

5-year smoothed market related value.

</td>

<td style="text-align:left;">

3540681000

</td>

<td style="text-align:left;">

195709253

</td>

<td style="text-align:left;">

0.0501

</td>

<td style="text-align:left;">

394998000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

183221000

</td>

<td style="text-align:left;">

0.1126

</td>

<td style="text-align:left;">

2012000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

2014

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

0.08

</td>

<td style="text-align:left;">

0.08

</td>

<td style="text-align:left;">

29.0

</td>

<td style="text-align:left;">

0.0325

</td>

<td style="text-align:left;">

0.0849

</td>

<td style="text-align:left;">

590707000

</td>

<td style="text-align:left;">

0.0778

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

Plan covers state and local employees

</td>

<td style="text-align:left;">

4910638000

</td>

<td style="text-align:left;">

0.0325

</td>

</tr>

<tr>

<td style="text-align:right;">

2012

</td>

<td style="text-align:left;">

Alabama Employees’ Retirement System (ERS)

</td>

<td style="text-align:left;">

Alabama

</td>

<td style="text-align:left;">

0.1801

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

Entry Age Normal

</td>

<td style="text-align:left;">

0.657

</td>

<td style="text-align:left;">

9116551000

</td>

<td style="text-align:left;">

9188696000

</td>

<td style="text-align:left;">

9116551305

</td>

<td style="text-align:left;">

13884995000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

317520000

</td>

<td style="text-align:left;">

1

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

Level Percent Open

</td>

<td style="text-align:left;">

\-889210000

</td>

<td style="text-align:left;">

864958380

</td>

<td style="text-align:left;">

40746000

</td>

<td style="text-align:left;">

\-10616000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

Market Value.

</td>

<td style="text-align:left;">

3252003000

</td>

<td style="text-align:left;">

216870614

</td>

<td style="text-align:left;">

0.0726

</td>

<td style="text-align:left;">

317520000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

118646000

</td>

<td style="text-align:left;">

0.1198

</td>

<td style="text-align:left;">

1937000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

2015

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

0.08

</td>

<td style="text-align:left;">

0.08

</td>

<td style="text-align:left;">

28.0

</td>

<td style="text-align:left;">

0.0325

</td>

<td style="text-align:left;">

0.096

</td>

<td style="text-align:left;">

534390000

</td>

<td style="text-align:left;">

0.0964

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

Plan covers state and local employees

</td>

<td style="text-align:left;">

4768444000

</td>

<td style="text-align:left;">

0.0325

</td>

</tr>

<tr>

<td style="text-align:right;">

2013

</td>

<td style="text-align:left;">

Alabama Employees’ Retirement System (ERS)

</td>

<td style="text-align:left;">

Alabama

</td>

<td style="text-align:left;">

0.146

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

Entry Age Normal

</td>

<td style="text-align:left;">

0.657

</td>

<td style="text-align:left;">

9546459000

</td>

<td style="text-align:left;">

10091940000

</td>

<td style="text-align:left;">

10012966727

</td>

<td style="text-align:left;">

14536600000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

338819000

</td>

<td style="text-align:left;">

1

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

Level Percent Closed

</td>

<td style="text-align:left;">

\-940312000

</td>

<td style="text-align:left;">

898211880

</td>

<td style="text-align:left;">

44837000

</td>

<td style="text-align:left;">

\-9767000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

Market Value.

</td>

<td style="text-align:left;">

3400596000

</td>

<td style="text-align:left;">

223646119

</td>

<td style="text-align:left;">

0.0748

</td>

<td style="text-align:left;">

338819000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

125363000

</td>

<td style="text-align:left;">

0.1222

</td>

<td style="text-align:left;">

1823000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

2016

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

0.08

</td>

<td style="text-align:left;">

0.08

</td>

<td style="text-align:left;">

28.0

</td>

<td style="text-align:left;">

0.0325

</td>

<td style="text-align:left;">

0.0971

</td>

<td style="text-align:left;">

562465000

</td>

<td style="text-align:left;">

0.0999

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

Plan covers state and local employees

</td>

<td style="text-align:left;">

4990141000

</td>

<td style="text-align:left;">

0.0325

</td>

</tr>

<tr>

<td style="text-align:right;">

2014

</td>

<td style="text-align:left;">

Alabama Employees’ Retirement System (ERS)

</td>

<td style="text-align:left;">

Alabama

</td>

<td style="text-align:left;">

0.1202

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

Entry Age Normal

</td>

<td style="text-align:left;">

0.669

</td>

<td style="text-align:left;">

10134581000

</td>

<td style="text-align:left;">

10883952000

</td>

<td style="text-align:left;">

10803109967

</td>

<td style="text-align:left;">

15138294000

</td>

<td style="text-align:left;">

15525291000

</td>

<td style="text-align:left;">

379163000

</td>

<td style="text-align:left;">

0.0

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

Level Percent Closed

</td>

<td style="text-align:left;">

\-996414000

</td>

<td style="text-align:left;">

930223380

</td>

<td style="text-align:left;">

47937000

</td>

<td style="text-align:left;">

\-9612000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

5-year market related value.

</td>

<td style="text-align:left;">

3444341000

</td>

<td style="text-align:left;">

226014854

</td>

<td style="text-align:left;">

0.0746

</td>

<td style="text-align:left;">

391181000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

144736000

</td>

<td style="text-align:left;">

0.1195

</td>

<td style="text-align:left;">

2881000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

2017

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

0.08

</td>

<td style="text-align:left;">

0.08

</td>

<td style="text-align:left;">

28.0

</td>

<td style="text-align:left;">

0.0325

</td>

<td style="text-align:left;">

0.0943

</td>

<td style="text-align:left;">

617197000

</td>

<td style="text-align:left;">

0.0998

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

Plan covers state and local employees

</td>

<td style="text-align:left;">

5003713000

</td>

<td style="text-align:left;">

0.0325

</td>

</tr>

<tr>

<td style="text-align:right;">

2015

</td>

<td style="text-align:left;">

Alabama Employees’ Retirement System (ERS)

</td>

<td style="text-align:left;">

Alabama

</td>

<td style="text-align:left;">

0.0105

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

Entry Age Normal

</td>

<td style="text-align:left;">

0.673

</td>

<td style="text-align:left;">

10589258000

</td>

<td style="text-align:left;">

10551904000

</td>

<td style="text-align:left;">

10485255746

</td>

<td style="text-align:left;">

15723720000

</td>

<td style="text-align:left;">

15960732000

</td>

<td style="text-align:left;">

411087000

</td>

<td style="text-align:left;">

1.0

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

Level Percent Closed

</td>

<td style="text-align:left;">

\-1069539000

</td>

<td style="text-align:left;">

966982560

</td>

<td style="text-align:left;">

51024000

</td>

<td style="text-align:left;">

\-11136000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

5-year market related value.

</td>

<td style="text-align:left;">

3488017000

</td>

<td style="text-align:left;">

229253696

</td>

<td style="text-align:left;">

0.0744

</td>

<td style="text-align:left;">

410932000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

136977000

</td>

<td style="text-align:left;">

0.117

</td>

<td style="text-align:left;">

3487000

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:right;">

2018

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

0.08

</td>

<td style="text-align:left;">

0.08

</td>

<td style="text-align:left;">

28.0

</td>

<td style="text-align:left;">

0.0325

</td>

<td style="text-align:left;">

0.0921

</td>

<td style="text-align:left;">

640186000

</td>

<td style="text-align:left;">

0.0993

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

Plan covers state and local employees

</td>

<td style="text-align:left;">

5134462000

</td>

<td style="text-align:left;">

0.0325

</td>

</tr>

</tbody>

</table>

### `masterView()`

6.  `masterView()`: allows to view list of mapped & unmapped columns in
    pension database per data source. `masterView(source = NULL, expand
    = FALSE)` has 2 arguments:

<!-- end list -->

  - `source`: main data sources: “Reason”, “Public Plans Database”,
    “Census”.
  - `expand`: Set to `FALSE` (default) to see mapped variables. Change
    to `TRUE` if you want to see all unmapped variables.

Example of how to use this function:

``` r
view.reason <- masterView("Reason", FALSE)
view.reason %>% 
  head() %>%
  kable() %>%
  kable_styling(full_width = FALSE, position = "left")
```

<table class="table" style="width: auto !important; ">

<thead>

<tr>

<th style="text-align:right;">

master\_attribute\_id

</th>

<th style="text-align:left;">

master\_attribute\_name

</th>

<th style="text-align:right;">

priority

</th>

<th style="text-align:right;">

plan\_attribute\_id

</th>

<th style="text-align:left;">

attribute\_name

</th>

<th style="text-align:left;">

attribute\_column\_name

</th>

<th style="text-align:left;">

data\_source\_name

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:right;">

1

</td>

<td style="text-align:left;">

Market Value of Assets Dollar

</td>

<td style="text-align:right;">

100

</td>

<td style="text-align:right;">

10996

</td>

<td style="text-align:left;">

Market Value of Assets

</td>

<td style="text-align:left;">

mva

</td>

<td style="text-align:left;">

Reason

</td>

</tr>

<tr>

<td style="text-align:right;">

2

</td>

<td style="text-align:left;">

Actuarially Accrued Liabilities Dollar

</td>

<td style="text-align:right;">

100

</td>

<td style="text-align:right;">

10990

</td>

<td style="text-align:left;">

Actuarial Acrrued Liability

</td>

<td style="text-align:left;">

aal

</td>

<td style="text-align:left;">

Reason

</td>

</tr>

<tr>

<td style="text-align:right;">

3

</td>

<td style="text-align:left;">

Covered Payroll Dollar

</td>

<td style="text-align:right;">

100

</td>

<td style="text-align:right;">

10993

</td>

<td style="text-align:left;">

Covered Payroll

</td>

<td style="text-align:left;">

payroll

</td>

<td style="text-align:left;">

Reason

</td>

</tr>

<tr>

<td style="text-align:right;">

4

</td>

<td style="text-align:left;">

1 Year Investment Return Percentage

</td>

<td style="text-align:right;">

100

</td>

<td style="text-align:right;">

10981

</td>

<td style="text-align:left;">

Market Investment Return (MVA Basis)

</td>

<td style="text-align:left;">

market\_return

</td>

<td style="text-align:left;">

Reason

</td>

</tr>

<tr>

<td style="text-align:right;">

25

</td>

<td style="text-align:left;">

Actuarial Funded Ratio Percentage

</td>

<td style="text-align:right;">

100

</td>

<td style="text-align:right;">

10992

</td>

<td style="text-align:left;">

GASB 25 Funded Ratio

</td>

<td style="text-align:left;">

fundedratio\_old

</td>

<td style="text-align:left;">

Reason

</td>

</tr>

<tr>

<td style="text-align:right;">

30

</td>

<td style="text-align:left;">

Actuarial Value of Assets Dollar

</td>

<td style="text-align:right;">

100

</td>

<td style="text-align:right;">

10989

</td>

<td style="text-align:left;">

Actuarial Value of Assets

</td>

<td style="text-align:left;">

ava

</td>

<td style="text-align:left;">

Reason

</td>

</tr>

</tbody>

</table>

### `loadData`

7.  `loadData`: loads the data for a specified plan from an Excel file.
    `loadData` has one argument:

`loadData(file_name)`

  - `file_name`: A string enclosed in quotation marks containing a file
    name with path of a pension plan Excel data file.

<!-- end list -->

    data_from_file <- loadData('data/NorthCarolina_PensionDatabase_TSERS.xlsx')

### `selectedData()`

8.  `selectedData()`: selects the only the variables used in historical
    analyses. `selectedData` has one argument, `wide_data`, that is
    required:

`selectedData(wide_data)`

  - `wide_data`: a datasource in wide format

Back to the Kansas Public Employees’ example. That is a lot of
variables. The `selectedData()` function selects only a handful of
needed variables:

    df <- selectedData(vtsrs_data)
    df %>% 
      head() %>%
      kable() %>%
      kable_styling(full_width = FALSE, position = "left")

### `glPlot()`

9.  `glPlot()`: creates the ‘Gain/Loss’ plot using a CSV file as an
    input. glPlot has two arguments:

`glPlot(filename, ylab_unit)`

  - `filename`: a csv (comma separated value) file containing columns of
    gain loss category names with one row of values.
  - `ylab_unit`: a string contained within quotation marks containing th
    y-axis label unit. The default value is “Billions”

Example of how it is used in a standard workflow:

`filename <- "data/GainLoss_data.csv"` `glPlot(filename)`

### `linePlot()`

10. `linePlot()`: creates a line chart comparing up to 5 variables, such
    as ADEC vs. Actual contributions. `linePlot()` has 22 arguments,
    with `data` being required:

`linePlot(data, title, caption, grid, interactive, Ytitle, treasury,
inv.returns, ticks, font, yaxisMin, yaxisMax, yaxisSeq, yaxisScale,
format, str, labelY, lab1, lab2, lab3, lab4, lab5)`

  - `data` a dataframe produced by the filterData function or in the
    same format.
  - `title` naming the chart (e.g. “Unfunded Liability Growth”).
  - `caption` set to `TRUE` to add “reason.org/pensions” caption at the
    bottom right corner
  - `grid` set to `TRUE` to add major gridlines
  - `ticks` set to `FALSE` to remove ticks
  - `interactive` set to `TRUE` to create interactive plot
  - `Ytitle` naming the Y-axis title
  - `treasury` if set to `TRUE` shows 30-Year treasury Yields on the
    secondary Y-axis
  - `inv.returns` if set to `FALSE` allows to graph anything other than
    Investment Return graph
  - `yaxisMin` minimum value for Y-axis
  - `yaxisMax` maximum value for Y-axis
  - `yaxisSeq` value that sets space between Major breaks.
  - `yaxisScale` value that sets Y-axis scale. Example: 100 for
    percentages or 1/1000 for thousands.
  - `format` format of Y-axis scale. Examples: “%”, “$”, or something
    else.
  - `str` value that sets number of strings at which to cut legend text
    – Defaulted to 20.
  - `labelY` title of the Y-axis.
  - `lab1` text label for the 1st variable - optional.
  - `lab2` text label for the 2nd variable - optional.
  - `lab3` text label for the 3rd variable - optional.
  - `lab4` text label for the 4th variable - optional.
  - `lab5` text label for the 5th variable - optional.

Example of how it is used in a standard workflow:

    graph <- linePlot(data = PERSI.data, title = "", inv.returns = TRUE, treasury = FALSE,
                      interactive = TRUE, Ytitle = NULL,
                      font = "Calibri", yaxisMin = -21, yaxisMax = 21, yaxisSeq = 3,
                      yaxisScale = 100, format = "%", str = 60,
                      labelY = "", 
                      lab1 = "Market Valued Returns (Actual)", 
                      lab2 = "Actuarially Valued Investment Return (Smoothed by Plan)", 
                      lab3 = "Assumed Rate of Return", 
                      lab4 = "10-Year Geometric Rolling Average")

### `areaPlot()`

11. `areaPlot()`: creates Mountain of Debt or S\&P500 chart. `areaPlot`
    has seven arguments, with `data` being required:

`areaPlot(data, title, caption, grid, ticks, sp500, font)`

  - `data` a dataframe or data.table produced by the pullStateData
    function or in the same format.
  - `title` naming the chart (e.g. “Unfunded Liability Growth”).
  - `caption` set to `TRUE` to add “reason.org/pensions” caption at the
    bottom right corner
  - `grid` set to TRUE to add major gridlines
  - `ticks` Set to `FALSE` to remove ticks
  - `sp500` default is `FALSE` for Mountain of Debt chart. Set sp500 to
    `TRUE` to visualize annual S\&P500 Index values on the secondary
    Y-axis
  - `font` directly paste name of a font (e.g. “Calibri”) to change the
    default font of the text

Example of how it is used in a standard workflow:

    debt <- areaPlot(PERSI.debt, caption = F, grid = F, ticks = F, sp500 = F, font = "Calibri")

### `barPlot()`

12. `barPlot()`: creates bar charts for Compound Gain/Loss, Net
    Amortization, Stochastic, and ADEC vs. ERCs. `barPlot()` has 24
    arguments, with `data` not being required for G/L or Stochastic
    charts:

`barplot(data, net.amo, contributions, compound.gl, gl.url,
stochastic.alpha, Ymax, Ymin, Ybreak, yaxisScale, interactive, font,
lab1, lab2, lab3, lab4, lab5, lab6, lab7, lab8, lab9)`

  - `data`: data used for the bar chart (default it set to `NULL`)
  - `net.amo`: Set to `TRUE` to graph Net Amortization bar chart
  - `contributions`: Set to `TRUE` to graph ADEC vs. Actual Contribution
    bar chart
  - `compound.gl`: Set to `TRUE` to graph Compound Change in Gain/Loss
    bar chart
  - `gl.url`: Provide a url to GitHub or Dropbox file with Compound
    Gain/Loss data
  - `str`: Length of legend text (default set to 25 characters),
  - `stochastic`: Set to `TRUE` to graph Stochastic projections bar
    chart
  - `stochastic.url`: provide url to the file with Stochastic data
    outputs
  - `Ymax`: Set the Y-axis maximum value
  - `Ymin`: Set the Y-axis minimum value  
  - `Ybreak`: Set the chucks for Y-axis breaks
  - `yaxisScale`: Set the Y-axis scale (e.g., 1/1000000 – in $Millions)
  - `stochastic.alpha`: Set the transparency for the blue color used for
    Stochastic bar chart (e.g., 0.95 - 5% transparent)
  - `interactive`: Set to ‘TRUE\` to create an interactive, as opposed
    to static, chart (using ggplotly)
  - `lab1`: Gain/Loss chart Legend 1 (e.g., “Investment Experience”)
  - `lab2`: Gain/Loss chart Legend 2 (e.g., “Benefit Changes”)
  - `lab3`: Gain/Loss chart Legend 3 (e.g.,“Changes to Actuarial Methods
    & Assumptions”)
  - `lab4`: Gain/Loss chart Legend 4 (e.g., “Deviations from Demographic
    Assumptions”)
  - `lab5`: Gain/Loss chart Legend 5 (e.g.,“Negative Amortization”)
  - `lab6`: Gain/Loss chart Legend 6 (e.g., “Gains From Pay Increases
    Not Given”)
  - `lab7`: Gain/Loss chart Legend 7 (e.g., “Net Change to Unfunded
    Liability”)
  - `lab8`: Gain/Loss chart Legend 8 (e.g., NULL)
  - `lab9`: Gain/Loss chart Legend 9 (e.g., NULL)

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

13. `savePlot()`: adds a source and save ggplot chart. `savePlot` takes
    five arguments: `savePlot(plot = myplot, source = "The source for my
    data", save_filepath =
    "filename_that_my_plot_should_be_saved_to.png", width_pixels = 648,
    height_pixels = 384.48)`

<!-- end list -->

  - `plot`: The variable name of the plot you have created that you want
    to format and save
  - `source`: The text you want to come after the text ‘Source:’ in the
    bottom left hand side of your side
  - `save_filepath`: Exact filepath that you want the plot to be saved
    to
  - `width_pixels`: Width in pixels that you want to save your chart to
    - defaults to 648
  - `height_pixels`: Height in pixels that you want to save your chart
    to - defaults to 384.48

<!-- end list -->

    savePlot(debt_plot, source = "Source: KPERS", save_filepath = "output/test.png")

The BBC has created a wonderful data journalism cookbook for R graphics
located here: <https://bbc.github.io/rcookbook/>
