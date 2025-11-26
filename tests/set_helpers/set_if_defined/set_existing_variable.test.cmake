include(CMakeUnit)
include(SetHelpers)


# Arrange
set(LocalVariable "Old value")
# ParentScopeVariable is defined in the test setup

# Act
set_if_defined(LocalVariable "New value")
set_if_defined(ParentScopeVariable "New value")

# Assert
EXPECT_STREQ("${LocalVariable}" "New value")
EXPECT_STREQ("${ParentScopeVariable}" "New value")
