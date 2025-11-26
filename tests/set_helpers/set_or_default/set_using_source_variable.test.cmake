include(CMakeUnit)
include(SetHelpers)


# Arrange
set(result "Initial value")
set(source_variable "Source value")

# Act
set_or_default(result source_variable "Default value")

# Assert
EXPECT_STREQ("${result}" "Source value")
