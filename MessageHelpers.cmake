#    MessageHelpers.cmake is a part of https://github.com/tawez/cmake-helpers
#
#    MIT License
#
#    Copyright (c) 2026 Maciej Stankiewicz
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


set_if_undefined(MESSAGE_HELPERS_ITEM_WRAP_BEGIN "[")
set_if_undefined(MESSAGE_HELPERS_ITEM_WRAP_END "]")
set_if_undefined(MESSAGE_HELPERS_ITEM_LABEL_SEPARATOR "::")
set_if_undefined(MESSAGE_HELPERS_SECTION_BEGIN "┌ ")
set_if_undefined(MESSAGE_HELPERS_SECTION_INDENT "│  ")
set_if_undefined(MESSAGE_HELPERS_SECTION_END "└")


# {{{ Message Helpers internal implementation
macro(message_helpers__set_mode prefix)
    if (${prefix}_FATAL_ERROR)
        set(mode_ FATAL_ERROR)
    elseif (${prefix}_SEND_ERROR)
        set(mode_ SEND_ERROR)
    elseif (${prefix}_WARNING)
        set(mode_ WARNING)
    elseif (${prefix}_AUTHOR_WARNING)
        set(mode_ AUTHOR_WARNING)
    elseif (${prefix}_DEPRECATION)
        set(mode_ DEPRECATION)
    elseif (${prefix}_NOTICE)
        set(mode_ NOTICE)
    elseif (${prefix}_STATUS)
        set(mode_ STATUS)
    elseif (${prefix}_VERBOSE)
        set(mode_ VERBOSE)
    elseif (${prefix}_DEBUG)
        set(mode_ DEBUG)
    elseif (${prefix}_TRACE)
        set(mode_ TRACE)
    endif ()
endmacro()

macro(message_helpers__check_KEYWORDS_MISSING_VALUES prefix)
    if (DEFINED ${prefix}_KEYWORDS_MISSING_VALUES)
        foreach (arg_ IN LISTS ${prefix}_KEYWORDS_MISSING_VALUES)
            string(APPEND error_msg_ "  missing value for ${arg_}\n")
        endforeach ()
        message(FATAL_ERROR "${error_msg_}")
    endif ()
endmacro()

macro(message_helpers__require_UNPARSED_ARGUMENTS prefix)
    if (NOT DEFINED ${prefix}_UNPARSED_ARGUMENTS)
        message(FATAL_ERROR "${CMAKE_CURRENT_FUNCTION} Function invoked with incorrect number of arguments")
    endif ()
endmacro()
# }}} Message Helpers internal implementation


