(* This file is designated as the 'main' module of an ns library whose
   submodules are exogenous - meaning they are in a different
   namespace. In this case they are not renamed, so pseudo-recursive
   equations will work. *)

module Red   = Red
module Green = Green
module Blue  = Blue

let () = print_endline ("Hello from user-supplied module Color.")
