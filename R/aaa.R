# The already loaded module registry.
# If the module is already loaded, it will return from the registry, instead
# of sourcing it again.
# Each entry is associated to a file. Directories don't create modules
.modules <- new.env(parent = emptyenv())

# We use an environment because shiny is a piece of garbage that somehow
# manages to enforce an early binding, rather than late binding behavior, on
# the closed global.
# See https://stackoverflow.com/questions/60264370/
.path <- new.env(parent = emptyenv())
