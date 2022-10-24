#include <stdio.h>

#include <caml/mlvalues.h>
#include <caml/callback.h>
#include <caml/alloc.h>

#include "graphics.h"

// TODO parameterize "draw_rect" cb name

void
draw_rect (CGContextRef ctx, CGRect dirty_rect, CGRect bounds)
{
	static const value * closure = NULL;
	if (closure == NULL) closure = caml_named_value("draw_rect");

	caml_callback3(
		*closure,
		caml_copy_nativeint((intnat) ctx),
		caml_copy_nativeint((intnat) &dirty_rect),
		caml_copy_nativeint((intnat) &bounds)
	);
}
