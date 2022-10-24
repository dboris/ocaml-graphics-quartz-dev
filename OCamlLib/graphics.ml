open Core_graphics.C.Type
open Core_graphics.C.Function

let current_context_ref : CGContext.t Opaque.t option ref =
  ref None

let current_context () =
  Option.get !current_context_ref

(* Colors *)

type color = int

let rgb r g b = (r lsl 16) + (g lsl 8) + b

let set_color ?(alpha = 1.) color =
  let r = (color lsr 16) land 0xFF |> Float.of_int
  and g = (color lsr 8) land 0xFF |> Float.of_int
  and b = color land 0xFF |> Float.of_int
  and ctx = current_context ()
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

(* Drawing *)

let fill_rect x' y' w h =
  if w < 0 || h < 0 then raise (Invalid_argument "fill_rect");
  let origin = CGPoint.{ x = Float.of_int x'; y = Float.of_int y' }
  and size = CGSize.{ width = Float.of_int w; height = Float.of_int h }
  in
  CGContext.fill_rect
    (current_context ())
    (CGRect.of_t { origin; size })

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
    current_context_ref := Some ctx;
    Printf.eprintf "Dirty rect: x=%f, y=%f, width=%f, height=%f\n%!"
      dr.origin.x dr.origin.y dr.size.width dr.size.height;
    set_color ~alpha:0.5 green;
    fill_rect 0 0 (Float.to_int bounds.size.width) (Float.to_int bounds.size.height)
end

let main () =
  Callback.register "draw_rect" View.draw_rect

let () = main ()
