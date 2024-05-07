# As A User
# I Want to specify the path of a module in R
# And the symbol I want to import
# So That I can import the specific symbol
# And only that one in the current namespace to prevent excessive
# namespace pollution

# When I specify the module path
# And the symbol to import
# Then the specified symbol is returned
test_that("QSOL-3553", {
  myfunc <- useonly("/module", "myfunc")
  expect_false(is.null(myfunc))
  expect_equal(myfunc(), 1)
  myfunc2 <- useonly("/module", "myfunc2")
  expect_false(is.null(myfunc2))
  expect_equal(myfunc2(), 2)

})

# When I specify the module path
# And symbol, but the symbol is not present
# Then an error is returned
test_that("QSOL-3554", {
  expect_error({
    useonly("/module", "unexistent")
  })
})
