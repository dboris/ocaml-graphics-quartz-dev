#include <stdio.h>

#include <caml/mlvalues.h>
#include <caml/callback.h>
#include <caml/alloc.h>

#include "graphics.h"

void draw_rect (CGContextRef ctx)
{
	static const value * closure = NULL;
	if (closure == NULL) closure = caml_named_value("draw_rect");

	// TODO alloc caml cgrect and nativeint to pass to closure
	caml_callback(*closure, caml_copy_nativeint((intnat) ctx));
}
