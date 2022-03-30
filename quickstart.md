# quickstart

**IMPORTANT** The first version of OBazl used `ocamlfind` to drive
builds. These instructions are for the version 2 of OBazl and related
repos, which do not use `ocamlfind`.

See [Developing OCaml software with OBazl](https://obazl.github.io/docs_obazl/ug/development.html) for more information on getting started.

* platform: tested on MacOS Catalina (10.15.7) and Linux (Debian 9). Probably won't work on Windows.

* install [OPAM](https://opam.ocaml.org/doc/Install.html)

* install switch: `$ opam switch create 4.12.0`.

    * sigh. `[ERROR] Compiler selection '4.12.0' is ambiguous.
    matching packages: { ocaml-base-compiler.4.12.0,
    ocaml-system.4.12.0 }`. Try this:

    `opam switch create 4.12.0 ocaml-base-compiler.4.12.0`

    * after the install completes, you will be asked to run `eval
      $(opam env)`. Do it!

    * verify: `opam switch`

* install OPAM dependencies

    * see what you have: `opam list`

    * install what you need: `opam switch import OPAM.export --switch 4.12.0`

        * alternatively it may suffice to run `opam import` for the
          items in the `root` stanza of `OPAM.export`.

        * run `$ bazel clean --expunge` after installing new OPAM
          packages. (You won't need to do this once all required OPAM
          packages are installed.)

    * if you're missing something, you'll get errors like the following:
```
no such package '@opam//lib/core': BUILD file not found in directory 'lib/core' of external repository @opam.
```

        That means you need to run `opam install core` (and then `bazel clean --expunge`).

* you may need to install some system deps, e.g. `libev` (MacOS) or
    `libevdev` (Linux), needed by `lwt`, which is used in demo
    `demos/hello/lwt`. See [lwt
    github](https://github.com/ocsigen/lwt) for more information.

    * MacOS:  `brew install libev`
    * Linux: use your package manager to install `libev-dev` or `libev-devel`.

* Set up your [user.bazelrc](https://obazl.github.io/docs_obazl/ug/user_bazelrc.html) file (optional). Put it in `demos/.private`. An example may be found in `tools/user.bazelrc`.

**WARNING** After installing opam packages you need to then run `$ bazel
clean --expunge`.

* `cd demos` and build/run/test some demos. See the `BUILD.bazel` files for instructions.

```
    $ bazel test test
    $ bazel test aggregators:test
    $ bazel test aggregators/ocaml_archives:test
    $ bazel test aggregators/ocaml_archives/case110:test
```

Some demos define executable targets that you can run with `$ bazel run`.  To list all executable rules try:

```
$ bazel query 'kind(ocaml_executable, //...:*)' --output label_kind
```

**IMPORTANT** Not all of the demos work. See the list of broken stuff
in `demos/.bazelignore`
