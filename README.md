# qsuse

R library that provides an import mechanism like python to import local source files.
It is not meant to replace library(), or doublecolon:: prefixing. It is meant to guarantee
that a large codebase can achieve the following goals:

- explicitly describe what a given .R file actually needs, by moving the import
  process from the main file to each individual subfile.
- import symbols (functions, global variables) into separate environments so
  that there is no risk of collision between symbols with the same name in two
  R files of the same project.
- manage already imported modules so that no double execution occurs.

# Usage

Imagine you have files organised as follows:
```
basedir/module.R
basedir/module2.R
basedir/module2/hello.R
basedir/module3/submodule/whatever.R
basedir/app.R
```

You use qsuse in e.g. `app.R` by first defining the search path

```
prepend_search_path("/path/to/basedir")
```

You can get this path via various methods, e.g. with here::here()

Then, you can import module as

```
module <- qsuse::use("module")
```


Functions and variables that are defined in module will be accessible as

```
module$myfunc()
```

Nothing forces you to use the same name for the variable. This is allowed:

```
mod <- qsuse::use("module")
mod$myfunc()
```

You can also import a specific function with useonly()

```
myfunc <- qsuse::use("module", "myfunc")
```

If a module is too long, you can shorten it by using prefixes

```
submodule <- qsuse::prefix("module3/submodule")
whatever <- qsuse::use(submodule("whatever"))
```

Note that if you have a directory and a file named exactly as that directory, the content of the files will be imported too. For example,

```
# Imports the contents of module2.R
module2 <- qsuse::use("module2")
# Imports the content of hello.R (under the hood, also imports module2.R but you are not
# seeing that module here)
hello <- qsuse::use("module2/hello")
```

Each of the returned variables are separated environments. This namespaces each file and prevents accidental collisions.

## Why not box?

Box does not perform static symbol binding. The result is that lintr cannot
detect the added symbols during static analysis. We also have more control of
what kind of environment is returned.

