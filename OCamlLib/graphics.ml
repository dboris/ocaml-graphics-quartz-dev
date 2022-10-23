open Core_graphics.C.Type
open Core_graphics.C.Function

let current_context : CGContext.t Core_graphics.Opaque.t option ref =
  ref None

(* Colors *)

type color = int

let rgb r g b = (r lsl 16) + (g lsl 8) + b

(* external set_color : color -> unit = "caml_gr_set_color" *)
let set_color ?(alpha = 1.) color =
  let r = (color lsr 16) land 0xFF |> Float.of_int
  and g = (color lsr 8) land 0xFF |> Float.of_int
  and b = color land 0xFF |> Float.of_int
  and ctx = Option.get !current_context
  in
  CGContext.set_rgb_fill_color ctx r g b alpha

let black = 0x000000

and white = 0xFFFFFF

and red = 0xFF0000

and green = 0x00FF00

and blue = 0x0000FF

and yellow = 0xFFFF00

and cyan = 0x00FFFF

and magenta = 0xFF00FF

let background = white

and foreground = black

let cgrect_of_pointer rect_ptr =
  Ctypes.ptr_of_raw_address rect_ptr
  |> Ctypes.(coerce (ptr void) (ptr CGRect.rect))
  |> Ctypes.(!@)
  |> CGRect.to_t

module View = struct
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
    current_context := Some ctx;
    Printf.eprintf "Dirty rect: x=%f, y=%f, width=%f, height=%f\n%!"
      dr.origin.x dr.origin.y dr.size.width dr.size.height;
    set_color red;
    CGContext.fill_rect ctx rect
end

let main () =
  Callback.register "draw_rect" View.draw_rect

let () = main ()
