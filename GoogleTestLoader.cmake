#    GoogleTestLoader.cmake is a part of https://github.com/tawez/cmake-helpers
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
include(FetchContent)


# {{{ Configuration
set_if_undefined(GOOGLETEST_LOADER_GIT_REPOSITORY "https://github.com/google/googletest")
set_if_undefined(GOOGLETEST_LOADER_GIT_REF "origin/main")
# }}} Configuration


FetchContent_Declare(
    googletest
    GIT_REPOSITORY ${GOOGLETEST_LOADER_GIT_REPOSITORY}
    GIT_TAG ${GOOGLETEST_LOADER_GIT_REF}
    UPDATE_DISCONNECTED ON
)

# For Windows: Prevent overriding the parent project's compiler/linker settings
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

FetchContent_GetProperties(googletest)

if (NOT googletest_POPULATED)
    FetchContent_MakeAvailable(googletest)
endif ()
