let v = 127 ;;

(* Here we refer to 'Blue'; in test.ml we refer to 'Grue__Blue' instead. *)
print_endline ("Hello from module Green. Blue: " ^ string_of_int Blue.v) ;;
