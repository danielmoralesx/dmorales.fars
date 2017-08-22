test_that("make_filename", {
  expect_identical(make_filename("2013"), "accident_2013.csv.bz2")
  expect_identical(make_filename("4321"), "accident_4321.csv.bz2")
  expect_identical(make_filename("89"), "accident_89.csv.bz2")
})
