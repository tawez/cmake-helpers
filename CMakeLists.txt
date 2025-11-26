cmake_minimum_required(VERSION 3.30)

project(
    cmake-helpers
    VERSION 0.1.0
    LANGUAGES NONE
)

if (PROJECT_IS_TOP_LEVEL)
    include(CTest)
    include(FetchContent)

    FetchContent_Declare(
        cmakeunit
        GIT_REPOSITORY "https://github.com/tawez/CMakeUnit.git"
        GIT_TAG "v1.0.0"
        UPDATE_DISCONNECTED ON
    )
    FetchContent_MakeAvailable(cmakeunit)

    list(PREPEND CMAKE_MODULE_PATH "${cmakeunit_SOURCE_DIR};${CMAKE_CURRENT_LIST_DIR}")

    add_subdirectory(tests)
endif ()
