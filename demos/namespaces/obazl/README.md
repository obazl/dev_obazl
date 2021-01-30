# Emulating namespaces with OBazl

Run one test: `$ bazel test namespaces/obazl/class01/case01:test`

Run all tests: `$ bazel test //...:*`

Run all tests in one "class" package: `$ bazel test namespaces/obazl/class01/...:*`

Some of the tests print lines to stdout. To see them you can inspect
the test log, or you can use the Bazel `run` command to run tests,
e.g. `$ bazel run namespaces/obazl/class03/case10:test`

To see what gets built for an `ocaml_ns_module`, use the `build`
command, e.g. `$ bazel build namespaces/obazl/class02/case06:color`.

"Resolver" modules are named with suffix `00`.

You can print build commands, inputs, and outputs without executing
the build by using the `aquery` command: `$ bazel aquery
namespaces/obazl/class02/case06:color`.

## Class 01: Minimal examples

* case 01: ns module generated, contains only alias equations. no resolver module needed

* case 02: ns module generated, with user-provided footer. no resolver needed

* case 03: user provides ns main module with same name as ns.
  **User-provided 'main' must include pseudo-recursive alias
  equations**. obazl will use the user file as main ns module. resolver
  module generated to resolve the pseudo-recursive equations.

* case 04: user provides ns main module with different name. obazl will copy the
  user-provided file to the ns name.  resolver module generated.

## Class02: Exogenous submodules

A namespace can contain "exogenous" submodules - submodules defined
elsewhere in the filesystem. Note that in these cases we do not need
to call ns() to set up an ns resolver (unless we also include
endogenous submodules, see Class03 below), since exogenous submodules
have their ns resolvers.

* case 05: generated main ns module with submodules from class01/case01.

* case 06: user-provided main ns module, same name as ns, with submodules from class01/case01.

* case 07: user-provided main ns module, different name than ns name,
  with submodules from class01, cases 01, 02, 03.

* case 08: generated main ns module with user-supplied footer, with
  submodules from class01, cases 01, 02, 03.

## Class03: Mixing endogenous and exogenous submodules

* case 09: generated main ns module, one endogenous submodule and three exogenous submodules

* case 10: same as case09, except with a user-provided main ns module

## Class 05: Chained namespaces

Demonstrating how to construct multi-segment module paths like
`A.B.C.D` by including ns modules as submodules.

* case 21: generated main ns module containing two exogenous ns submodules defined in subdirectories

* case 22: user-provided main ns module containing two exogenous ns submodules defined in subdirectories

* case 23: generated main ns module containing a variety of submodules: ns and non-ns, local and exogenous

* case 24: defines A.Color in one package (directory). Main ns module is A, submodule Color is defined endogenously (in same package as A).

## Extended examples

* case 13: demonstrates submodule interdependencies, sticky deps, mulitiple namespaces in on package.

## Class 06: 

## Troubleshooting

### Missing alias

```
File "bazel-out/darwin-fastbuild/bin/namespaces/obazl/case11/cmy/_obazl_/Demos_namespaces_obazl_case11_cmy__Cyan.ml", line 3, characters 84-93:
3 | let () = print_endline ("Hello from module CMY.Cyan. Cmy.Magenta: " ^ string_of_int Magenta.v) ;;
                                                                                        ^^^^^^^^^
Error: The module Magenta is an alias for module Demos_namespaces_obazl_case11_cmy__Magenta, which is missing
```

Intra-ns dependencies must be explicitly listed on by the depending
submodules. In this case, the Cyan submodule has a dependency on the
Magenta submodule, but it was not listed in the `ocaml_module` rule
for Cyan. Adding `"_:Magenta"` to the `deps` attribute resolved the problem.
