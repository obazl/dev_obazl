open OUnit2

let x : Alpha.t = {a = "hello"; b = 7}

let test1 test_ctxt = assert_equal "hello" (Alpha.a x)
let test2 test_ctxt = assert_equal "7" (string_of_int (Alpha.b x))
let test3 test_ctxt = assert_equal "hello 7" ( (Alpha.a x) ^ " " ^ (string_of_int (Alpha.b x)) )

let suite =
"suite">:::
[
  "test1">:: test1;
  "test2">:: test2;
  "test3">:: test3;
]

let () =
  run_test_tt_main suite
