//
//  ActionsSlider.m
//  ObLog
//
//  Created by David Alkire on 9/21/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "ActionsSlider.h"

@implementation ActionsSlider

@synthesize toggle;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];/*colorWithRed:(float)0xEE/0xFF 
                                               green:(float)0xEE/0xFF 
                                                blue:(float)0xEE/0xFF 
                                               alpha:1];*/
        toggle = [[ActionButton alloc] initWithFrame:CGRectMake(30, (frame.size.height - 30)/2, 30, 30)];
        UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(10, 0, frame.size.width - 10, frame.size.height)];
        bg.backgroundColor = [UIColor colorWithRed:(float)0xEE/0xFF 
                                             green:(float)0xEE/0xFF 
                                              blue:(float)0xEE/0xFF 
                                             alpha:1];
        [self addSubview:bg];
        [toggle createButtonOfType:@"toggle"];
        [self addSubview:toggle];
    }
    return self;
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
}

@end
