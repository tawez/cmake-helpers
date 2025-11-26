include(CMakeUnit)
include(LogHelpers)


# Arrange
list(APPEND CMAKE_MESSAGE_INDENT "indentation")

# Act
log_unindent()

# Assert
EXPECT_STREQ("${CMAKE_MESSAGE_INDENT}" "")
