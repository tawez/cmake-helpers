# GitHelpers

Helpers to get commit hashes, git refs and other useful things.

- Variables
  - [GIT_HELPERS_WORKING_DIRECTORY](#git_helpers_working_directory)
- Functions
  - [git_ref](#git_ref)
  - [git_hash](#git_hash)
  - [git_current_branch](#git_current_branch)


## Dependencies

- [Git](https://git-scm.com/)
- [SetHelpers](SetHelpers.md)


## Variables

### GIT_HELPERS_WORKING_DIRECTORY

Default working directory of the git process (defaults to [CMAKE_SOURCE_DIR][cmake::CMAKE_SOURCE_DIR]).

Can be redefined by setting its value before including `GitHelpers`.


## Functions

### git_ref

Sets variable to a human-readable name based on an available ref.
If ref is not found, variable will be undefined.

Underneath it is [git describe][git::describe] with only selected options allowed.


```cmake
git_ref(<variable>
        [ANNOTATED]
        [DIRTY]
        [MATCH <pattern>]
        [ABBREV <n>]
        [WORKING_DIRECTORY <dir>])
```

#### Params

- `<variable>`  
  Variable to set.
- `ANNOTATED`  
  Use only annotated tags.
- `DIRTY`  
  Append "-dirty" if the working tree has local modification.
- `MATCH <pattern>`  
  Only consider tags matching the given [glob][man::glob] pattern.
- `ABBREV <n>`  
  Use <n> hexadecimal digits of the abbreviated object name.
  The default number will be used if not specified.
  An <n> of 0 will suppress long format, only showing the closest tag.
- `WORKING_DIRECTORY <dir>`  
  Current working directory of the processes
  (defaults to GIT_HELPERS_WORKING_DIRECTORY).

#### Example

```cmake
git_ref(current_commit_ref)


git_ref(current_commit_ref_with_status DIRTY)

gir_ref(last_tag ABBREV 0)

gir_ref(last_annotated_tag ANNOTATED ABBREV 0)

# If for example the releases are marked with annotated tag starting with "Version_"
gir_ref(latest_release_tag ANNOTATED ABBREV 0 MATCH Version_*)

git_ref(current_commit_ref WORKING_DIRECTORY path/to/submodule)
```


### git_hash

Sets variable to commit hash of the ref.
Ref can be specified directly or described like in git_ref().
If ref is not found, variable will be undefined.

```cmake
git_hash(<variable>
         [REF <name>]
         [ANNOTATED]
         [MATCH <pattern>]
         [ABBREV <n>]
         [WORKING_DIRECTORY <dir>])
```

#### Params

- `<variable>`  
  Variable to set.
- `REF <name>`  
  Ref name, if given all the oter params will be ignored.
- `ANNOTATED`  
  Use only annotated tags.
- `MATCH <pattern>`  
  Only consider tags matching the given [glob][man::glob] pattern.
- `ABBREV <n>`  
  Use <n> hexadecimal digits of the abbreviated object name.
  The default number will be used if not specified.
  An <n> of 0 will suppress long format, only showing the closest tag.
- `WORKING_DIRECTORY <dir>`  
  Current working directory of the processes
  (defaults to GIT_HELPERS_WORKING_DIRECTORY).

#### Example

```cmake
git_hash(current_commit_hash)

git_hash(last_tag_hash ABBREV 0)

git_hash(last_annotated_tag_hash ANNOTATED ABBREV 0)

# If for example the releases are marked with annotated tag starting with "Version_"
gir_ref(latest_release_tag_hash ANNOTATED ABBREV 0 MATCH Version_*)

git_hash(v1_2_0_hash REF Version_1.2.0)

git_hash(current_commit_hash WORKING_DIRECTORY path/to/submodule)
```

### git_current_branch

Sets variable to the current branch.

```cmake
git_current_branch(<variable>
                   [WORKING_DIRECTORY <dir>])
```

#### Params

- `<variable>`  
  Variable to set.
- `WORKING_DIRECTORY <dir>`  
  Current working directory of the processes
  (defaults to GIT_HELPERS_WORKING_DIRECTORY)

#### Example

```cmake
git_current_branch(current_branch)

git_current_branch(current_branch WORKING_DIRECTORY path/to/submodule)
```


[git::describe]: https://git-scm.com/docs/git-describe
[man::glob]: https://man7.org/linux/man-pages/man7/glob.7.html
[cmake::CMAKE_SOURCE_DIR]: https://cmake.org/cmake/help/latest/variable/CMAKE_SOURCE_DIR.html
