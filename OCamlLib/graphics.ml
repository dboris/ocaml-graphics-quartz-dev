open C.Type

let main () =
  let p = CGPoint.of_t {x = 3.; y = 4.} in
  Printf.eprintf "x=%f\n%!" (CGPoint.to_t p).x

let () = main ()