# LogHelpers

Helpers to log variables and values.


## Variables

### LOG_HELPERS_SECTION_BEGIN

String thet prepends section title, defaults to `"┌ "`.

Can be redefined by setting its value before including `LogHelpers`.


### LOG_HELPERS_SECTION_INDENT

Additional indentation thet prepends section item, defaults to `"│  "`.

Can be redefined by setting its value before including `LogHelpers`.


### LOG_HELPERS_SECTION_END

The ending of section, defaults to `"└"`.

Can be redefined by setting its value before including `LogHelpers`.


## Functions

### log_item

Log item with optional label.

```cmake
log_item(<item> [<label>])
```

#### Params

- `<item>`   value or variable
- `<label>`  label for the item

#### Example

```cmake
set(FOO "Foo Fighters")
set(BAZ 1 2 3 4)

log_item(FOO)
log_item(FOO "Band")
log_item(BAR)
log_item(BAR "Just a value")
log_item(BAZ)
log_item(${BAZ})
```

Output:

```text
-- FOO: [Foo Fighters]
-- Band: [Foo Fighters]
-- BAR
-- Just a value: [BAR]
-- BAZ: [1;2;3;4]
-- 2: [1]
```


### log_items

Log list of items.

```cmake
log_items([<item_1> ... <item_n>])
```

#### Params

- `<item_i>`  items to log

#### Example

```cmake
set(FOO "Foo Fighters")
set(BAZ 1 2 3 4)

log_items(FOO BAR BAZ ${BAZ})
```

Output:

```text
-- FOO: [Foo Fighters]
-- BAR
-- BAZ: [1;2;3;4]
-- 1
-- 2
-- 3
-- 4
```


### log_section

Log items as a section with the title.

```cmake
log_section(<title> [<item_1> ... <item_n>])
```

#### Params

- `<title>`   section title
- `<item_i>`  items to log

#### Example

```cmake
set(FOO "Foo Fighters")
set(BAZ 1 2 3 4)

log_section("Some important stuff" FOO BAR BAZ ${BAZ})
```

Output:

```text
-- ┌ Some important stuff
-- │  FOO: [Foo Fighters]
-- │  BAR
-- │  BAZ: [1;2;3;4]
-- │  1
-- │  2
-- │  3
-- │  4
-- └
```


## Macros

### log_indent

Append indent to `CMAKE_MESSAGE_INDENT` list.

```cmake
log_indent(<indent>)
```

#### Params

- `<indent>`  additional part of indentation

#### Example

```cmake
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


### log_unindent

Remove last element from `CMAKE_MESSAGE_INDENT` list (see [log_indent](#log_indent) for full example).

```cmake
log_unindent()
```


### log_section_begin

Log section begin with title and increase indentation.  Can be used to compose custom section.
Should be used together with [log_section_end](#log_section_end).

```cmake
log_section_begin(<title>)
```

#### Params

- `<title>`  section title

#### Example

```cmake
set(FOO "Foo Fighters")
log_section_begin("Some important stuff")
message(STATUS "Ala Makota")
log_item(FOO)
```

Output:

```text
-- ┌ Some important stuff
-- │  Ala Makota
-- │  FOO: [Foo Fighters]
```


### log_section_end

Log section end and decrease indentation.  Should be used together with
[log_section_begin](#log_section_begin).

```cmake
log_section_end()
```

#### Example

```cmake
log_section_end()
```

Output:

```text
-- └
```


## Dependencies

- [SetHelpers](SetHelpers.md)
