# emulating namespaces with obazl

## Minimal examples

* case 01: ns module generated, contains only alias equations. no resolver module needed

* case 02: ns module generated, with user-provided footer. no resolver needed

* case 03: user provides ns main module with same name as ns. must
  include pseudo-recursive alias equations. obazl will use the user
  file as main ns module. resolver module generated to resolve the
  pseudo-recursive equations.

* case 04: user provides ns main module with different name. obazl will copy the
  user-provided file to the ns name.  resolver module generated.

## Cross-package namespaces!

A namespace can contain submodules from "foreign" packages. Note that
in these cases we do not need ns-init unless we include submodules
from the same package as the namespace, since "foreign" submodules
have their own ns-init targets.

* case 05: generated main ns module with submodules from case 1.

* case 06: user-provided main ns module, same name as ns, with submodules from case 1.

* case 07: user-provided main ns module, different name than ns name, with submodules from cases 1, 2, 3.

* case 08: generated main ns module with user-supplied footer, with submodules from cases 1, 2, 3.

* case 09: generated main ns module, with one local submodule and foreign submodules from cases 1, 2, 3.

## Chained namespaces

Demonstrating how to construct multi-segment module paths like
`A.B.C.D` by including ns modules as submodules.

* case 10: generated main ns module containing two ns submodules

* case 11: user-provided main ns module containing two ns submodules

* case 12: generated main ns module containing a variety of submodules: ns and non-ns, local and foriegn

## Extended examples

* case 13: demonstrates submodule interdependencies, sticky deps, mulitiple namespaces in on package.

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
