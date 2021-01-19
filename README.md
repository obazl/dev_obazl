# dev_obazl

Demos, tools, and tests for
[obazl_rules_ocaml](https://github.com/obazl/rules_opam) and
[obazl_rules_opam](https://github.com/obazl/rules_opam).

Documentation: [docs_obazl](https://obazl.github.io/docs_ocaml/ug/)

## Demos

>    Contributing: if you would like to contribute a demo, please file an
>    issue first. Demos should illustrate one concept, using minimal code.
>    They should not require the user to install or configure any other
>    software, unless that is the point of the demo.

### prerequisites:

* install [OPAM](https://opam.ocaml.org/)

* install a switch using the latest version (4.11.1) of OCaml: `$ opam switch create 4.11.1`.

  * if you want to use a different switch, you will need to edit the
    `OpamConfig` struct in `demos/WORKSPACE.bzl`.

* install ocamlfind: `$ opam install ocamlfind`

* install merlin (if you use emacs): `$ opam install merlin`

* install the packages listed in `demos/WORKSPACE.bzl`. (OBazl contains
  code to do this automatically, but it is currently under revision.)

  * before you install `lwt`, install `libev` (MacOS) or `libevdev`
    (Linux). See [lwt github](https://github.com/ocsigen/lwt) for more
    information.

    * MacOS:  `brew install libev`
    * Linux: use your package manager to install `libev-dev` or `libev-devel`.

* `cd demos` and build/run/test some demos. See the `BUILD.bazel` files for instructions. For example:

```
    $ bazel build minimal/hello_module:_Hello
    $ bazel test minimal/hello_module:test
    $ bazel run minimal/hello_executable
```

### manifest

* [conditional](demos/conditional) Conditional compilation - selection of build targets based on config parameters

* [configuration](demos/configuration) - demonstrates use of build
  flags and settings, and `--config` command line flag.

* [filegen](demos/filegen) File generation techniques

* [interop](demos/interop/README.md) - using C/C++ and other (Rust, Go, etc) resources
  * [ffi](demos/interop/ffi) - Uses standard OCaml low level [FFI](https://caml.inria.fr/pub/docs/manual-ocaml/intfc.html) to wrap simple C library
  * [ctypes](demos/interop/ctypes) - Uses the higher level [ctypes](https://github.com/ocamllabs/ocaml-ctypes) package. (Not yet implemented)
  * [cstubs](demos/interop/cstubs) - Uses the [cstubs](http://simonjbeaumont.com/posts/ocaml-ctypes) subpackage of the [ctypes] package. (Not yet implemented)

* [minimal](demos/minimal) - minimal examples
  * [hello_archive](demos/minimal/hello_archive) - a simple use of `ocaml_archive`
  * [hello_executable](demos/minimal/hello_executable) - a simple use of `ocaml_executable`
  * [hello_lwt](demos/minimal/hello_lwt) - a simple use of OPAM pkg `lwt.unix`
  * [hello_module](demos/minimal/hello_module) - a simple use of `ocaml_module`

* [namespaces](demos/namespaces) - using namespaces
  * [hello](demos/namespaces/hello) - demo of a simple namespace module with four submodules.
  * [minimal](demos/namespaces/minimal) - demo of raw namespaces using makefiles instead of Bazel.

* [ppx](demos/ppx) - PPX support demos
  * [adjunct_deps](demos/ppx/adjunct_deps) - shows how to use PPX adjunct deps (a/k/a "runtime" deps)
  * [deriver](demos/ppx/deriver) - minimal example of a Ppxlib deriver implementation (TODO)
  * [hello](demos/ppx/hello) - simple example using `ppx_sexp_value`
  * [ppx_optcomp](demos/ppx/ppx_optcomp) - demonstrates runtime dependency using `[%%import ]` extension
  * [rewriter](demos/ppx/rewriter) - simple example of a Ppxlib rewriter implementation (TODO)
  * [runner](demos/ppx/runner) - simple `genrule` implementation of shared Ppxlib.Driver.standalone runner

* [rules](demos/rules) - demos of `ocaml_*` rules
  * [ocaml_archive](demos/rules/ocaml_archive)
  * [ocaml_executable](demos/rules/ocaml_executable)
  * [ocaml_interface](demos/rules/ocaml_interface)
  * [ocaml_module](demos/rules/ocaml_module)
  * [ocaml_test](demos/rules/ocaml_test) - demonstrates use of libs `ounit2`, `alcotest`, and `ppx_inline_test`

## Acknowledgements

Support for the development of OBazl was provided by a Mina Genesis
Token Grant and the generous assistance of the [Mina](https://minaprotocol.com/) team.