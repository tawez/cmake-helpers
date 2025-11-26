add_cmake_test(
    "LOG_HELPERS_SECTION_XXX variables have default values"
    default_log_helpers_section_xxx_values.test.cmake
)

add_cmake_test(
    "LOG_HELPERS_SECTION_XXX can be redefined"
    custom_log_helpers_section_xxx_values.test.cmake
    OPTIONS
        "-DLOG_HELPERS_SECTION_BEGIN:STRING=begin"
        "-DLOG_HELPERS_SECTION_INDENT:STRING=indentation"
        "-DLOG_HELPERS_SECTION_END:STRING=end"
)

add_cmake_test(
    "log_indent adds value to CMAKE_MESSAGE_INDENT"
    log_indent.test.cmake
)

add_cmake_test(
    "log_unindent removes last value from CMAKE_MESSAGE_INDENT"
    log_unindent.test.cmake
)

add_cmake_test(
    "log_section_begin adds LOG_HELPERS_SECTION_INDENT to CMAKE_MESSAGE_INDENT"
    log_section_begin.test.cmake
)

add_cmake_test(
    "log_section_end removes last value from CMAKE_MESSAGE_INDENT"
    log_section_end.test.cmake
)
