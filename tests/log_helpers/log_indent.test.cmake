include(CMakeUnit)
include(LogHelpers)


# Act
log_indent("indentation")

# Assert
EXPECT_STREQ("${CMAKE_MESSAGE_INDENT}" "indentation")
