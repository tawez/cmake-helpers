# cmake-helpers #

Reusable CMake helpers


## Setup ##

Configure in your main CMakeLists.txt file where the helpers are located,
for example:

```cmake
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
```

This allows you to add helper modules just like any other CMake module:

```cmake
inlude(SetHelpers)
```


## Helpers ##

* [GoogleTestLoader](GoogleTestLoader.md)
  Add GoogleTest to the project using `FetchContent`
* [LogHelpers](LogHelpers.md)
  Helpers to log variables and values
* [SetHelpers](SetHelpers.md)
  Helpers to set variables
