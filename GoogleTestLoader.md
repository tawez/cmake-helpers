# GoogleTestLoader #

Add GoogleTest to the project using `FetchContent`.


## Usage ##

All you need is to include module:

```cmake
include(GoogleTestLoader)
```

GoogleTest will be fetched from `https://github.com/google/googletest`.
You may change git repository by setting `GOOGLETEST_LOADER_GIT_REPOSITORY`
variable before loading the module.

By default `origin/main` branch is fetched.
You may change it by setting `GOOGLETEST_LOADER_GIT_TAG` variable
before loading the module which is highly recommended.
It's value may be *branch*, *tag*, *tag hash* or *commit hash*.

> **NOTE:** CMake recommend using hashes.


## Dependencies ##

GoogleTestLoader requires [SetHelpers.cmake](SetHelpers.md).
