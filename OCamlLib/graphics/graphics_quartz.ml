open Core_graphics.C.Type
open Core_graphics.C.Function


(* Graphics Context *)

let current_context_ref : CGContext.t Opaque.t option ref =
  ref None

let current_context () =
  Option.get !current_context_ref

let set_current_context context =
  current_context_ref := Some context

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
  let x = Float.of_int x' and y = Float.of_int y'
  and width = Float.of_int w and height = Float.of_int h in
  CGContext.fill_rect
    (current_context ())
    CGRect.(make ~x ~y ~width ~height |> of_t)

let plot x y =
  fill_rect x y 1 1
