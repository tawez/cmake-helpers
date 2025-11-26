add_cmake_test(
    "set_if_defined sets the existing variable"
    set_existing_variable.test.cmake
    OPTIONS
        "-DParentScopeVariable:STRING=Old value"
)

add_cmake_test(
    "set_if_defined does not set a new variable"
    dont_set_new_variable.test.cmake
)

add_cmake_test(
    "set_if_defined accepts PARENT_SCOPE"
    accept_PARENT_SCOPE.test.cmake
)
