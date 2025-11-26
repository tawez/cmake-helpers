include(CMakeUnit)
include(SetHelpers)


# Act
set_if_undefined(NewVariable "New value")

# Assert
EXPECT_STREQ("${NewVariable}" "New value")
