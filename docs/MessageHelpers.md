# MessageHelpers

Helpers to log variables and values.

- Variables
  - [MESSAGE_HELPERS_ITEM_WRAP_BEGIN](#message_helpers_item_wrap_begin)
  - [MESSAGE_HELPERS_ITEM_WRAP_END](#message_helpers_item_wrap_end)
  - [MESSAGE_HELPERS_ITEM_LABEL_SEPARATOR](#message_helpers_item_label_separator)
  - [MESSAGE_HELPERS_SECTION_BEGIN](#message_helpers_section_begin)
  - [MESSAGE_HELPERS_SECTION_END](#message_helpers_section_end)
  - [MESSAGE_HELPERS_SECTION_INDENT](#message_helpers_section_indent)
- Functions
  - [message_item](#message_item)
  - [message_items](#message_items)
  - [message_section](#message_section)


## Dependencies

- [SetHelpers](SetHelpers.md)


## Variables

### MESSAGE_HELPERS_ITEM_WRAP_BEGIN

The opening string that is used to wrap the element value, defaults to "`[`".

Can be redefined by setting its value before including `MessageHelpers`.


### MESSAGE_HELPERS_ITEM_WRAP_END

The closing string that is used to wrap the element value, defaults to "`]`".

Can be redefined by setting its value before including `MessageHelpers`.


### MESSAGE_HELPERS_ITEM_LABEL_SEPARATOR

String used to separate item and label, defaults to `"::"`.

Can be redefined by setting its value before including `MessageHelpers`.


### MESSAGE_HELPERS_SECTION_BEGIN

String thet prepends section title, defaults to "`┌ `".

Can be redefined by setting its value before including `MessageHelpers`.


### MESSAGE_HELPERS_SECTION_END

The ending of section, defaults to "`└`".

Can be redefined by setting its value before including `MessageHelpers`.


### MESSAGE_HELPERS_SECTION_INDENT

Additional indentation thet prepends section item, defaults to "`│  `".

Can be redefined by setting its value before including `MessageHelpers`.


## Functions

### message_item

Log item (usually variable) with optional label.
If item is a variable or label is provided, the item value will be wrapped using
`MESSAGE_HELPERS_ITEM_WRAP_BEGIN` and `MESSAGE_HELPERS_ITEM_WRAP_END`.

```cmake
message_item(<item> [<label>]
             [<mode>]
             [NO_WRAP]
             [LABEL_WIDTH <width>])
```

#### Params

- `item`  
  Value or variable.
- `label`  
  Optional label for the item.
  If missing and item is variable, will be set to variable name.
- `mode`  
  One of: `FATAL_ERROR`, `SEND_ERROR`, `WARNING`, `AUTHOR_WARNING`,
  `DEPRECATION`, `NOTICE`, `STATUS`, `VERBOSE`, `DEBUG`, `TRACE`.
- `NO_WRAP`  
  Don't wrap item value.
- `LABEL_WIDTH <width>`  
  If label is set, it will be printed using specified `width`.
  Will be ignored if label width is greater than `width`.

#### Example

```cmake
set(my_var "My variable value")

message_item(my_var)
message_item(my_var "my variable label")
message_item(my_var "my variable label" LABEL_WIDTH 12)
message_item(STATUS my_var NO_WRAP)
message_item(STATUS my_var "my variable label")
message_item(STATUS my_var "my variable label" LABEL_WIDTH 12)
message_item(no_var)
message_item(no_var "item label")
message_item(no_var "item label" LABEL_WIDTH 12)
message_item(STATUS "Just a plain value")
message_item(STATUS "Just a plain value" "Just a label")
message_item(STATUS no_var "item label" LABEL_WIDTH 12)
```

Output:

```text
my_var: [My variable value]
my variable label: [My variable value]
my variable label: [My variable value]
-- my_var: My variable value
-- my variable label: [My variable value]
-- my variable label: [My variable value]
no_var
item label: [no_var]
item label  : [no_var]
-- Just a plain value
-- Just a label: [Just a plain value]
-- item label  : [no_var]
```

### message_items

Log items (usually variables) with optional label.
One or more items can be passed.
Item and label should be separated using `MESSAGE_HELPERS_ITEM_LABEL_SEPARATOR`.

```cmake
message_items(<item>[::<label>]...
              [<mode>]
              [NO_WRAP]
              [LABEL_WIDTH <width>])
```

#### Params

- `item`  
  Value or variable.
- `label`  
  Label for the item.
  If missing and item is variable, will be set to variable name.
- `mode`  
  One of: `FATAL_ERROR`, `SEND_ERROR`, `WARNING`, `AUTHOR_WARNING`,
  `DEPRECATION`, `NOTICE`, `STATUS`, `VERBOSE`, `DEBUG`, `TRACE`.
- `NO_WRAP`  
  Don't wrap item value.
- `LABEL_WIDTH <width>`  
  If label is set, it will be printed using specified `width`.
  Will be ignored if label width is greater than `width`.

#### Example

```cmake
set(my_var "My variable value")
set(my_list "ala;makota")
set(item_n_label "my_list::Ala Makota")

message_items(
    STATUS
    LABEL_WIDTH 12
    my_var
    my_var::my variable label
    my_var::"my variable label"
    "my_var::my variable label"
    my_list
    item_n_label
    ${item_n_label}
)
```

Output:

```text
-- my_var      : [My variable value]
-- my          : [My variable value]
-- variable
-- label
-- "my variable label": [My variable value]
-- my variable label: [My variable value]
-- my_list     : [ala;makota]
-- item_n_label: [my_list::Ala Makota]
-- Ala Makota  : [ala;makota]
```


### message_section

Log items as a section with the title.

```cmake
message_section(<item>[::<label>]...
                [<mode>]
                [NO_WRAP]
                [LABEL_WIDTH <width>])
```

#### Params

- `item`  
  Value or variable.
- `label`  
  Label for the item.
  If missing and item is variable, will be set to variable name
- `mode`  
  One of: `FATAL_ERROR`, `SEND_ERROR`, `WARNING`, `AUTHOR_WARNING`,
  `DEPRECATION`, `NOTICE`, `STATUS`, `VERBOSE`, `DEBUG`, `TRACE`
- `NO_WRAP`
  Don't wrap item value 
- `LABEL_WIDTH <width>`  
  If label is set, it will be printed using specified `width`.
  Will be ignored if label width is greater than `width`.

#### Example

```cmake
set(my_var "My variable value")
set(my_list "ala;makota")
set(item_n_label "my_list::Ala Makota")

message_section(
    TITLE "Section title"
    LABEL_WIDTH 12
    "Section is just a wrapper around message_items"
    "that add more visual distinction to logged items\n"
    my_var
    my_var::my variable label
    my_var::"my variable label"
    "my_var::my variable label"
    " "
    my_list
    item_n_label
    ${item_n_label}
)
```

Output:

```text
┌ Section title
│  Section is just a wrapper around message_items
│  that add more visual distinction to logged items
│  
│  my_var      : [My variable value]
│  my          : [My variable value]
│  variable
│  label
│  "my variable label": [My variable value]
│  my variable label: [My variable value]
│   
│  my_list     : [ala;makota]
│  item_n_label: [my_list::Ala Makota]
│  Ala Makota  : [ala;makota]
└
```
