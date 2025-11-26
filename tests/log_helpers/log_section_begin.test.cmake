include(CMakeUnit)
include(LogHelpers)


# Act
log_section_begin("Title")

# Assert
EXPECT_STREQ("${CMAKE_MESSAGE_INDENT}" "${LOG_HELPERS_SECTION_INDENT}")
