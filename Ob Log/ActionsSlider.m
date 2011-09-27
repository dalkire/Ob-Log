//
//  ActionsSlider.m
//  ObLog
//
//  Created by David Alkire on 9/21/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "ActionsSlider.h"

@implementation ActionsSlider

@synthesize optionsScrollWrapper;
@synthesize toggle;
@synthesize rowId;
@synthesize rowPos;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        toggle = [[[ActionButton alloc] initWithFrame:CGRectMake(10, 0, 50, frame.size.height)] autorelease];
        UIView *bg = [[[UIView alloc] initWithFrame:CGRectMake(10, 0, frame.size.width - 10, frame.size.height)] autorelease];
        bg.backgroundColor = [UIColor colorWithRed:(float)0xEE/0xFF 
                                             green:(float)0xEE/0xFF 
                                              blue:(float)0xEE/0xFF 
                                             alpha:1];
        [self addSubview:bg];
        [toggle createButtonOfType:@"toggle"];
        [self addSubview:toggle];
        NSLog(@"ActionsSlider frame width = %f", frame.size.width);
        optionsScrollWrapper = [[OptionsScrollWrapper alloc] initWithFrame:CGRectMake(60, 
                                                                        0, 
                                                                        frame.size.width - 60, 
                                                                        frame.size.height)];
        [self addSubview:optionsScrollWrapper];
    }
    return self;
}

- (void)loadOptionPickers
{
    for (int i = 0; i < 15; i++) {
        OptionPicker *p = [[OptionPicker alloc] initWithFrame:CGRectMake(0, 
                                                                         0, 
                                                                         100, 
                                                                         self.frame.size.height)];
        [p setPickerHeader:[NSString stringWithFormat:@"attendance %d", i*1000] 
                andOptions:[NSArray arrayWithObjects:[NSString stringWithFormat:@"present %d", i], 
                                                        [NSString stringWithFormat:@"late %d", i],
                                                        [NSString stringWithFormat:@"absent %d", i], 
                                                        nil]];
        [p setRowId:rowId];
        [p setRowPos:i];
        [optionsScrollWrapper.optionsScroll addOptionPicker:p];
    }
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
        self.toggle.hidden = NO;
    }
    else {
        self.toggle.hidden = YES;
    }
}

@end
