module RGB = Rgb ;;
module CMY = Cmy ;;
(* module HSB = Hsb ;; *)

let alpha = 0.5 ;;

print_endline ("Hello from module Color. RGB.Blue.v: " ^ string_of_int Rgb.Blue.v) ;;
print_endline ("Hello again from module Color. CMY.Magenta.v: " ^ string_of_int Cmy.Magenta.v) ;;
