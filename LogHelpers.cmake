#    LogHelpers.cmake is a part of https://github.com/tawez/cmake-helpers
#
#    MIT License
#
#    Copyright (c) 2025 Maciej Stankiewicz
#
#    Permission is hereby granted, free of charge, to any person obtaining a copy
#    of this software and associated documentation files (the "Software"), to deal
#    in the Software without restriction, including without limitation the rights
#    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#    copies of the Software, and to permit persons to whom the Software is
#    furnished to do so, subject to the following conditions:
#
#    The above copyright notice and this permission notice shall be included in all
#    copies or substantial portions of the Software.
#
#    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#    SOFTWARE.


include(SetHelpers)

set_if_undefined(LOG_HELPERS_SECTION_BEGIN "┌ ")
set_if_undefined(LOG_HELPERS_SECTION_INDENT "│  ")
set_if_undefined(LOG_HELPERS_SECTION_END "└")


# Log item with optional label.
# Usage:
#   log_item(<item> [<label>])
# Params:
#   <item>   value or variable
#   <label>  label for the item
function(log_item item)
    if(DEFINED ${item})
        if(${ARGC} GREATER 1)
            message(STATUS "${ARGV1}: [${${item}}]")
        else ()
            message(STATUS "${item}: [${${item}}]")
        endif ()
    else()
        if(${ARGC} GREATER 1)
            message(STATUS "${ARGV1}: [${item}]")
        else ()
            message(STATUS "${item}")
        endif ()
    endif()
endfunction()


# Log list of items
# Usage:
#   log_items([<item_1> ... <item_n>])
# Params:
#   <item_i>  items to log
function(log_items)
    foreach (item IN LISTS ARGN)
        log_item(${item})
    endforeach()
endfunction()


# Append indent to CMAKE_MESSAGE_INDENT list
# Usage:
#   log_indent(<indent>)
# Params:
#   <indent>  additional part of indentation
macro(log_indent indent)
    list(APPEND CMAKE_MESSAGE_INDENT ${indent})
endmacro()


# Remove last element from CMAKE_MESSAGE_INDENT list
# Usage:
#   log_unindent()
macro(log_unindent)
    list(POP_BACK CMAKE_MESSAGE_INDENT)
endmacro()


# Log section begin with title and increase indentation
# Usage:
#   log_section_begin(<title>)
# Params:
#   <title>  section title
macro(log_section_begin title)
    message(STATUS "${LOG_HELPERS_SECTION_BEGIN}${title}")
    log_indent("${LOG_HELPERS_SECTION_INDENT}")
endmacro()


# Log section end and decrease indentation
# Usage:
#   log_section_end()
macro(log_section_end)
    log_unindent()
    message(STATUS "${LOG_HELPERS_SECTION_END}")
endmacro()


# Log items as a section with the title
# Usage:
#   log_section(<title> [<item_1> ... <item_n>])
# Params:
#   <title>   section title
#   <item_i>  items to log
function(log_section title)
    log_section_begin(${title})
    log_items(${ARGN})
    log_section_end()
endfunction()
