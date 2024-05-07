split_path <- function(x) {
  if (length(x) != 1) {
    raise_InvalidPath("path must be a single element")
  }
  if (nchar(x) == 0) {
    return(list())
  }
  dir <- dirname(x)
  base <- basename(x)
  if (dir == ".") {
    return(list(".", base))
  } else if (dir == "..") {
    return(list(".", "..", base))
  } else if (dir == "/") {
    if (base != "") {
      return(list("/", base))
    } else {
      return(list("/"))
    }
  }

  return(c(split_path(dir), base))
}

join_path <- function(x) {
  if (length(x) == 0) {
    return("")
  } else if (length(x) == 1) {
    return(x[[1]])
  } else if (length(x) == 2 && x[[1]] == "/") {
    return(paste0("/", x[[2]]))
  } else {
    return(
      file.path(
        join_path(python_split(x, 1, length(x))),
        x[[length(x)]]
      )
    )
  }
}
