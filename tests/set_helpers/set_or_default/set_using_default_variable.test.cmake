include(CMakeUnit)
include(SetHelpers)


# Arrange
set(result "Initial value")
set(default_variable "Default value")

# Act
set_or_default(result undefined_variable default_variable)

# Assert
EXPECT_STREQ("${result}" "Default value")
