\# Emulating namespaces with OBazl

>    **WARNING** this documentation is outdated but currently undergoing revision.

* [Overview](#overview)
* [Set 000](#set000) Baseline
* [Set 100](#set100) Renaming only
* [Set 200](#set200) Aliasing only
* [Set 300](#set300) Namespacing
* [Set 400](#set400) Exogenous submodules
* [Set 450](#set450) Exogenous ns submodules
* [Set 500](#set500) Mixing endogenous and exogenous submodules
* [Set 600](#set600) Chaining namespaces
* [Set 700](#set700) Miscellany


## <a name="overview">Overview</a>

Run one test: `$ bazel test namespaces/obazl/class01/case01:test`

Run all tests: `$ bazel test //...:*`

Run all tests in one "class" package: `$ bazel test namespaces/obazl/class01/...:*`

Some of the tests print lines to stdout. To see them you can inspect
the test log, or you can use the Bazel `run` command to run tests,
e.g. `$ bazel run namespaces/obazl/class03/case10:test`

To see what gets built for an `ocaml_ns_library`, use the `build`
command, e.g. `$ bazel build namespaces/obazl/class02/case06:color`.

"Resolver" modules are named with suffix `00` plus the `ns_env` name, by default `00_ns_env`.

You can print build commands, inputs, and outputs without executing
the build by using the `aquery` command: `$ bazel aquery
namespaces/obazl/class02/case06:color`.

## <a name="set000">Set 000: Baseline

No renaming, no aliasing, no namespacing. Just to demo how to build
modules with OBazl and test them with ounit2.

* case 10: Minimal example, builds three modules: Red, Green, Blue.

* case 20: As case 10, but with intra-mural dependencies: Red depends
  on Green, which depends on Blue. Bazel disallows cyclic
  dependencies, so we cannot also have Blue depend on Red.

Demo ... shows how to finess cyclic dependencies.

## <a name="set100">Set 100: Renaming without namespaces (aliasing)</a>

The `ns_env` macro is used to support automatic renaming. It expands
to an instance of rule `ocaml_ns_env`. Normally you will never need to
pay it any mind, but if you want to you can see the expansion using
the query facility; for example, `ns_env()` in `set100/case110`
expands as follows:

```
$ bazel query --output=build namespaces/obazl/set100/case110:_ns_env
# /Users/<USERID>/bazel/obazl/dev_obazl/demos/namespaces/obazl/set100/case110/BUILD.bazel:19:7
ocaml_ns_env(
  name = "_ns_env",
  generator_name = "_ns_env",
  generator_function = "ns_env",
  generator_location = "namespaces/obazl/set100/case110/BUILD.bazel:19:7",
  sep = "_",
  aliases = [],
)
# Rule _ns_env instantiated at (most recent call last):
#   /Users/<USERID>/bazel/obazl/dev_obazl/demos/namespaces/obazl/set100/case110/BUILD.bazel:19:7                        in <toplevel>
#   /private/var/tmp/_bazel_<USERID>/07858b33091346eb9c40f9f55369f0e5/external/obazl_rules_ocaml/ocaml/macros.bzl:14:17 in ns_env
# Rule ocaml_ns_env defined at (most recent call last):
#   /private/var/tmp/_bazel_<USERID>/07858b33091346eb9c40f9f55369f0e5/external/obazl_rules_ocaml/ocaml/_rules/ocaml_ns_env.bzl:181:20 in <toplevel>
```

Using the same Red, Blue, Green modules as in Set 000, these demos
show how to automatically rename modules. None of the demos in this
set use `ocaml_ns_library`.

In case of renaming without aliasing, references to modules must use
the new name. For example, if we rename `red.ml` to `Demo_bar__red.ml`
(as in case120), then source code must use 'Demo_bar__red`. With
aliasing, as shown in later examples, we will automatically generate
an alias that maps `Red` to `Demo_bar__Red`, so source code can use `Red`.

* case 110: Default renaming uses the package path to form the
  pseudo-namespace prefix used to rename modules.

* case 120: Same as case110, but with a more manageable custom prefix.

* case 130: Same as case120, but we also give the ns_env itself a
  custom name (this will become consequential when we also use
  aliases).

* case 140: Same as case120, but with intramural deps: Red depends on
  Green, Green on Blue. Also demonstrates that target names are
  arbitrary. Try running a query to see the dep structure:

```
$ bazel query 'deps(namespaces/obazl/set100/case140:_Red)' --output graph --noimplicit_deps
digraph mygraph {
  node [shape=box];
  "//namespaces/obazl/set100/case140:_Red"
  "//namespaces/obazl/set100/case140:_Red" -> "//namespaces/obazl/set100/case140:_ns_env"
  "//namespaces/obazl/set100/case140:_Red" -> "//namespaces/obazl/set100/case140:red.ml"
  "//namespaces/obazl/set100/case140:_Red" -> "//namespaces/obazl/set100/case140:_FooGreen"
  "//namespaces/obazl/set100/case140:_FooGreen"
  "//namespaces/obazl/set100/case140:_FooGreen" -> "//namespaces/obazl/set100/case140:_ns_env"
  "//namespaces/obazl/set100/case140:_FooGreen" -> "//namespaces/obazl/set100/case140:green.ml"
  "//namespaces/obazl/set100/case140:_FooGreen" -> "//namespaces/obazl/set100/case140:_Blue"
  "//namespaces/obazl/set100/case140:_Blue"
  "//namespaces/obazl/set100/case140:_Blue" -> "//namespaces/obazl/set100/case140:_ns_env"
  "//namespaces/obazl/set100/case140:_Blue" -> "//namespaces/obazl/set100/case140:blue.ml"
  "//namespaces/obazl/set100/case140:green.ml"
  "//namespaces/obazl/set100/case140:red.ml"
  "//namespaces/obazl/set100/case140:_ns_env"
  "//namespaces/obazl/set100/case140:blue.ml"
}
```

>    **IMPORTANT** The nodes in the depenency graph shown above are Bazel targets; they do not necessarily correspond to filesystem objects. In particular, target `//namespaces/obazl/set100/case140:_ns_env` does not generate any files, it only supplies a pseudo-namespace prefix string to clients that depend on it.


* case 150: Uses a custom separator string "_0_" to replace
  filesystem separator '/', or '.' in custom prefixes).

* case 152: Same as case150, but with a custom prefix.

* case 155: Same as case 20, but with a more manageable prefix.

* case 160: Remapping modules without renaming files. The examples so
  far have only used ns_env to manage file renaming. We can also use
  `ocaml_ns_library` to make modules accessible under new names.

  The module names under which module implementations (files) are made
  accessible are determined by the values of the `submodules`
  attribute of the `ocaml_ns_library` rule. This effectively decouples
  module paths from filesystem names. This example maps e.g.
  Couleur.Roux to module Red, which is not renamed.

* case 170: Multiple ns evaluation environments. Shows how to use
  ns_env variants to specify different prefixes for different groups
  of modules. Files enrolled in the ns envs are renamed. This demo
  does not use rule `ocaml_ns_library`.

  This makes the submodules available under two sets of names: one
  determined by the ns_env (as in case170), e.g. `Grue__Green`, and
  one determined by the ns library path, e.g. `Color.Green`.

* case 185: Even more renaming/remapping. This demo combines the
  techniques shown in cases 160 (remapping), 170 (multiple ns envs),
  and 180 (using an ns lib)

  Like case180, this demo makes the submodules available under two
  sets of names: one determined by the ns_env (as in case170), e.g.
  `Grue__Green`, and one determined by the ns library path, but in
  this case the `ocaml_ns_library` remaps, giving e.g. `Couleur.Vert`
  instead of `Color.Green`.

## <a name="set200">Set 200: Aliasing only</a>

Pure "aliasing" involves the use of aliasing equations (i.e.
 [type-level module
 aliases](https://caml.inria.fr/pub/docs/manual-ocaml/modulealias.html))
 without module renaming. It follows that only pseudo-recursive
 aliasing equations can be used in this way. This allows you to use
 module paths to refer to your modules, e.g. `A.B`, but without the
 protection against name clashes afforded by renaming.

In OBazl, you can do this by using rule `ocaml_ns_library` but not
macro `ns_env` (equivalently, rule `ocaml_ns_env`).

None of the demos in this set use renaming (ns_env). They demonstrate
(among other things) that renaming and aliasing are orthogonal.

> **NOTE**: if you use aliasing without renaming, the aliasing
       equations, whether generated or provided by you, will often be
       pseudo-recursive, that is, of form "module M = M".

* case 210: Demonstrates use of an `ocaml_ns_library` rule to generate a
  main ns module containing pseudo-recursive aliasing equations,
  without the use of renaming.

>        **NOTE**: if renaming is also used, then the generated module will
>        contain non-recursive aliasing equations of form "module M = <prefix>__M",
>        where <prefix> is the prefix string set by the ns_env. See demo sets below
>        for more details and examples.

* case 220: User-provided ns main module. OBazl will use the user file
  as main ns module instead of generating one. Since this example does
  not use renaming, nothing more is needed.

>        **IMPORTANT**: User-provided 'main' must include an aliasing
>        equation, of form "module X = Y", for each submodule X. Often
>        these will be pseudo-recursive equations, of form "module X = X".
         It may include additional code, but it must include the aliasing
>        equations for resolution to work.

* case 230: Same as case220, but the designated main has a different
  name ("color_main") than the ocaml_ns_library "color"). OBazl will
  copy the user-provided file to the ns name.

* case 240: Includes. User provides an include module "color_include",
  and OBazl will add "include Color_include" to the resolver, below
  the aliasing equations.

## <a name="set300">Set 300: Namespacing

Namespacing combines renaming and aliasing.  So things get a bit trickier.

The ns libraries in these examples all use _endogenous_ submodules -
submodules defined in the same (Bazel) package as the ns library.
Exogenous submodules are also supported - see demos below.

* case310: Minimal renaming, without intramural deps, with main ns
  module aliasing but no ns_env resolver. Compiling without an ns_env
  resolver means that intramural references cannot be resolved.

* case311: Same as case 310 but uses `ocaml_ns_archive` instead of `ocaml_ns_library`.

* case 316: same as case10, but with ns_env resolver supporting intramural deps.

To enable intramural deps, we specify an `aliases` list for our
ns_env. That is what enables compilation of submodules with
interdependencies: the ns_env generates a "resolver" module containing
the needed aliasing equations, which is used with `-open` and
`-no-alias-deps` to compile the submodules in the namespace lib.

>    **IMPORTANT** The query facility is useful to explore structure:

```
$ bazel query 'deps(namespaces/obazl/set300/case316:_Red)' --output graph --noimplicit_deps
digraph mygraph {
  node [shape=box];
  "//namespaces/obazl/set300/case316:_Red"
  "//namespaces/obazl/set300/case316:_Red" -> "//namespaces/obazl/set300/case316:_ns_env"
  "//namespaces/obazl/set300/case316:_Red" -> "//namespaces/obazl/set300/case316:red.ml"
  "//namespaces/obazl/set300/case316:_Red" -> "//namespaces/obazl/set300/case316:_Blue"
  "//namespaces/obazl/set300/case316:_Blue"
  "//namespaces/obazl/set300/case316:_Blue" -> "//namespaces/obazl/set300/case316:_ns_env"
  "//namespaces/obazl/set300/case316:_Blue" -> "//namespaces/obazl/set300/case316:blue.ml"
  "//namespaces/obazl/set300/case316:_ns_env"
  "//namespaces/obazl/set300/case316:_ns_env" -> "//namespaces/obazl/set300/case316:blue.ml"
  "//namespaces/obazl/set300/case316:_ns_env" -> "//namespaces/obazl/set300/case316:green.ml\n//namespaces/obazl/set300/case316:test.ml"
  "//namespaces/obazl/set300/case316:_ns_env" -> "//namespaces/obazl/set300/case316:red.ml"
  "//namespaces/obazl/set300/case316:red.ml"
  "//namespaces/obazl/set300/case316:green.ml\n//namespaces/obazl/set300/case316:test.ml"
  "//namespaces/obazl/set300/case316:blue.ml"
}
```

* case 317: same as case 316, but uses `ocaml_ns_archive` instead of `ocaml_ns_library`

* case 345: Add an 'include X' statement to the resolver. The build
  rule for the included module must be coordinated with the `ns_env`
  rule.

* case 360: basic ns library with 'include' module

* case 375: combining module remapping and multiple ns environments.
  Uses both macro `ns_env` and rule `ocaml_ns_library`.



## <a name="set400">Set 400: Exogenous submodules</a>

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

## <a name="set450">Set 450: Exogenous ns submodules</a>

## <a name="set500">Set 500: Mixing endogenous and exogenous submodules</a>

* case 09: generated main ns module, one endogenous submodule and three exogenous submodules

* case 10: same as case09, except with a user-provided main ns module

## <a name="set600">Set 600: Chaining namespaces</a>

Demonstrating how to construct multi-segment module paths like
`A.B.C.D` by including ns modules as submodules.

* case 21: generated main ns module containing two exogenous ns submodules defined in subdirectories

* case 22: user-provided main ns module containing two exogenous ns submodules defined in subdirectories

* case 23: generated main ns module containing a variety of submodules: ns and non-ns, local and exogenous

* case 24: defines A.Color in one package (directory). Main ns module is A, submodule Color is defined endogenously (in same package as A).  Also demonstrates use of alternative name (label) for ns resolver.

## <a name="set700">Set 700: Miscellany</a>

* case 31: demonstrates submodule interdependencies, sticky deps, mulitiple namespaces in on package, decoupling of submodule names and filenames.


## <a name="troubleshooting">Troubleshooting</a>

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
