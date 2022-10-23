//
//  GraphicView.m
//  OCamlGraphics
//
//  Created by Boris on 2022-10-22.
//

#import "GraphicView.h"
#import "graphics.h"

@implementation GraphicView

- (void)drawRect:(NSRect)dirty_rect {
    [super drawRect:dirty_rect];

    CGContextRef ctx = [[NSGraphicsContext currentContext] CGContext];
    draw_rect(ctx, dirty_rect, self.bounds);
}

@end
