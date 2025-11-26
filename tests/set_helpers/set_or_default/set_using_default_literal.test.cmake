include(CMakeUnit)
include(SetHelpers)


# Arrange
set(result "Initial value")

# Act
set_or_default(result undefined_variable "Default value")

# Assert
EXPECT_STREQ("${result}" "Default value")
