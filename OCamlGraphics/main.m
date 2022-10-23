//
//  main.m
//  OCamlGraphics
//
//  Created by Boris on 2022-10-21.
//

#import <Cocoa/Cocoa.h>

extern void caml_startup (const char **);

int main(int argc, const char * argv[]) {
    caml_startup(argv);

    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
    }
    return NSApplicationMain(argc, argv);
}
