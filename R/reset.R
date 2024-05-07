#' @export
reset <- function() {
  rm(list = ls(.modules), envir = .modules)
}
