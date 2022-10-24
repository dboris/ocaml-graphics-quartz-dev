open Graphics_quartz


module View = struct
  let draw_rect context dirty_rect_ptr bounds_ptr =
    let ctx = cgcontext_of_raw_address context
    and dr = cgrect_of_raw_address dirty_rect_ptr
    and bounds = cgrect_of_raw_address bounds_ptr in

    Printf.eprintf "Dirty rect: x=%f, y=%f, width=%f, height=%f\n%!"
      dr.origin.x dr.origin.y dr.size.width dr.size.height;

    set_current_context ctx;
    set_color ~alpha:0.5 blue;

    fill_rect 0 0
      (Float.to_int bounds.size.width)
      (Float.to_int bounds.size.height)
end

let main () =
  Callback.register "draw_rect" View.draw_rect

let () = main ()
