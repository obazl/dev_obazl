(* user-supplied main ns module must contain pseudo-recursive equations for all submodules *)

module Red   = Red
module Green = Green
module Blue  = Blue

let alpha = 0.5

let () =
  print_endline ("Hello from user-provided, renamed module Color. Red: "
                 ^ string_of_int Demos_Namespaces_Obazl_Set300_Case357__Red.v)
