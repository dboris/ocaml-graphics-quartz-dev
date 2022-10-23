open C.Type
open C.Function

let draw_rect (context : nativeint) =
  let ctx =
    Ctypes.ptr_of_raw_address context
    |> Ctypes.(coerce (ptr void) CGContext.t)
  and origin = CGPoint.{ x = 20.; y = 20.}
  and size = CGSize.{ width = 100.; height = 70. } in
  let rect = CGRect.of_t { origin; size } in
  fill_rect ctx rect

let main () =
  let p = CGPoint.of_t {x = 3.; y = 4.} in
  Printf.eprintf "x=%f\n%!" (CGPoint.to_t p).x;
  Callback.register "draw_rect" draw_rect

let () = main ()