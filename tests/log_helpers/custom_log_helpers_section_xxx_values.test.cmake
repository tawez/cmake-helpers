include(CMakeUnit)
include(LogHelpers)


# Assert
EXPECT_STREQ("${LOG_HELPERS_SECTION_BEGIN}" "begin")
EXPECT_STREQ("${LOG_HELPERS_SECTION_INDENT}" "indentation")
EXPECT_STREQ("${LOG_HELPERS_SECTION_END}" "end")
