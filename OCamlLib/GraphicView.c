//
//  GraphicView.m
//  OCamlGraphics
//
//  Created by Boris on 2022-10-22.
//

#import "GraphicView.h"
#import "graphics.h"

@implementation GraphicView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];

    CGContextRef ctx = [[NSGraphicsContext currentContext] CGContext];
    draw_rect(ctx);
}

@end
