set(SET_HELPERS_MODULE ON)


# Set VARIABLE to ON/OFF according to VALUE and optional REFERENCE_VALUE
# Usage:
#   set_bool(VARIABLE VALUE [REFERENCE_VALUE])
# Params:
#   VARIABLE           variable to store the result
#   VALUE              value to test or variable storing value to test
#   [REFERENCE_VALUE]  reference value or variable storing reference value
function(set_bool VARIABLE VALUE)
    if (DEFINED ${VALUE})
        set(value ${${VALUE}})
    else ()
        set(value ${VALUE})
    endif ()

    if(${ARGC} GREATER 2)
        if (DEFINED ${ARGV2})
            set(reference_value ${${ARGV2}})
        else ()
            set(reference_value ${ARGV2})
        endif ()

        if ("${value}" STREQUAL "${reference_value}")
            set(${VARIABLE} ON PARENT_SCOPE)
        else ()
            set(${VARIABLE} OFF PARENT_SCOPE)
        endif ()
    elseif (${value})
        set(${VARIABLE} ON PARENT_SCOPE)
    else ()
        set(${VARIABLE} OFF PARENT_SCOPE)
    endif ()
endfunction()


# Set OUT_VAR to IN_VAR or to DEFAULT if IN_VAR is not defined
# Usage:
#   set_default(OUT_VAR IN_VAR DEFAULT)
# Params:
#   OUT_VAR  variable to store the result
#   IN_VAR   variable storing value to set
#   DEFAULT  default value or variable storing default value
function(set_default OUT_VAR IN_VAR DEFAULT)
    if (DEFINED ${IN_VAR})
        set(${OUT_VAR} ${${IN_VAR}} PARENT_SCOPE)
    else ()
        if (DEFINED ${DEFAULT})
            set(${OUT_VAR} ${${DEFAULT}} PARENT_SCOPE)
        else ()
            set(${OUT_VAR} ${DEFAULT} PARENT_SCOPE)
        endif ()
    endif ()
endfunction()
