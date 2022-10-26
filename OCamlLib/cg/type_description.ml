module Types (F : Ctypes.TYPE) = struct
	open Ctypes
	open F

	module CGPoint = struct
		type point
		let point : point structure typ = structure "CGPoint"
		let x = field point "x" double
		let y = field point "y" double
		let () = seal point
	end

	module CGSize = struct
		type size
		let size : size structure typ = structure "CGSize"
		let width = field size "width" double
		let height = field size "height" double
		let () = seal size
	end

	module CGRect = struct
		type rect
		let rect : rect structure typ = structure "CGRect"
		let origin = field rect "origin" CGPoint.point
		let size = field rect "size" CGSize.size
		let () = seal rect
	end

	module CGContext : sig
		type t
		val t : t typ
	end = struct
		type t = unit ptr
		let t : t typ = typedef (ptr void) "CGContextRef"
	end
end
