include(CMakeUnit)
include(SetHelpers)


function(test)
    set_if_undefined(NewVariable "New value" PARENT_SCOPE)
endfunction()


# Act
test()

# Assert
EXPECT_STREQ("${NewVariable}" "New value")
