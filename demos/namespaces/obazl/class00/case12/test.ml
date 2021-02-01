open OUnit2

let test1 test_ctxt = assert_equal 255 (Demos_Namespaces_Obazl_Class00_Case12__Red.v)
let test2 test_ctxt = assert_equal 127 (Grue__Green.v)
let test3 test_ctxt = assert_equal 80  (Grue__Blue.v)

let suite =
"suite">:::
["test1">:: test1;
 "test2">:: test2;
 "test3">:: test3;
]
;;

let () =
  run_test_tt_main suite
;;
