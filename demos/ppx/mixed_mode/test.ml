open OUnit2

let test1 test_ctxt = assert_equal "MixedHello from Alpha" (Alpha.alpha_msg)
let test2 test_ctxt = assert_equal "MixedHello from PPX" (Alpha.ppx_msg)

let suite =
"suite">:::
[
  "test1">:: test1;
  "test2">:: test2;
]

let () =
  run_test_tt_main suite
