include Core_graphics

(* Graphics Context *)

module GraphicsContext = struct
  type t =
    { cg_context : CGContext.t option
    ; line_width : float
    }

  let current_context_ref : t ref =
    ref { cg_context = None; line_width = 1. }

  let get () =
    Option.get !current_context_ref.cg_context

  let set context =
    current_context_ref :=
      { !current_context_ref with cg_context = Some context }

  let line_width () =
    !current_context_ref.line_width
end

(* Colors *)

type color = int

let rgb r g b = (r lsl 16) + (g lsl 8) + b

let set_color ?(alpha = 1.) color =
  let r = (color lsr 16) land 0xFF |> Float.of_int
  and g = (color lsr 8) land 0xFF |> Float.of_int
  and b = color land 0xFF |> Float.of_int
  and ctx = GraphicsContext.get ()
  in
  CGContext.set_rgb_fill_color ctx r g b alpha;
  CGContext.set_rgb_stroke_color ctx r g b alpha

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

let fill_rect x y width height =
  CGContext.fill_rect
    (GraphicsContext.get ())
    CGRect.(make ~x ~y ~width ~height)

let plot x y =
  let width = GraphicsContext.line_width () in
  fill_rect x y width width

let moveto x y =
  CGContext.move_to_point (GraphicsContext.get ()) x y

let set_line_width w =
  CGContext.set_line_width (GraphicsContext.get ()) w
