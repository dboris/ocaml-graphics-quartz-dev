#include <stdio.h>

#include <caml/mlvalues.h>
#include <caml/callback.h>
#include <caml/alloc.h>

#include "graphics.h"

void draw_rect (CGContextRef ctx, CGRect rect)
{
	static const value * closure = NULL;
	if (closure == NULL) closure = caml_named_value("draw_rect");

	caml_callback2(
		*closure,
		caml_copy_nativeint((intnat) ctx),
		caml_copy_nativeint((intnat) &rect)
	);
}
