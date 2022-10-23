open C.Type
open C.Function

let cgrect_of_pointer rect_ptr =
  Ctypes.ptr_of_raw_address rect_ptr
  |> Ctypes.(coerce (ptr void) (ptr CGRect.rect))
  |> Ctypes.(!@)
  |> CGRect.to_t

let draw_rect context dirty_rect_ptr bounds_ptr =
  let ctx =
    Ctypes.ptr_of_raw_address context
    |> Ctypes.(coerce (ptr void) CGContext.t)
  and dr = cgrect_of_pointer dirty_rect_ptr
  and bounds = cgrect_of_pointer bounds_ptr in
  let origin = CGPoint.{ x = 0.; y = 0.}
  and size =
    CGSize.{ width = bounds.size.width; height = bounds.size.height } in
  let rect = CGRect.of_t { origin; size } in
  Printf.eprintf "Dirty rect: x=%f, y=%f, width=%f, height=%f\n%!"
    dr.origin.x dr.origin.y dr.size.width dr.size.height;
  fill_rect ctx rect

let main () =
  Callback.register "draw_rect" draw_rect

let () = main ()
