test_that("Linting", {
  lints <- lintr::lint_package()
  if (length(lints) != 0) {
    print("")
    print(lints)
    fail("Linting failed")
  } else {
    succeed()
  }
})
