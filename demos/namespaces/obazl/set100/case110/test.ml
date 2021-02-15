open OUnit2

let test1 test_ctxt = assert_equal 255 (Demos_Namespaces_Obazl_Set100_Case110__Red.v)
let test2 test_ctxt = assert_equal 127 (Demos_Namespaces_Obazl_Set100_Case110__Green.v)
let test3 test_ctxt = assert_equal 80  (Demos_Namespaces_Obazl_Set100_Case110__Blue.v)

let suite =
"suite">:::
[
  "test1">:: test1;
  "test2">:: test2;
  "test3">:: test3;
]

let () =
  run_test_tt_main suite
