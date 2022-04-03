(* goal: transform sig B by renaming type *)

type u
val msg: u

(* B is an ordinary module - not a "module type" *)
(* so 'include B' will not work, but this will: *)
include (module type of B) with type t := u

