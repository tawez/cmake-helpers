include(CMakeUnit)
include(SetHelpers)


function(test)
    set_or_default(result undefined_variable "Default value" PARENT_SCOPE)
endfunction()


# Arrange
set(result "Initial value")

# Act
test()

# Assert
EXPECT_STREQ("${result}" "Default value")
