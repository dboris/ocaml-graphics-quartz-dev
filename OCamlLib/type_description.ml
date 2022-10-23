open Ctypes

module Types (F : Ctypes.TYPE) = struct
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

end