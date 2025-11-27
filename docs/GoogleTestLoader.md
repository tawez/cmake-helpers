# GoogleTestLoader

Add GoogleTest to the project using `FetchContent`.


## Usage ##

To fetch _GoogleTest_, just include the _GoogleTestLoader_ module.  Optionally you may also customize
what exactly will be fetched and from which repository.

```cmake
if (PROJECT_IS_TOP_LEVEL)
    enable_testing()

    # Optional steps: configure and load googletest
    set(GOOGLETEST_LOADER_GIT_REPOSITORY "https://my-company.com/gitserver/googletest.git")
    set(GOOGLETEST_LOADER_GIT_REF "v1.15.2")
    
    # Required steps
    include(GoogleTestLoader)
    include(GoogleTest)
endif ()
```


## Variables

### GOOGLETEST_LOADER_GIT_REPOSITORY 

Address of the git repository, from which the GoogleTest will be fetched,
defaults to `"https://github.com/google/googletest"`.

Can be redefined by setting its value before including `GoogleTestLoader`.


### GOOGLETEST_LOADER_GIT_REF 

Git ref in the GOOGLETEST_LOADER_GIT_REPOSITORY to be fetched, defaults to `"origin/main"`.

Can be redefined by setting its value before including `GoogleTestLoader`.

> **NOTE:** It can be _tag_, _branch_ or _hash_, however CMake recommendation is to use hashes.


## Dependencies

- [SetHelpers](SetHelpers.md)
- [FetchContent](https://cmake.org/cmake/help/latest/module/FetchContent.html)
