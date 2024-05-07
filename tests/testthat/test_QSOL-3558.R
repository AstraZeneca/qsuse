# As A User
# I Want to be able to specify a prefix object for the import
# So That I can shorten long import paths

# Given a prefix object
# When I specify a postfix
# Then the two are concatenated
test_that("QSOL-3559", {
  mod1 <- prefix("/mod1")
  expect_equal(class(mod1), "function")
  expect_equal(mod1(), "/mod1")

  module <- mod1("mod2")
  expect_equal(class(module), "function")
  expect_equal(module(), "/mod1/mod2")
})

# Given a prefix
# And its postfix
# When I use it to search an existing module
# Then the module is correctly resolved
test_that("QSOL-3560", {
  mod1 <- prefix("/mod1")
  myfunc <- useonly(mod1("mod2/mod3"), "mod3_function")
  expect_equal(myfunc(), 1)

  module <- prefix("/mod1/mod2/mod3")
  myfunc <- useonly(module(), "mod3_function")
  expect_equal(myfunc(), 1)

  module <- prefix("/mod1/mod2/mod3")
  myfunc <- useonly(module, "mod3_function")
  expect_equal(myfunc(), 1)

  mod2 <- prefix("/mod1/mod2")
  module <- mod2("mod3")
  myfunc <- useonly(module, "mod3_function")
  expect_equal(myfunc(), 1)

  mod2 <- prefix(mod1("mod2"))
  expect_equal(mod2(), "/mod1/mod2")
})
