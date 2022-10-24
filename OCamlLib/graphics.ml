open Graphics_quartz


module View = struct
  let draw_rect context dirty_rect_ptr bounds_ptr =
    let ctx = CGContext.t_of_raw_address context
    and dr = CGRect.t_of_raw_address dirty_rect_ptr
    and bounds = CGRect.t_of_raw_address bounds_ptr in

    Printf.eprintf "Dirty rect: x=%f, y=%f, width=%f, height=%f\n%!"
      dr.origin.x dr.origin.y dr.size.width dr.size.height;

    GraphicsContext.set ctx;

    set_color ~alpha:0.2 yellow;
    fill_rect 0. 0. bounds.size.width bounds.size.height;

    set_color foreground;
    set_line_width 2.;
    plot 100. 100.
end

let main () =
  Callback.register "draw_rect" View.draw_rect

let () = main ()
