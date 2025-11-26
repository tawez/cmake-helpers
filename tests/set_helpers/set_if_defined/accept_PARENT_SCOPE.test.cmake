include(CMakeUnit)
include(SetHelpers)


function(test)
    set_if_defined(NewVariable "New value" PARENT_SCOPE)
endfunction()


# Arrange
set(NewVariable "Old value")

# Act
test()

# Assert
EXPECT_STREQ("${NewVariable}" "New value")
