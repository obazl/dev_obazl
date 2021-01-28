(* NB: we do not actually use Core, we just open it for demo purposes:
   running `ocamldep` on this file will list it as a dependency. *)
open Core ;;

print_endline "Hello from Main!" ;;

Easy.hello() ;;

Simple.hello() ;;
