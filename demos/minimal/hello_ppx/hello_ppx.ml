open Core ;;                    (* for Sexp *)

print_endline "Hello from hello_ppx!"

let () =
  Sexp.to_string_hum [%sexp ([3;4;5] : int list)]
  |> print_endline
;;


