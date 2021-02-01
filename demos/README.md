# demos

>    Contributing: if you would like to contribute a demo, please file an
>    issue first. Demos should illustrate one concept, using minimal code.
>    They should not require the user to install or configure any other
>    software, unless that is the point of the demo.

### manifest

> **WARNING** this manifest is outdated, but is currently being
       updated. In the meantime see the README files and BUILD.bazel
       files in the demo subdirectories.

* [conditional](conditional) Conditional compilation - selection of build targets based on config parameters

* [configuration](configuration) - demonstrates use of build
  flags and settings, and `--config` command line flag.

* [filegen](filegen) File generation techniques

* [interop](interop/README.md) - using C/C++ and other (Rust, Go, etc) resources
  * [ffi](interop/ffi) - Uses standard OCaml low level [FFI](https://caml.inria.fr/pub/docs/manual-ocaml/intfc.html) to wrap simple C library
  * [ctypes](interop/ctypes) - Uses the higher level [ctypes](https://github.com/ocamllabs/ocaml-ctypes) package. (Not yet implemented)
  * [cstubs](interop/cstubs) - Uses the [cstubs](http://simonjbeaumont.com/posts/ocaml-ctypes) subpackage of the [ctypes] package. (Not yet implemented)

* [minimal](minimal) - minimal examples
  * [hello_archive](minimal/hello_archive) - a simple use of `ocaml_archive`
  * [hello_executable](minimal/hello_executable) - a simple use of `ocaml_executable`
  * [hello_lwt](minimal/hello_lwt) - a simple use of OPAM pkg `lwt.unix`
  * [hello_module](minimal/hello_module) - a simple use of `ocaml_module`

* [namespaces](namespaces) - using namespaces
  * [direct](namespaces/direct) - hand-rolled namespaces using makefiles instead of Bazel.
    * [direct/hash](namespaces/direct/hash) - a perverse example showing how to map modules to files named with the MD5 hash of the source files.
  * [hello](namespaces/hello) - demo of a simple namespace module with four submodules.
  * [obazl demos](namespaces/obazl) - 30+ simple demos illustrating all aspects of namespacing with OBazl

* [ppx](ppx) - PPX support demos
  * [adjunct_deps](ppx/adjunct_deps) - shows how to use PPX adjunct deps (a/k/a "runtime" deps)
  * [deriver](ppx/deriver) - minimal example of a Ppxlib deriver implementation (TODO)
  * [hello](ppx/hello) - simple example using `ppx_sexp_value`
  * [ppx_optcomp](ppx/ppx_optcomp) - demonstrates runtime dependency using `[%%import ]` extension
  * [rewriter](ppx/rewriter) - simple example of a Ppxlib rewriter implementation (TODO)
  * [runner](ppx/runner) - simple `genrule` implementation of shared Ppxlib.Driver.standalone runner

* [rules](rules) - demos of `ocaml_*` rules
  * [ocaml_archive](rules/ocaml_archive)
  * [ocaml_executable](rules/ocaml_executable)
  * [ocaml_interface](rules/ocaml_interface)
  * [ocaml_module](rules/ocaml_module)
  * [ocaml_test](rules/ocaml_test) - demonstrates use of libs `ounit2`, `alcotest`, and `ppx_inline_test`

----

**WARNING: OBSOLETE DOC**

Run Bazel builds from the `demos` directory, e.g.

```
$ cd demos
$ bazel build minimal/hello`
```

To run tests, just replace `build` with `test`:

`$ bazel test minimal/hello`

You may want to run `$ bazel clean` sometimes. During normal
development you rarely need to do this, but it may be useful for
inspecting demos. Alternatively, use `aquery` instead of `build`; this
will print build commands without executing them.

Some of the demos also have dune files or make files.

## deriving-slowly

The `deriving-slowly` demos demonstrate simple PPX code. They are
taken from [Deriving
Slowly](http://rgrinberg.com/posts/deriving-slowly/).

## hello

OBazl verions of demos from the Dune
[Quickstart](https://dune.readthedocs.io/en/stable/quick-start.html).

* hello - [Building a hello world program](https://dune.readthedocs.io/en/stable/quick-start.html#building-a-hello-world-program).  Bazel build command:  `$ bazel build hello/hello`
* lwt - [Building a hello world program using Lwt](https://dune.readthedocs.io/en/stable/quick-start.html#building-a-hello-world-program-using-lwt)  Bazel build command:  `$ bazel build hello/lwt`
* ppx - [Building a hello world program using Core and Jane Street PPXs](https://dune.readthedocs.io/en/stable/quick-start.html#building-a-hello-world-program-using-core-and-jane-street-ppxs)  Bazel build command:  `$ bazel build hello/ppx`
* lib - [Defining a library using Lwt and ocaml-re](https://dune.readthedocs.io/en/stable/quick-start.html#defining-a-library-using-lwt-and-ocaml-re)  Bazel build command:  `$ bazel build hello/lib`

## namespaces

Code demonstrating file-system namespaces and OCaml module paths.

* [flat](namespaces/flat) - demonstrates mapping from flat to hiearchical namespace.  Makefiles only.
  * `eager`
  * `lazy` - uses `-no-alias-deps` to enable lazy linking.
* [makefiles](namespaces/makefiles) - a few simple demos exploring use of underscores in names; does not use OBazl.
* [ns-archive](namespaces/ns-archive) - demonstrates rule `ocaml_ns_archive`: create a namespaced module from a file system tree.
  * `macro` - uses a Bazel macro for demo purposes.
  * `rule` - uses a Bazel rule, `ocaml_ns_archive`.  Automatically
    generates, renames, compiles, and links the files needed to support namespacing.
