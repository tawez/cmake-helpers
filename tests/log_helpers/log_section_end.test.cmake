include(CMakeUnit)
include(LogHelpers)


# Arrange
list(APPEND CMAKE_MESSAGE_INDENT "indentation")

# Act
log_section_end()

# Assert
EXPECT_STREQ("${CMAKE_MESSAGE_INDENT}" "")
