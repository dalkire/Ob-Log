//
//  OptionsScroll.m
//  Ob Log
//
//  Created by David Alkire on 9/22/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "OptionsScroll.h"

@implementation OptionsScroll

@synthesize scrollView;
@synthesize leftShadow;
@synthesize rightShadow;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        scrollView = [[UIScrollView alloc] initWithFrame:frame];
        scrollView.contentSize = CGSizeMake(3000, frame.size.height);
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:scrollView];
        leftShadow = [[UIView alloc] initWithFrame:CGRectMake(0, 
                                                              0, 
                                                              8, 
                                                              frame.size.height)];
        
        rightShadow = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width - 8, 
                                                              0, 
                                                              8, 
                                                              frame.size.height)];
        
        CAGradientLayer * gradient = [CAGradientLayer layer];
        [gradient setFrame:leftShadow.frame];
        [gradient setColors:[NSArray arrayWithObjects:(id)[UIColor colorWithRed:(float)0x88/0xFF 
                                                                          green:(float)0x88/0xFF 
                                                                           blue:(float)0x88/0xFF 
                                                                          alpha:0.6f].CGColor, 
                                                        (id)[UIColor colorWithRed:(float)0xFF/0xFF 
                                                                            green:(float)0xFF/0xFF 
                                                                             blue:(float)0xFF/0xFF 
                                                                            alpha:0.0f].CGColor, 
                                                        nil]];
        gradient.startPoint = CGPointMake(0, 0);
        gradient.endPoint = CGPointMake(1, 0);
        [[leftShadow layer] addSublayer:gradient];
        
        gradient.startPoint = CGPointMake(1, 0);
        gradient.endPoint = CGPointMake(0, 0);
        [[rightShadow layer] addSublayer:gradient];
        
        [self addSubview:leftShadow];
    }
    return self;
}

- (void)addOptionPicker:(OptionPicker *)picker
{
    
}

- (void)drawRect:(CGRect)rect
{
    /*CGGradientRef myGradient;
    CGColorSpaceRef myColorspace;
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = {   (float)0x88/0xFF, (float)0x88/0xFF, (float)0x88/0xFF, 0.6f,
                                (float)0xFF/0xFF, (float)0xFF/0xFF, (float)0xFF/0xFF, 0.0f };
    myColorspace = CGColorSpaceCreateDeviceRGB();
    myGradient = CGGradientCreateWithColorComponents(myColorspace, components, locations, num_locations);
    
    CGPoint myStartPoint, myEndPoint;
    myStartPoint.x = 0;
    myStartPoint.y = 0;
    myEndPoint.x = 8;
    myEndPoint.y = 0;
    CGContextDrawLinearGradient (UIGraphicsGetCurrentContext(), myGradient, myStartPoint, myEndPoint, 0);*/
}

@end
