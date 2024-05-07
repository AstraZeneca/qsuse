#' Create a prefix function to shorten the use path
#'
#' @description prefix() provides a useful mechanism to shorten an import path
#' verbosity and extract a common prefix once and for all.
#' The returned entity can be used as is, or it can be called as a function.
#' calling the function with a path will "extend" the path and return a new
#' prefix function with the extended path.
#'
#' @param prefix_path a module path that defines the prefix.
#' @return a prefix function that can be further used in use and useonly.
#'
#' @examples
#' \dontrun{
#'   mylongmoduledir <- prefix("/my/long/module/dir")
#'   mysymbol <- useonly(mylongmoduledir, "mysymbol")
#'   mysymbol <- useonly(mylongmoduledir(), "mysymbol")
#'
#'   mylong <- prefix("/my/long")
#'   mylongmoduledir <- mylong("module/dir")
#'   mysymbol <- useonly(mylongmoduledir, "mysymbol")
#' }
#'
#' @export
prefix <- function(prefix_path) {
  if (class(prefix_path) == "function") {
    prefix_path <- prefix_path()
  }

  .prefix <- function(path = NULL) {
    if (is.null(path)) {
      return(prefix_path)
    }

    return(prefix(file.path(prefix_path, path)))
  }

  return(.prefix)
}
