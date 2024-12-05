# LogHelpers #

Helpers to log variables and values.


## Variables ##

### `LOG_HELPERS_MODULE` ###

`LOG_HELPERS_MODULE` (bool) set to `ON` is an indicator that LogHelpers module
is loaded.


## Functions ##

### `log_item(ITEM [LABEL])` ###

Log `ITEM` with optional `LABEL`.

Params:

* `ITEM`   value or variable name
* `LABEL`  optional label for the ITEM

Example:

```CMake
set(FOO "Foo Fighters")
log_item(FOO)
log_item(FOO "Band")
log_item(BAR)
log_item(BAR "Just value")
```

Output:

```text
-- FOO: [Foo Fighters]
-- Band: [Foo Fighters]
-- BAR
-- Just value: [BAR]
```

### `log_items([ITEM1 ... ITEMn])` ###

Log list of `ITEMs` using [log_item](#log_itemitem-label).

> **NOTE:** There is no option to provide *labels* for items

Params:

* `ITEMn`  items to log

Example:

```CMake
set(FOO "Foo Fighters")
log_items(FOO BAR)
```

Output:

```text
-- FOO: [Foo Fighters]
-- BAR
```

### `log_section(TITLE [ITEM1 ... ITEMn])` ###

Log `ITEMs` as a section with the `TITLE`.

Params:

* `TITLE`  section title
* `ITEMn`  items to log

Example:

```CMake
set(FOO "Foo Fighters")
log_section("Some important stuff" FOO BAR)
```

Output:

```text
-- ┌ Some important stuff
-- │  FOO: [Foo Fighters]
-- │  BAR
-- └
```


## Macros ##

### `log_indent(STR)` ###

Append `STR` to `CMAKE_MESSAGE_INDENT` list.

Params:

* `STR`  additional part of indentation

Example:

```CMake
message(STATUS "FOO")
log_indent(">> ")
message(STATUS "BAR")
log_unindent()
message(STATUS "BAZ")
```

Output:

```text
-- FOO
-- >> BAR
-- BAZ
```

### `log_unindent()` ###

Remove last element from `CMAKE_MESSAGE_INDENT` list.
See [log_indent](#log_indentstr) for example.


### `log_section_begin(TITLE)` ###

Log section begin with `TITLE` and increase indentation.
Can be used to compose custom section output.
Should be used together with [log_section_end](#log_section_end).

Example:

```CMake
log_section_begin("Some important stuff")
message(STATUS "Ala Makota")
```

Output:

```text
-- ┌ Some important stuff
-- │  Ala Makota
```


### `log_section_end()` ###

Log section end and decrease indentation.
Should be used together with [log_section_begin](#log_section_begintitle).

Example code:

```CMake
log_section_end()
```

Output:

```text
-- └
```
