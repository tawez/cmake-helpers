# SetHelpers #

Helpers to set variables.


## Variables ##

### `SET_HELPERS_MODULE` ###

`SET_HELPERS_MODULE` (bool) set to `ON` is an indicator that SetHelpers module
is loaded.


## Functions ##

### `set_bool(VARIABLE VALUE [REFERENCE_VALUE])` ###

Set `VARIABLE` to ON/OFF according to `VALUE` and optional `REFERENCE_VALUE`.

Params:

* `VARIABLE`  variable to store the result
* `VALUE`  value to test or variable storing value to test
* `REFERENCE_VALUE`  optional reference value or variable storing reference value

Example 1: every variable is set to ON

```CMake
set(BOOL_ON ON)
set(THIS_VAR THIS)
set(THIS_REFERENCE THIS)

set_bool(VAR1 ON)
set_bool(VAR2 BOOL_ON)
set_bool(VAR3 THIS THIS)
set_bool(VAR4 THIS_VAR THIS)
set_bool(VAR5 THIS_VAR THIS_REFERENCE)
```

Example 2: every variable is set to OFF

```CMake
set(BOOL_OFF OFF)
set(THAT_VAR THAT)
set(THIS_REFERENCE THIS)

set_bool(VAR1 OFF)
set_bool(VAR2 BOOL_OFF)
set_bool(VAR3 "Non bool value")
set_bool(VAR4 THAT THIS)
set_bool(VAR5 THAT_VAR THIS)
set_bool(VAR6 THAT_VAR THIS_REFERENCE)
```


### `set_default(OUT_VAR IN_VAR DEFAULT)` ###

Set `OUT_VAR` to `IN_VAR` or to `DEFAULT` if `IN_VAR` is not defined.

Params:

* `OUT_VAR`  variable to store the result
* `IN_VAR`   variable storing value to set
* `DEFAULT`  default value or variable storing default value

Example:

```CMake
set(DEFINED_VAR "value")
set(SCOPE "Some scope")
set(DEFAULT_SCOPE "Default scope")

set_default(VAR1 DEFINED_VAR "Default value")    # VAR1 is set to "value"
set_default(VAR2 UNDEFINED_VAR "Default value")  # VAR2 is set to "Default value"
set_default(VAR3 SCOPE DEFAULT_SCOPE)            # VAR3 is set to "Some scope"
set_default(VAR4 UNKNOWN_SCOPE DEFAULT_SCOPE)    # VAR4 is set to "Default scope"
```