# Log item (usually variable) with optional label.
# If item is a variable or label is provided, the item's value will be wrapped using
# MESSAGE_HELPERS_ITEM_WRAP_BEGIN and MESSAGE_HELPERS_ITEM_WRAP_END.
# Usage:
#   message_item(<item> [<label>]
#           [<mode>]
#           [NO_WRAP]
#           [LABEL_WIDTH <width>])
# Params:
#   item         Value or variable
#   label        Label for the item
#                If missing and item is variable, will be set to variable name
#   mode         One of: FATAL_ERROR, SEND_ERROR, WARNING, AUTHOR_WARNING,
#                DEPRECATION, NOTICE, STATUS, VERBOSE, DEBUG, TRACE
#   NO_WRAP      Don't wrap item value
#   LABEL_WIDTH  If label is set, it will be printed using specified <width>
#                Will be ignored if label width is greater than <width>
function(message_item)
    set(options FATAL_ERROR SEND_ERROR WARNING AUTHOR_WARNING DEPRECATION NOTICE STATUS VERBOSE DEBUG TRACE NO_WRAP)
    set(oneValueArgs LABEL_WIDTH)
    set(multiValueArgs "")
    cmake_parse_arguments(arg "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGV})

    message_helpers__check_KEYWORDS_MISSING_VALUES(arg)
    message_helpers__require_UNPARSED_ARGUMENTS(arg)
    message_helpers__set_mode(arg)

    list(GET arg_UNPARSED_ARGUMENTS 0 item_)
    list(LENGTH arg_UNPARSED_ARGUMENTS argc_)
    if (argc_ GREATER 1)
        list(GET arg_UNPARSED_ARGUMENTS 1 label_)
    endif ()

    if (DEFINED ${item_})
        if (NOT DEFINED label_)
            set(label_ ${item_})
        endif ()
        set(item_ ${${item_}})
    endif ()

    if (DEFINED arg_LABEL_WIDTH AND DEFINED label_)
        string(LENGTH "${label_}" label_length_)
        if (label_length_ LESS arg_LABEL_WIDTH)
            math(EXPR pad_length_ "${arg_LABEL_WIDTH} - ${label_length_}")
            string(REPEAT " " ${pad_length_} label_pad_)
        endif ()
    endif ()

    if (NOT arg_NO_WRAP)
        set(wrap_begin_ ${MESSAGE_HELPERS_ITEM_WRAP_BEGIN})
        set(wrap_end_ ${MESSAGE_HELPERS_ITEM_WRAP_END})
    endif ()

    if (DEFINED label_)
        message(${mode_} "${label_}${label_pad_}: ${wrap_begin_}${item_}${wrap_end_}")
    else ()
        message(${mode_} "${item_}")
    endif ()
endfunction()


# Log items (usually variables) with optional label.
# One or more items can be passed.
# Item and label should be separated using MESSAGE_HELPERS_ITEM_LABEL_SEPARATOR.
# Usage:
#   message_items(<item>[::<label>]...
#           [<mode>]
#           [NO_WRAP]
#           [LABEL_WIDTH <width>])
# Params:
#   item         Value or variable
#   label        Label for the item
#                If missing and item is variable, will be set to variable name
#   mode         One of: FATAL_ERROR, SEND_ERROR, WARNING, AUTHOR_WARNING,
#                DEPRECATION, NOTICE, STATUS, VERBOSE, DEBUG, TRACE
#   NO_WRAP      Don't wrap item value
#   LABEL_WIDTH  If label is set, it will be printed using specified <width>
#                Will be ignored if label width is greater than <width>
function(message_items)
    set(options FATAL_ERROR SEND_ERROR WARNING AUTHOR_WARNING DEPRECATION NOTICE STATUS VERBOSE DEBUG TRACE NO_WRAP)
    set(oneValueArgs LABEL_WIDTH)
    set(multiValueArgs "")
    cmake_parse_arguments(arg "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGV})

    message_helpers__check_KEYWORDS_MISSING_VALUES(arg)
    message_helpers__require_UNPARSED_ARGUMENTS(arg)
    message_helpers__set_mode(arg)

    if (DEFINED arg_LABEL_WIDTH)
        list(APPEND label_width_ LABEL_WIDTH ${arg_LABEL_WIDTH})
    endif ()

    if (arg_NO_WRAP)
        set(no_wrap_ NO_WRAP)
    endif ()

    foreach (item_ IN LISTS arg_UNPARSED_ARGUMENTS)
        string(REPLACE "${MESSAGE_HELPERS_ITEM_LABEL_SEPARATOR}" ";" item_ "${item_}")
        message_item(${mode_} ${label_width_} ${no_wrap_} ${item_})
    endforeach()
endfunction()


# Log items as a section with the title
# Usage:
#   message_section(<item>[::<label>]...
#           [<mode>]
#           [NO_WRAP]
#           [LABEL_WIDTH <width>])
# Params:
#   item         Value or variable
#   label        Label for the item
#                If missing and item is variable, will be set to variable name
#   mode         One of: FATAL_ERROR, SEND_ERROR, WARNING, AUTHOR_WARNING,
#                DEPRECATION, NOTICE, STATUS, VERBOSE, DEBUG, TRACE
#   NO_WRAP      Don't wrap item value
#   LABEL_WIDTH  If label is set, it will be printed using specified <width>
#                Will be ignored if label width is greater than <width>
function(message_section)
    set(options FATAL_ERROR SEND_ERROR WARNING AUTHOR_WARNING DEPRECATION NOTICE STATUS VERBOSE DEBUG TRACE NO_WRAP)
    set(oneValueArgs TITLE LABEL_WIDTH)
    set(multiValueArgs "")
    cmake_parse_arguments(arg "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGV})

    message_helpers__check_KEYWORDS_MISSING_VALUES(arg)
    message_helpers__require_UNPARSED_ARGUMENTS(arg)
    message_helpers__set_mode(arg)

    if (DEFINED arg_LABEL_WIDTH)
        list(APPEND label_width_ LABEL_WIDTH ${arg_LABEL_WIDTH})
    endif ()

    if (arg_NO_WRAP)
        set(no_wrap_ NO_WRAP)
    endif ()

    message(${mode_} "${MESSAGE_HELPERS_SECTION_BEGIN}${arg_TITLE}")
    list(APPEND CMAKE_MESSAGE_INDENT "${MESSAGE_HELPERS_SECTION_INDENT}")
    message_items(${mode_} ${label_width_} ${no_wrap_} ${arg_UNPARSED_ARGUMENTS})
    list(POP_BACK CMAKE_MESSAGE_INDENT)
    message(${mode_} "${MESSAGE_HELPERS_SECTION_END}")
endfunction()
