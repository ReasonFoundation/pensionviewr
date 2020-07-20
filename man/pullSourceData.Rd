\name{pullSourceData}
\alias{pullSourceData}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
pullSourceData(plan_name)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{plan_name}{
%%     ~~Describe \code{plan_name} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (plan_name) 
{
    con <- RPostgres::dbConnect(RPostgres::Postgres(), dbname = "d629vjn37pbl3l", 
        host = "ec2-3-209-200-73.compute-1.amazonaws.com", port = 5432, 
        user = "reason_readonly", password = "p88088bd28ea68027ee96c65996f7ea3b56db0e27d7c9928c05edc6c23ef2bc27", 
        sslmode = "require")
    if (str_count(plan_name) < 6) {
        query <- paste("select * from pull_data_state_only()\nwhere year > '2001'\nand attribute_name in ('1 Year Investment Return Percentage',\n'1 Year Investment Return Percentage',\n'Investment Return Assumption for GASB Reporting',\n'Actuarially Accrued Liabilities Dollar',\n'Total Normal Cost Percentage',\n'Covered Payroll Dollar',\n'Payroll Growth Assumption',\n'Total Benefits Paid Dollar')")
    }
    else {
        plan_id <- pl$id[pl$display_name == plan_name]
        query <- paste("select * from pull_plan_data(", plan_id, 
            ")")
    }
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
