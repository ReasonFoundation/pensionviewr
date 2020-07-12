https://r-pkgs.org/tests.html
library(reasontheme)
library(pensionviewr)
pl <- planList()
View(pl)
test_that("multiplication works", {
  expect_equal(pullData(pl, "New Mexico Educational Retirement Board"), )
})
