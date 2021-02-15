(* user-supplied main ns module must contain aliasing equations for all submodules *)

module Red   = Demo__Red
module Green = Demo__Green
module Blue  = Demo__Blue

module Grue  = Demos_Namespaces_Obazl_Set500_Case520__Grue

let () = print_endline ("Hello from user-supplied module Color.")
