#    GitHelpers.cmake is a part of https://github.com/tawez/cmake-helpers
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


find_package(Git REQUIRED)


# Sets variable to a human-readable name based on an available ref.
# Underneath it is `git describe` with only selected options allowed.
# See `git describe --help` for more details.
# If ref is not found, variable will be undefined.
# Usage:
#   git_ref(<variable>
#           [ANNOTATED]
#           [DIRTY]
#           [MATCH <pattern>]
#           [ABBREV <n>])
# Params:
#   <variable>       Variable to set.
#   ANNOTATED        Use only annotated tags.
#   DIRTY            Append "-dirty" if the working tree has local modification.
#   MATCH <pattern>  Only consider tags matching the given glob(7) pattern.
#   ABBREV <n>       Use <n> hexadecimal digits of the abbreviated object name.
#                    The default number will be used if not specified.
#                    An <n> of 0 will suppress long format, only showing the closest tag.
function(git_ref variable)
    set(options ANNOTATED DIRTY)
    set(oneValueArgs MATCH ABBREV)
    set(multiValueArgs "")
    cmake_parse_arguments(arg "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    set(COMMAND_ARGS "")
    if (NOT arg_ANNOTATED)
        list(APPEND COMMAND_ARGS "--tags")
    endif ()
    if (arg_DIRTY)
        list(APPEND COMMAND_ARGS "--dirty")
    endif ()
    if (DEFINED arg_ABBREV)
        list(APPEND COMMAND_ARGS "--abbrev=${arg_ABBREV}")
    endif ()
    if (DEFINED arg_MATCH)
        list(APPEND COMMAND_ARGS "--match=${arg_MATCH}")
    endif ()

    execute_process(
        COMMAND ${GIT_EXECUTABLE} describe ${COMMAND_ARGS}
        RESULT_VARIABLE status_
        OUTPUT_VARIABLE tag_
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    set(${variable} ${tag_} PARENT_SCOPE)
endfunction()


# Sets variable to commit hash of the ref.
# Ref can be specified directly or described like in git_ref().
# If ref is not found, variable will be undefined.
# Usage:
#   git_hash(<variable>
#           [REF <name>]
#           [ANNOTATED]
#           [MATCH <pattern>]
#           [ABBREV <n>])
# Params:
#   <variable>       Variable to set.
#   REF <name>       Ref name, if given all the oter params will be ignored.
#   ANNOTATED        Use only annotated tags.
#   MATCH <pattern>  Only consider tags matching the given glob(7) pattern.
#   ABBREV <n>       Use <n> hexadecimal digits of the abbreviated object name.
#                    The default number will be used if not specified.
#                    An <n> of 0 will suppress long format, only showing the closest tag.
function(git_hash variable)
    set(options DIRTY) # omit DIRTY
    set(oneValueArgs REF)
    set(multiValueArgs "")
    cmake_parse_arguments(arg "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    if (DEFINED arg_REF)
        set(tag_ "${arg_REF}")
    else ()
        git_ref(tag_ ${arg_UNPARSED_ARGUMENTS})
    endif ()

    if (DEFINED tag_)
        execute_process(
            COMMAND ${GIT_EXECUTABLE} rev-list -1 ${tag_}
            RESULT_VARIABLE status_
            OUTPUT_VARIABLE hash_
            OUTPUT_STRIP_TRAILING_WHITESPACE
        )
        set(${variable} ${hash_} PARENT_SCOPE)
    endif ()
endfunction()


# Sets variable to the current branch.
# Usage:
#   git_current_branch(<variable>)
# Params:
#   <variable>       Variable to set.
function(git_current_branch variable)
    execute_process(
        COMMAND ${GIT_EXECUTABLE} branch --show-current
        RESULT_VARIABLE status_
        OUTPUT_VARIABLE branch_
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    set(${variable} ${branch_} PARENT_SCOPE)
endfunction()
