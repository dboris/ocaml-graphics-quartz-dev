open C.Type
open C.Function

let draw_rect (context : CGContext.t Opaque.t) =
  Printf.eprintf "DRAW\n%!";
  let origin = CGPoint.{ x = 0.; y = 20.}
  and size = CGSize.{ width = 40.; height = 30. } in
  let rect = CGRect.of_t { origin; size } in
  fill_rect context rect

let main () =
  let p = CGPoint.of_t {x = 3.; y = 4.} in
  Printf.eprintf "x=%f\n%!" (CGPoint.to_t p).x;
  Callback.register "draw_rect" draw_rect

let () = main ()