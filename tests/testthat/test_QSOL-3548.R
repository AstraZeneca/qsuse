# As A User
# I Want to specify the path of a module in R
# And include its content in an isolated environment
# So That I can store the functions in an isolated namespace
# And prevent name collisions

prepend_search_path(file.path(getwd(), "..", "..", "tests", "fixtures"))

# When I import a module path
# Then an environment is returned with the symbols defined in that
# module
test_that("QSOL-3547", {
  module <- use("/module")
  expect_true(is.environment(module))
  expect_false(is.null(module$myfunc))
  expect_false(is.null(module$myfunc2))

  module <- use("/mod1/mod2/mod3")
  expect_true(is.environment(module))
  expect_false(is.null(module$mod3_function))

})

# When I import a module that is not existent
# Then an error is returned
test_that("QSOL-3549", {
  expect_error({
    use("/unexistent")
  })
})

# When I import a module that has a syntax error
# Then an error is returned
test_that("QSOL-3550", {
  expect_error({
    mod <- use("/broken")
  })
})

# When I try to import a module using an invalid path
# Then an error is returned
test_that("QSOL-3551", {
  expect_error({
    use("tests/fixtures/module")
  }, "Attempted relative import but the module has no defined path")
  expect_error({
    use("")
  }, "The specified path cannot be empty")
  expect_error({
    use(".")
  }, "Relative paths are only allowed in first position")
  expect_error({
    use("/")
  }, "The specified path cannot be empty")
  expect_error({
    use("/mod1/mod2/./mod3")
  }, paste(
    "Invalid path '/mod1/mod2/./mod3':",
    "Relative paths are only allowed in first position"
  ))
})

# When I import a module using a relative path
# Then the module that is found relative to the current module is
# imported
test_that("QSOL-3555", {
  # Testing how the relative import works.
  # The relative import is in moda.R
  moda <- use("/relimport/mod1/moda")

  expect_equal(attr(moda$modb$modc, ".__module__"), "../modc")
  expect_equal(class(moda$modb$modc$whatever), "function")
  expect_equal(moda$modb$modc$value, 42)

})
