# As A User
# I Want to add search paths for modules discovery
# So That I can define where the modules should be found

# When I add a search path
# Then the modules in that search path can be found
test_that("QSOL-3557", {
  expect_error({
    use("/searchpathmod")
  }, "Module '/searchpathmod' not found")

  prepend_search_path(
    file.path(getwd(), "..", "..", "tests", "fixtures", "searchpath")
  )

  expect_no_error({
    mod <- use("/searchpathmod")
  })

})
