(* This file is designated as the 'main' module of an ns library whose
   submodules are exogenous - meaning they are in a different
   namespace. So the aliasing equations must refer to the namespaced
   names. *)

module Red   = Red
module Green = Demos__Green
module Blue  = Blue

let () =
  print_endline ("Hello from user-supplied module Color.")
