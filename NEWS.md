# qsuse 1.0.0

- Validation 

# qsuse 0.5.0

- Breaks backward compat. Now all paths must be prefixed either with /, . or ..
- Added module cache resetting
- Added logging

# qsuse 0.4.2

- Ensure that the internal environment is not leaked, and the new environment
  is created with the global environment as parent, rather than the function environment

# qsuse 0.4.1

- Added Repository tag to workaround packrat bugs

# qsuse 0.4.0

- Provide better error messages for module/symbol not found or unable to parse
- Add support for files named as a directory
- Support passing prefixes to prefix()

# qsuse 0.3.0

- Added prefix() to shorten long imports

# qsuse 0.2.0

- Added useonly() to import a specific symbol instead of a full module.

# qsuse 0.1.0

- Initial release
