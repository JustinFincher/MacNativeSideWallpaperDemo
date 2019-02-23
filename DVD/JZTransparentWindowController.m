//
//  JZTransparentWindowController.m
//  DVD
//
//  Created by Justin Fincher on 24/2/2019.
//  Copyright © 2019 ZHENG HAOTIAN. All rights reserved.
//

#import "JZTransparentWindowController.h"

@interface JZTransparentWindowController ()

@end

@implementation JZTransparentWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    NSWindowStyleMask styleMask = NSWindowStyleMaskBorderless | NSWindowStyleMaskFullSizeContentView | NSWindowStyleMaskUnifiedTitleAndToolbar | NSWindowStyleMaskFullScreen;
    
    [self.window setBackgroundColor:[NSColor clearColor]];
    [self.window setOpaque:NO];
    [self.window setHasShadow:false];
    
    [self.window setStyleMask:styleMask];
    [self.window setCollectionBehavior:
     (NSWindowCollectionBehaviorCanJoinAllSpaces |
      NSWindowCollectionBehaviorStationary |
      NSWindowCollectionBehaviorIgnoresCycle |
      NSWindowCollectionBehaviorFullScreenAuxiliary)];
    [self.window setLevel:kCGDesktopWindowLevel - 1];
    
    NSRect rect = [[NSScreen mainScreen] frame];
    
    [self.window setFrame:rect display:YES];
    
}

- (BOOL)canBecomeMainWindow
{
    return false;
}

- (BOOL)canBecomeKeyWindow
{
    return false;
}
@end
