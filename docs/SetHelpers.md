# SetHelpers

Helpers to set variables.


## Macros

### set_if_defined

Set _variable_ only if it is already defined.

```cmake
set_if_defined(<variable> <value> [PARENT_SCOPE])
```

#### Params

- `variable`  variable to update
- `value`     value to set

#### Example

```cmake
set(FOO "Foo")

set_if_defined(FOO "Foo Fighters")
set_if_defined(BAR "Bar Fighters")

message("[${FOO}]")
message("[${BAR}]")
```

Result

```text
[Foo Fighters]
[]
```


### set_if_undefined

Set _variable_ only if it is not defined.

```cmake
set_if_undefined(<variable> <value> [PARENT_SCOPE])
```

#### Params
- `variable`  variable to define
- `value`     value to be set

#### Example

```cmake
set(FOO "Foo")

set_if_undefined(FOO "Foo Fighters")
set_if_undefined(BAR "Bar Fighters")

message("[${FOO}]")
message("[${BAR}]")
```

Result

```text
[Foo]
[Bar Fighters]
```


### set_or_default

Set _destination_ to _source_ or to _default_ if the source is not defined.

```cmake
set_or_default(<destination> <source> <default> [PARENT_SCOPE])
```

#### Params

- `destination`  variable to store the result
- `source`       variable storing value to set
- `default`      default value or variable storing default value

#### Example

```cmake
set(source_variable "Source value")

set_or_default(result_1 source_variable "Default value")
set_or_default(result_2 undefined_variable "Default value")

message("[${result_1}]")
message("[${result_2}]")
```

Result

```text
[Source value]
[Default value]
```
