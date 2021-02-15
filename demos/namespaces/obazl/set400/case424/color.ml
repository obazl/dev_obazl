(* This file is designated as the 'main' module of an ns library whose
   submodules are exogenous - meaning they are in a different
   namespace. In this case they are renamed (using a custom prefix),
   and they are submodules of an ns library, but we are depending on
   them directly instead of going through the ns library. It follows
   that we must use their qualified names. *)

module Red   = Demo__Red
module Green = Demo__Green
module Blue  = Demo__Blue

let () = print_endline ("Hello from user-supplied module Color.")
