load("@obazl_rules_opam//opam:providers.bzl", "OpamConfig", "OpamSwitch")

## verification and pinning: if no version specified latest version
## will be installed and pinned
PACKAGES = {
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

opam = OpamConfig(
    version = "2.0",
    switches  = {
        "4.11.1": OpamSwitch(
            default  = True,
            compiler = "4.11.1",
            packages = PACKAGES
        ),
        "4.07.1": OpamSwitch(
            default  = False,
            compiler = "4.07.1",
            packages = PACKAGES
        ),
    }
)
