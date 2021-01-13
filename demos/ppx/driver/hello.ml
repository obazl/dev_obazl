(* the ppx transformer injects code that depends on these two libs. we
   can open them here, or we can use `-open` to open them on the
   command line. *)
open Sexplib      (* needed by ppx_sexp_conv.runtime_lib *)
open Sexplib.Std (* needed by sexp extension op from ppx_sexp_conv *)

type int_pair = (int * int) [@@deriving sexp] ;;

let x = [%sexp_of: (int * string) list] [1,"one"; 2,"two"] |> Sexp.to_string ;;


