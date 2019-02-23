//
//  JZScreenSaverView.m
//  DVD
//
//  Created by Justin Fincher on 24/2/2019.
//  Copyright © 2019 ZHENG HAOTIAN. All rights reserved.
//

#import "JZScreenSaverView.h"
#define NSColorFromRGB(rgbValue) \
[NSColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

@interface JZScreenSaverView()

@property (strong,nonatomic) NSImageView *dvdImageView;
@property (strong,nonatomic) NSTimer *boringTimer;
@property (nonatomic) CGPoint speedVector;
@property (strong,nonatomic) NSMutableArray *colorArray;

@end

@implementation JZScreenSaverView

#pragma mark - Init-ers
- (instancetype)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];
    if (self)
    {
        [self playingDVDs];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        [self playingDVDs];
    }
    return self;
}

#pragma mark - Logic
- (void)playingDVDs
{
    if (self.dvdImageView)
    {
        [self.dvdImageView removeFromSuperview];
    }
    if (self.boringTimer)
    {
        [self.boringTimer invalidate];
    }
    self.dvdImageView = [[NSImageView alloc] initWithFrame:NSMakeRect(0, 0, 200, 100)];
    self.dvdImageView.image = [NSImage imageNamed:@"dvd"];
    
    self.colorArray = [NSMutableArray arrayWithObjects:
                       NSColorFromRGB(0xcec403),
                       NSColorFromRGB(0x032cce),
                       NSColorFromRGB(0x03ce4a),
                       NSColorFromRGB(0xce0325),
                       NSColorFromRGB(0x9e9e9e),
                       nil];
    
    self.speedVector = CGPointMake(self.frame.size.width / 100, self.frame.size.height / 100);
    self.boringTimer = [NSTimer scheduledTimerWithTimeInterval: 0.02f
                                                  target: self
                                                selector:@selector(onTick:)
                                                userInfo: nil repeats:YES];
    
    [self addSubview:self.dvdImageView];
}

- (void)onTick:(NSTimer *)timer
{
    CGRect rect = self.dvdImageView.frame;
    self.dvdImageView.frame = CGRectMake(rect.origin.x + self.speedVector.x, rect.origin.y + self.speedVector.y, rect.size.width, rect.size.height);
    
    Boolean shouldChangeColor = false;
    
    if (self.dvdImageView.frame.origin.x < 0 || self.dvdImageView.frame.origin.x + self.dvdImageView.frame.size.width > self.frame.size.width)
    {
        self.speedVector = CGPointMake(- self.speedVector.x, self.speedVector.y);
        shouldChangeColor = YES;
    }
    
    if (self.dvdImageView.frame.origin.y < 0 || self.dvdImageView.frame.origin.y + self.dvdImageView.frame.size.height > self.frame.size.height)
    {
        self.speedVector = CGPointMake(self.speedVector.x, -self.speedVector.y);
        shouldChangeColor = YES;
    }
    
    if (shouldChangeColor)
    {
        NSColor *nextColor = [self.colorArray firstObject];
        self.dvdImageView.contentTintColor = [nextColor copy];
        [self.colorArray removeObjectAtIndex:0];
        [self.colorArray insertObject:nextColor atIndex:self.colorArray.count];
    }
}

#pragma mark - Stuff
- (BOOL)isFlipped
{
    return YES;
}

@end
