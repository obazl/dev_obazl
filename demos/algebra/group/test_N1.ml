open OUnit2
open Group

let test1 test_ctxt = assert_equal 3 (mu 1 2)

let suite =
"suite">:::
 ["test1">:: test1]
;;

let () =
  run_test_tt_main suite
;;
