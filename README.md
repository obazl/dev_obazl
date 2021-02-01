# dev_obazl

Demos, tools, and tests for
[obazl_rules_ocaml](https://github.com/obazl/rules_opam) and
[obazl_rules_opam](https://github.com/obazl/rules_opam).

Documentation: [docs_obazl](https://obazl.github.io/docs_obazl/)


### quickstart

See [Developing OCaml software with OBazl](https://obazl.github.io/docs_obazl/ug/development.html) for more information on getting started.

* platform: tested on MacOS Catalina (10.15.7) and Linux (Debian 9). Probably won't work on Windows.

* install [OPAM](https://opam.ocaml.org/)

* install a switch using the latest version (4.11.1) of OCaml: `$ opam switch create 4.11.1`.

  * if you want to use a different switch, you will need to edit the
    `OpamConfig` struct in `demos/WORKSPACE.bzl`.

* install ocamlfind: `$ opam install ocamlfind`

* install the packages listed in `demos/WORKSPACE.bzl`.

>    You can ask OBazl to do this for you by setting a few environment variables:
>    `$ OBAZL_OPAM_VERIFY=1 OBAZL_OPAM_PIN=1 bazel test minimal/hello_module:test`
>    This capability is undergoing revision; it will mostly work, but you will still
>    have to install a few packages by hand, e.g. `$ opam install core` etc.

  * before you install `lwt`, you may need to install `libev` (MacOS) or `libevdev`
    (Linux). See [lwt github](https://github.com/ocsigen/lwt) for more
    information.

    * MacOS:  `brew install libev`
    * Linux: use your package manager to install `libev-dev` or `libev-devel`.

* Set up your [user.bazelrc](https://obazl.github.io/docs_obazl/ug/user_bazelrc.html) file.

* `cd demos` and build/run/test some demos. See the `BUILD.bazel` files for instructions. For example:

```
    $ bazel build minimal/hello_module:_Hello
    $ bazel test minimal/hello_module:test
    $ bazel run minimal/hello_module:test
    $ bazel run minimal/hello_executable
```

To run all tests:  `$ bazel test //...:*`

To list all executable rules (which you can run with `$ bazel run ...`):

```
$ bazel query 'kind(ocaml_executable, //...:*)' --output label_kind
```

[Demos](demos)

## Acknowledgements

Support for the development of OBazl was provided by a Mina Genesis
Token Grant and the generous assistance of the [Mina](https://minaprotocol.com/) team.
