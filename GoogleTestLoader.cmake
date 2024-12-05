# {{{ Dependencies
include(SetHelpers)
include(FetchContent)
# }}} Dependencies


# {{{ Configuration
set_default(GIT_REPOSITORY GOOGLETEST_LOADER_GIT_REPOSITORY "https://github.com/google/googletest")
set_default(GIT_TAG GOOGLETEST_LOADER_GIT_TAG "origin/main")
# }}} Configuration


FetchContent_Declare(
    googletest
    GIT_REPOSITORY ${GIT_REPOSITORY}
    GIT_TAG ${GIT_TAG}
    UPDATE_DISCONNECTED ON
)

# For Windows: Prevent overriding the parent project's compiler/linker settings
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

FetchContent_GetProperties(googletest)

if (NOT googletest_POPULATED)
    FetchContent_MakeAvailable(googletest)
endif ()
