add_cmake_test(
    "set_or_default use default literal"
    set_using_default_literal.test.cmake
)

add_cmake_test(
    "set_or_default use default variable"
    set_using_default_variable.test.cmake
)

add_cmake_test(
    "set_or_default use source variable"
    set_using_source_variable.test.cmake
)

add_cmake_test(
    "set_or_default accepts PARENT_SCOPE"
    accept_PARENT_SCOPE.test.cmake
)
