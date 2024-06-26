% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/use.R
\name{use}
\alias{use}
\title{Import a module}
\usage{
use(path)
}
\arguments{
\item{path}{a path, or a function returning a path.}
}
\value{
the imported module
}
\description{
Imports a module and returns an env with all the symbols
contained in that module. The module is sourced only once. Subsequent
invocations will return the already imported environment.
Equivalent in python to `from my.mod import submod`
}
\details{
If the module is a file, source that file. If the module is a
directory and has an associated file with the exact same name and
extension .R, the file will be sourced as well. Files inside the directory
Will not be automatically sourced.

Do not add the .R extension to the path
}
\examples{
\dontrun{
  submod <- use("/my/mod/submod")
  submod$myfunc()
}

}
