open C.Type
open C.Function

let draw_rect (context : nativeint) (rect_ptr : nativeint) =
  let ctx =
    Ctypes.ptr_of_raw_address context
    |> Ctypes.(coerce (ptr void) CGContext.t)
  and dr =
    Ctypes.ptr_of_raw_address rect_ptr
    |> Ctypes.(coerce (ptr void) (ptr CGRect.rect))
    |> Ctypes.(!@)
    |> CGRect.to_t
  and origin = CGPoint.{ x = 20.; y = 20.}
  and size = CGSize.{ width = 100.; height = 70. } in
  let rect = CGRect.of_t { origin; size } in
  Printf.eprintf "Dirty rect: x=%f, y=%f, width=%f, height=%f\n%!"
    dr.origin.x dr.origin.y dr.size.width dr.size.height;
  fill_rect ctx rect

let main () =
  Callback.register "draw_rect" draw_rect

let () = main ()
