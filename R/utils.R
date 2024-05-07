python_split <- function(x, a, b) x[a - 1 + seq_len(max(0, b - a))]

log <- function(msg) {
  if (!getOption("qsuse.verbose", FALSE)) return()

  print(msg)
}
