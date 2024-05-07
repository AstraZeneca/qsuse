#' Import a module
#'
#' @description Imports a module and returns an env with all the symbols
#' contained in that module. The module is sourced only once. Subsequent
#' invocations will return the already imported environment.
#' Equivalent in python to `from my.mod import submod`
#'
#' @details If the module is a file, source that file. If the module is a
#' directory and has an associated file with the exact same name and
#' extension .R, the file will be sourced as well. Files inside the directory
#' Will not be automatically sourced.
#'
#' Do not add the .R extension to the path
#'
#' @param path a path, or a function returning a path.
#' @return the imported module
#'
#' @examples
#' \dontrun{
#'   submod <- use("/my/mod/submod")
#'   submod$myfunc()
#' }
#'
#' @export
use <- function(path) {
  if (class(path) == "function") {
    path <- path()
  }

  log(paste("Importing '", path, "'"))

  elems <- split_path(path)
  if (length(elems) < 2) {
    raise_InvalidPath(path, "The specified path cannot be empty")
  }

  current_module <- .modules
  absolute_search_path <- c(getwd(), .path[["search_path"]])

  log(paste("Search path is",
            paste(absolute_search_path, collapse = ", "))
  )

  for (idx in seq_len(length(elems))) {
    prev_elems <- python_split(elems, 2, idx)
    cur_elem <- elems[[idx]]

    # Detect if the module import is relative or absolute
    # where with absolute, we mean absolute depending on the search paths.
    if (idx == 1) {
      if (cur_elem == "/") {
        absolute_mode <- TRUE
        log("Search strategy is absolute")
      } else if (cur_elem == ".") {
        absolute_mode <- FALSE
        log("Search strategy is relative")
      } else {
        stop("Programming error. Cannot determine if absolute or relative mode")
      }
      next
    }

    log(paste0("Working on '", cur_elem, "'"))

    if (cur_elem == ".") {
      raise_InvalidPath(
        path, "Relative paths are only allowed in first position"
      )
    }

    if (!is.null(current_module[[cur_elem]])) {
      # Found the module. Immediately jump into it and go to the next element
      log(paste0("Module '", cur_elem, "' found in cache"))
      current_module <- current_module[[cur_elem]]
      next
    }

    module_path <- join_path(c(prev_elems, cur_elem))

    # It is not in the registry, under the current module.
    # Start looking for the file.
    # If the path is "absolute", search from the search paths
    # If the path is relative, start searching from the current module
    # __path__ attribute

    if (absolute_mode) {
      search_path <- absolute_search_path
    } else {
      mod_path <- attr(parent.frame(), ".__path__")
      if (is.null(mod_path)) {
        raise_ModuleImportError(
          path,
          "Attempted relative import but the module has no defined path"
        )
      }
      search_path <- dirname(mod_path)
      log(paste0("Relative search is relative to '", search_path, "'"))
    }

    found <- FALSE
    for (base_path in search_path) {
      full_path_dir <- join_path(c(base_path, prev_elems, cur_elem))
      full_path_file <- join_path(
        c(base_path, prev_elems, paste0(cur_elem, ".R"))
      )

      log(
        paste0("Looking for dir '", full_path_dir,
               "' or file '", full_path_file, "'")
      )
      if (!dir.exists(full_path_dir) && !file.exists(full_path_file)) {
        # Try the next in the search path
        next
      }

      # We found the module in one of the search paths
      found <- TRUE

      env <- new.env(parent = globalenv())
      current_module[[cur_elem]] <- env
      attr(env, ".__module__") <- module_path
      attr(env, ".__path__") <- full_path_file
      if (file.exists(full_path_file)) {
        log(
          paste0("Parsing file '", full_path_file, "'")
        )
        tryCatch({
          source(full_path_file, local = current_module[[cur_elem]])
        },
        error = function(err) {
          raise_ModuleImportError(path, err)
        }
        )

        found <- TRUE
        break
      } else {
        log(
          paste0("Found dir '", full_path_dir, "'.")
        )
      }
    }

    if (!found) {
      # Was not able to find the module. Time to bail out
      raise_ModuleNotFound(path)
    }

    # walk down the hierarchy
    current_module <- current_module[[cur_elem]]
  }

  return(current_module)
}
