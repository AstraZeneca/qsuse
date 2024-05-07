#' Adds a given path to the list of looked up directories
#'
#' @description Adds a given path to the list of searched paths when looking
#' for a given module. The path is prepended is prepended, which means it is
#' at a higher priority than the current list. It can be called multiple times.
#'
#' @param path a path on the disk where to find modules.
#' @return NULL
#'
#' @examples
#' \dontrun{
#'   prepend_search_path("dir/where/my/modules/are")
#' }
#'
#'
#' @export
prepend_search_path <- function(path) {
  if (is.null(.path[["search_path"]])) {
    .path[["search_path"]] <- list()
  }

  .path[["search_path"]] <- c(path, .path[["search_path"]])
}
