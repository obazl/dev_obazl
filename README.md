# dev_obazl

OBazl development tools and tests

## Demos

* [configuration](demos/configuration) - demonstrates use of build
  flags and settings, and `--config` command line flag.

* [minimal](demos/minimal) - minimal examples
  * [hello_archive](demos/minimal/hello_archive) - a simple use of `ocaml_archive`
  * [hello_executable](demos/minimal/hello_executable) - a simple use of `ocaml_executable`
  * [hello_lwt](demos/minimal/hello_lwt) - a simple use of OPAM pkg `lwt.unix`
  * [hello_module](demos/minimal/hello_module) - a simple use of `ocaml_module`

* [namespaces](demos/namespaces) - using namespaces
  * [makefiles](demos/namespaces/makefiles) - demo of raw namespaces using makefiles instead of Bazel.

* [ppx](demos/ppx) - PPX support demos
  * [adjunct_deps](demos/ppx/adjunct_deps) - shows how to use PPX adjunct deps (a/k/a "runtime" deps)
  * [deriver](demos/ppx/deriver) - minimal example of a Ppxlib deriver implementation (TODO)
  * [hello](demos/ppx/hello) - simple example using `ppx_sexp_value`
  * [ppx_optcomp](demos/ppx/ppx_optcomp) - demonstrates runtime dependency using `[%%import ]` extension
  * [rewriter](demos/ppx/rewriter) - simple example of a Ppxlib rewriter implementation (TODO)
  * [runner](demos/ppx/runner) - simple shared implementation of Ppxlib.Driver.standalone runner

* [rules](demos/rules) - demos of `ocaml_*` rules
  * [ocaml_archive](demos/rules/ocaml_archive)
  * [ocaml_executable](demos/rules/ocaml_executable)
  * [ocaml_interface](demos/rules/ocaml_interface)
  * [ocaml_module](demos/rules/ocaml_module)
  * [ocaml_test](demos/rules/ocaml_test)
