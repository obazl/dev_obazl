# Executables

`ocaml_executable`, `ppx_executable`, with and without 'main' attrib.

Demonstrate dependency handling when executable depends directly and
indirectly on modules, libs, archives.

## <a name="set100">Set 100: 'main' attribute</a>

* case 110: simple `ocaml_executable` using 'main'
* case 120: same as case110 but without 'main'

* case 130: mixed: use 'main' plus 'deps'
