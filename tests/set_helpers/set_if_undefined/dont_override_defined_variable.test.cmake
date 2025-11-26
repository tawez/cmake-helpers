include(CMakeUnit)
include(SetHelpers)


# Arrange
set(local_variable "Old value")

# Act
set_if_undefined(ParentScopeVariable "New value")
set_if_undefined(local_variable "New value")

# Assert
EXPECT_STREQ("${ParentScopeVariable}" "Old value")
EXPECT_STREQ("${local_variable}" "Old value")
