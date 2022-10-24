open Ctypes

module Types (F : Ctypes.TYPE) = struct
	module Opaque = Opaque

	module CGPoint = struct
		type point
		let point : point structure typ = structure "CGPoint"
		let x = field point "x" double
		let y = field point "y" double
		let () = seal point

		type t = { x : float; y : float }

		let of_t t =
			let p = make point in
			setf p x t.x;
			setf p y t.y;
			p

		let to_t p =
			let x = getf p x and y = getf p y in
			{ x; y }

		let t = view ~read:to_t ~write:of_t point
	end

	module CGSize = struct
		type size
		let size : size structure typ = structure "CGSize"
		let width = field size "width" double
		let height = field size "height" double
		let () = seal size

		type t = { width : float; height : float }

		let of_t t =
			let s = make size in
			setf s width t.width;
			setf s height t.height;
			s

		let to_t s =
			let width = getf s width and height = getf s height in
			{ width; height }

		let t = view ~read:to_t ~write:of_t size
	end

	module CGRect = struct
		type rect
		let rect : rect structure typ = structure "CGRect"
		let origin = field rect "origin" CGPoint.point
		let size = field rect "size" CGSize.size
		let () = seal rect

		type t = { origin : CGPoint.t; size : CGSize.t }

		let of_t t =
			let r = make rect in
			setf r origin (CGPoint.of_t t.origin);
			setf r size (CGSize.of_t t.size);
			r

		let to_t r =
			let origin = CGPoint.to_t (getf r origin)
			and size = CGSize.to_t (getf r size) in
			{ origin; size }

		let t = view ~read:to_t ~write:of_t rect

		let t_of_raw_address addr =
			ptr_of_raw_address addr
			|> coerce (ptr void) (ptr rect)
			|> (!@)
			|> to_t

		(* ! Shaddows Ctypes.make ! *)
		let make ~x:x' ~y:y' ~width:width' ~height:height' =
			{ origin = CGPoint.{ x = x'; y = y' }
			; size = CGSize.{ width = width'; height = height' }
			} |> of_t
	end

	module CGContext = struct
		type t

		let t : t Opaque.t typ = typedef Opaque.t "CGContextRef"

		let t_of_raw_address addr =
			coerce (ptr void) t (ptr_of_raw_address addr)
	end

end