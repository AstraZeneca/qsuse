error <- function(subclass, message, call = sys.call(-1)) {
  return(
    structure(
      class = c(subclass, "error", "condition"),
      list(message = message, call = call)
    )
  )
}

raise_InvalidPath <- function(path, msg, call = sys.call(-1)) {
  cond <- error(
    "invalid_path",
    paste0("Invalid path '", path, "': ", msg),
    call = call
  )
  stop(cond)
}

raise_ModuleNotFound <- function(module, call = sys.call(-1)) {
  cond <- error(
    "module_not_found",
    paste0("Module '", module, "' not found"),
    call = call
  )

  stop(cond)
}

raise_SymbolNotFound <- function(symbol, module, call = sys.call(-1)) {
  cond <- error(
    "symbol_not_found",
    paste0("Symbol '", symbol, "' not found in module '", module, "'"),
    call = call
  )
  stop(cond)
}

raise_ModuleImportError <- function(module, err, call = sys.call(-1)) {
  cond <- error(
    "import_error",
    paste0("Unable to source '", module, "'. Error was:\n\n", err, "'"),
    call = call
  )
  stop(cond)
}
