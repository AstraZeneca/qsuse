prepend_search_path(file.path(getwd(), "..", "..", "tests", "fixtures"))

test_that("split_path", {
  chunks <- split_path("tests/fixtures/module")
  expect_equal(chunks, list(".", "tests", "fixtures", "module"))

  chunks <- split_path("tests/fixtures/./module")
  expect_equal(chunks, list(".", "tests", "fixtures", ".", "module"))

  chunks <- split_path("./tests/fixtures/module")
  expect_equal(chunks, list(".", "tests", "fixtures", "module"))

  chunks <- split_path("/tests/fixtures/module")
  expect_equal(chunks, list("/", "tests", "fixtures", "module"))

  chunks <- split_path("/tests")
  expect_equal(chunks, list("/", "tests"))

  chunks <- split_path("/")
  expect_equal(chunks, list("/"))

  chunks <- split_path("tests")
  expect_equal(chunks, list(".", "tests"))

  chunks <- split_path("../tests/fixtures/module")
  expect_equal(chunks, list(".", "..", "tests", "fixtures", "module"))

})

test_that("join_path", {
  chunks <- split_path("tests/fixtures/module")
  path <- join_path(chunks)
  expect_equal(path, "./tests/fixtures/module")
  expect_equal(join_path(list("/", "foo", "bar")), "/foo/bar")
  expect_equal(join_path(list()), "")
  expect_equal(join_path(list("foo", "bar")), "foo/bar")
  expect_equal(join_path(list(".", "foo", "bar")), "./foo/bar")
})

test_that("python_split", {
  expect_equal(python_split(list(1, 2, 3), 1, 1), list())
  expect_equal(python_split(list(1, 2, 3), 1, 2), list(1))
  expect_equal(python_split(list(1, 2, 3), 1, 3), list(1, 2))
})


test_that("Use submodule dir only", {
  dirmodule_submod <- use("/dirmodule/submod")
  expect_false(is.null(dirmodule_submod$dirmodule_submod_function))
})

test_that("Use submodule file and dir", {
  filedirmodule <- use("/filedirmodule")

  expect_false(is.null(filedirmodule$filedirmodule_function))
  expect_false(is.null(filedirmodule$imported_module))
  expect_false(is.null(filedirmodule$imported_function))
  expect_false(
    is.null(filedirmodule$imported_module$filedirmodule_submod_function)
  )
})


test_that("parent environment is empty", {
  module <- use("/mod1/mod2/mod3")
  expect_true(is.null(parent.env(module)$idx))

})

test_that("path as attribute", {
  module <- use("/mod1/mod2/mod3")
  expect_equal(attr(module, ".__module__"), "mod1/mod2/mod3")
  expect_true(endsWith(attr(module, ".__path__"), "mod1/mod2/mod3.R"))
})


test_that("logging", {

  options(qsuse.verbose = TRUE)
  reset()
  out <- capture.output({
    moda <- use("/relimport/mod1/moda")
  })
  expect_true(TRUE)
})
