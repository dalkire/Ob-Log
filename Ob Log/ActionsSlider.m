//
//  ActionsSlider.m
//  ObLog
//
//  Created by David Alkire on 9/21/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "ActionsSlider.h"

@implementation ActionsSlider

@synthesize actionButton;
@synthesize optionsScrollWrapper;
@synthesize optionsScroll;
@synthesize optionPickers;

@synthesize rowId;
@synthesize rowPos;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(10, 0, frame.size.width - 10, frame.size.height)];
        bg.backgroundColor = [UIColor colorWithRed:(float)0xEE/0xFF 
                                             green:(float)0xEE/0xFF 
                                              blue:(float)0xEE/0xFF 
                                             alpha:1];
        [self addSubview:bg];
        
        actionButton = [self createActionButton];
        [self addSubview:actionButton];
        
        optionsScrollWrapper = [self createOptionsScrollWrapper];
        [self addSubview:optionsScrollWrapper];
    }
    return self;
}

- (ActionButton *)createActionButton
{
    ActionButton *ab = [[ActionButton alloc] initWithFrame:CGRectMake(10, 0, 50, self.frame.size.height)];
    [ab createButtonOfType:@"toggle"];
    
    return ab;
}

- (OptionsScrollWrapper *)createOptionsScrollWrapper
{
    OptionsScrollWrapper *osw = [[OptionsScrollWrapper alloc] initWithFrame:CGRectMake(60, 
                                                                                       0, 
                                                                                       self.frame.size.width - 60, 
                                                                                       self.frame.size.height)];
    return osw;
}

- (void)drawRect:(CGRect)rect
{
    CGGradientRef myGradient;
    CGColorSpaceRef myColorspace;
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = {   (float)0x88/0xFF, (float)0x88/0xFF, (float)0x88/0xFF, 0.6f,
                                (float)0xFF/0xFF, (float)0xFF/0xFF, (float)0xFF/0xFF, 0.0f };
    myColorspace = CGColorSpaceCreateDeviceRGB();
    myGradient = CGGradientCreateWithColorComponents(myColorspace, components, locations, num_locations);
    
    CGPoint myStartPoint, myEndPoint;
    myStartPoint.x = 10;
    myStartPoint.y = 0;
    myEndPoint.x = 0;
    myEndPoint.y = 0;
    CGContextDrawLinearGradient (UIGraphicsGetCurrentContext(), myGradient, myStartPoint, myEndPoint, 0);
    CGGradientRelease(myGradient);
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"WILL ROTATE");
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        self.actionButton.hidden = NO;
    }
    else {
        self.actionButton.hidden = YES;
    }
}

@end
