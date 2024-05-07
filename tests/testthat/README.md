The convention for the tests is as follows:

- Tests must be named as test_QSOL-XXXX.R, where QSOL-XXXX is the User Story identifier.
- Inside each file, each xray test must have an entry test_that("QSOL-YYYY", code), where QSOL-YYYY
  is the xray test identifier.

When the tests are run with the inv validate command, the test execution will also create a junit-out.xml
file in the artifacts directory. This file can be uploaded to jira as part of a test execution to speed
up the process of testing.

The file is not created with plain inv unittest.
