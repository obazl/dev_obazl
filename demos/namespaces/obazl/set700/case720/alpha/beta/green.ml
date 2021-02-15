let v = 127

let () =
  print_endline ("Hello from module Green. Blue: "
                 ^ string_of_int Blue.v) ;
  print_endline ("Hello again from module Green. Gamma.Red: "
                 ^ string_of_int Gamma.Red.v)
