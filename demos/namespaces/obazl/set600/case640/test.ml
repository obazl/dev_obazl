open OUnit2

let test1 test_ctxt = assert_equal 255 (Color.Rgb.Red.v)
let test2 test_ctxt = assert_equal 127 (Color.Rgb.Green.v)
let test3 test_ctxt = assert_equal 80  (Color.Rgb.Blue.v)

let test4 test_ctxt = assert_equal 37 (Color.Cmy.Cyan.v)
let test5 test_ctxt = assert_equal 143 (Color.Cmy.Magenta.v)
let test6 test_ctxt = assert_equal 201  (Color.Cmy.Yellow.v)

let test7 test_ctxt = assert_equal 255 (Color.Red.v)
let test8 test_ctxt = assert_equal 127 (Color.Green.v)
let test9 test_ctxt = assert_equal 80  (Color.Blue.v)

let test10 test_ctxt = assert_equal 131 (Color.Hue.v)
let test11 test_ctxt = assert_equal 132 (Color.Saturation.v)
let test12 test_ctxt = assert_equal 133 (Color.Brightness.v)

let suite =
"suite">:::
[
  "test1">:: test1;
  "test2">:: test2;
  "test3">:: test3;

  "test4">:: test4;
  "test5">:: test5;
  "test6">:: test6;

  "test7">:: test7;
  "test8">:: test8;
  "test9">:: test9;

  "test10">:: test10;
  "test11">:: test11;
  "test12">:: test12;
]

let () =
  run_test_tt_main suite
