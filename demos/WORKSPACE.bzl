load("@obazl_rules_ocaml//ocaml:providers.bzl", "OpamConfig", "BuildConfig")

opam_pkgs = {
    "alcotest": [],
    ## NOTE: lwt depends on a c lib, libevdev; you must install this using your pkg mgr (apt-get, etc)
    ## on MacOS: brew install libev. Linux: libev-dev or libev-devel
    "lwt": ["", ["lwt.unix"]], # ["4.2.1", ["lwt.unix"]], # needed by //hello/lwt:_Hello_lwt
    "core": [], # needed by //hello/hello_ppx:_Hello_ppx
    "ounit2": [],
    "ppx_deriving": ["", ["ppx_deriving.runtime", "ppx_deriving.ord", "ppx_deriving.show"]],
    "ppx_expect": ["", ["ppx_expect.collector"]],
    "ppx_inline_test": ["", [
        "ppx_inline_test.runtime-lib",
        "ppx_inline_test.runner",
        "ppx_inline_test.runner.lib"
    ]],
    "ppxlib": ["", ["ppxlib.runner", "ppxlib.runner_as_ppx"]],
    "ppx_optcomp": [],
    "ppx_sexp_conv": ["", ["ppx_sexp_conv.runtime-lib"]],
    "ppx_sexp_value": [],  # needed by  //hello/hello_ppx:_Hello_ppx
    "sexplib": [], ## needed by ppx_sexp_conv
}

# in this case dev_pkgs = pkgs, but they could differ
opam_pkgs_dev = {
    "alcotest": "1.2.3",
    ## NOTE: lwt depends on a c lib, libevdev; you must install this using your pkg mgr (apt-get, etc)
    ## on MacOS: brew install libev. Linux: libev-dev or libev-devel
    "lwt": ["", ["lwt.unix"]], # ["4.2.1", ["lwt.unix"]], # needed by //hello/lwt:_Hello_lwt
    "core": "", # needed by //hello/hello_ppx:_Hello_ppx
    "ounit2": "2.2.4",
    "ppx_deriving": ["", ["ppx_deriving.runtime", "ppx_deriving.ord", "ppx_deriving.show"]],
    "ppx_expect": ["", ["ppx_expect.collector"]],
    "ppx_inline_test": ["", [
        "ppx_inline_test.runtime-lib",
        "ppx_inline_test.runner",
        "ppx_inline_test.runner.lib"
    ]],
    "ppxlib": ["", ["ppxlib.runner", "ppxlib.runner_as_ppx"]],
    "ppx_optcomp": "",
    "ppx_sexp_conv": ["", ["ppx_sexp_conv.runtime-lib"]],
    "ppx_sexp_value": [],  # needed by  //hello/hello_ppx:_Hello_ppx
    "sexplib": [], ## needed by ppx_sexp_conv
}

opam = OpamConfig(
    version = "2.0",
    builds  = {
        # Build (toolchain) id -> opam switch with its own id
        # that way we can map same multiple tc ids to same switch,
        # the difference being obazl verification/install/etc.
        "v1.0.0-dev": BuildConfig(
            default  = True,
            verify   = True,
            switch   = "4.11.1",
            compiler = "4.11.1",
            packages = opam_pkgs_dev
        ),
        "v1.0.0-beta.1": BuildConfig(
            verify   = True,
            switch   = "4.11.1",
            compiler = "4.11.1",
            packages = opam_pkgs
        ),
        "v1.0.0-release": BuildConfig(
            # default  = True,
            verify   = True,
            # switch   = "4.11.1-release",
            compiler = "4.11.1",
            packages = opam_pkgs
        ),
        # Default: build id == opam switch id
        "4.11.1": BuildConfig(
            # default  = True,
            # omission of switch ok if switch name = compiler version
            compiler = "4.11.1",
            packages = opam_pkgs
        ),
        "4.07.1": BuildConfig(
            compiler = "4.07.1",
            packages = opam_pkgs
        ),
    }
)
