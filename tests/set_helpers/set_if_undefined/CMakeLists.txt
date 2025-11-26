add_cmake_test(
    "set_if_undefined sets new variable"
    set_new_variable.test.cmake
)

add_cmake_test(
    "set_if_undefined do not override defined variables"
    dont_override_defined_variable.test.cmake
    OPTIONS
        "-DParentScopeVariable:STRING=Old value"
)

add_cmake_test(
    "set_if_undefined accepts PARENT_SCOPE"
    accept_PARENT_SCOPE.test.cmake
)
