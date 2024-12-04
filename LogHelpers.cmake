set(LOG_HELPERS_MODULE ON)


# Log ITEM with optional LABEL.
# Usage:
#   log_item(ITEM [LABEL])
# Params:
#   ITEM   value or variable name
#   LABEL  optional label for the ITEM
function(log_item ITEM)
    if(DEFINED ${ITEM})
        if(${ARGC} GREATER 1)
            message(STATUS "${ARGV1}: [${${ITEM}}]")
        else ()
            message(STATUS "${ITEM}: [${${ITEM}}]")
        endif ()
    else()
        if(${ARGC} GREATER 1)
            message(STATUS "${ARGV1}: [${ITEM}]")
        else ()
            message(STATUS "${ITEM}")
        endif ()
    endif()
endfunction()


# Log list of ITEMs using log_item()
# Usage:
#   log_items([ITEM1 ... ITEMn])
# Params:
#   ITEMn  items to log
function(log_items)
    foreach (ITEM IN LISTS ARGN)
        log_item(${ITEM})
    endforeach()
endfunction()


# Append STR to CMAKE_MESSAGE_INDENT list
# Usage:
#   log_indent(STR)
# Params:
#   STR  additional part of indentation
macro(log_indent STR)
    list(APPEND CMAKE_MESSAGE_INDENT ${STR})
endmacro()


# Remove last element from CMAKE_MESSAGE_INDENT list
# Usage:
#   log_unindent()
macro(log_unindent)
    list(POP_BACK CMAKE_MESSAGE_INDENT)
endmacro()


# Log section begin with TITLE and increase indentation
# Usage:
#   log_section_begin(TITLE)
# Params:
#   TITLE  section title
macro(log_section_begin TITLE)
    message(STATUS "┌ ${TITLE}")
    log_indent("│  ")
endmacro()


# Log section end and decrease indentation
# Usage:
#   log_section_end()
macro(log_section_end)
    log_unindent()
    message(STATUS "└")
endmacro()


# Log ITEMs as a section with the TITLE
# Usage:
#   log_section(TITLE [ITEM1 ... ITEMn])
# Params:
#   TITLE  section title
#   ITEMn  items to log
function(log_section TITLE)
    log_section_begin(${TITLE})
    log_items(${ARGN})
    log_section_end()
endfunction()
