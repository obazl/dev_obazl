open OUnit2

let test1 test_ctxt = assert_equal 255 (X.Color.Red.v)
let test2 test_ctxt = assert_equal 127 (X.Color.Green.v)
let test3 test_ctxt = assert_equal 80  (X.Color.Blue.v)

(* you can also use the submodule directly *)
let test4 test_ctxt = assert_equal 255 (Color.Red.v)
let test5 test_ctxt = assert_equal 127 (Color.Green.v)
let test6 test_ctxt = assert_equal 80  (Color.Blue.v)

let suite =
"suite">:::
["test1">:: test1;
 "test2">:: test2;
 "test3">:: test3;

 "test4">:: test4;
 "test5">:: test5;
 "test6">:: test6;
]


let () =
  run_test_tt_main suite
