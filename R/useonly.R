#' Import a module and return only the specified symbol
#'
#' @description Imports a module, but return only the specified symbol
#' (function or variable), instead of the whole module.
#' Equivalent in python to `from module import function`
#'
#' @param path a path, or a function returning a path
#' @param symbol_name the name of the symbol to import
#' @return the symbol
#'
#' @examples
#' \dontrun{
#'   myfunc <- useonly("/my/mod/submod", "myfunc")
#'   myfunc()
#' }
#'
#' @export
useonly <- function(path, symbol_name) {
  env <- use(path)
  symbol <- env[[symbol_name]]
  if (is.null(symbol)) {
    raise_SymbolNotFound(symbol_name, path)
  }
  return(symbol)
}
