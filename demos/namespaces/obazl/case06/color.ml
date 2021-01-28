(* user-supplied main ns module must contain pseudo-recursive equations for all submodules *)

module Red   = Red ;;
module Green = Green ;;
module Blue  = Blue ;;

print_endline ("Hello from user-supplied module Color.") ;;
