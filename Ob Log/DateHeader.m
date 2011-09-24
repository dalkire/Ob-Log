//
//  DateHeader.m
//  oblog
//
//  Created by David Alkire on 9/20/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "DateHeader.h"

@implementation DateHeader

@synthesize date;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        date = [[[UILabel alloc] initWithFrame:CGRectMake(30, 20, 400, 40)] autorelease];
        NSLog(@"width: %f", date.frame.size.width);
        date.backgroundColor = [UIColor clearColor];
        date.textColor = [UIColor whiteColor];
        date.font = [UIFont fontWithName:@"Helvetica-Bold" size:36];
        date.text = @"Wednesday, 21 September 2011";
        [date sizeToFit];
        NSLog(@"width: %f", date.frame.size.width);
        date.frame = CGRectMake((frame.size.width - date.frame.size.width)/2, 
                                (frame.size.height - date.frame.size.height)/2, 
                                date.frame.size.width, 
                                date.frame.size.height);
        
        [self addSubview:date];
    }
    return self;
}

- (void)assignDate:(NSDate *)date
{
    
}

- (void)drawRect:(CGRect)rect
{
    CGGradientRef myGradient;
    CGColorSpaceRef myColorspace;
    size_t num_locations = 2;
    
    CGFloat locations2[2] = { 0.0, 1.0 };
    CGFloat components2[8] = {  (float)0x33/0xFF, (float)0x33/0xFF, (float)0x33/0xFF, 0.6f,
                                (float)0x33/0xFF, (float)0x33/0xFF, (float)0x33/0xFF, 0.0f };
    myColorspace = CGColorSpaceCreateDeviceRGB();
    myGradient = CGGradientCreateWithColorComponents(myColorspace, components2, locations2, num_locations);
    
    CGPoint myStartPoint, myEndPoint;
    myStartPoint.x = 0.0;
    myStartPoint.y = self.frame.size.height - 7;
    myEndPoint.x = 0.0;
    myEndPoint.y = self.frame.size.height;
    CGContextDrawLinearGradient (UIGraphicsGetCurrentContext(), myGradient, myStartPoint, myEndPoint, 0);
    CGColorSpaceRelease(myColorspace);
    CGGradientRelease(myGradient);
    
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = {   (float)0x04/0xFF, (float)0x81/0xFF, (float)0xF2/0xFF, 1.0f,
        (float)0x02/0xFF, (float)0x69/0xFF, (float)0xEA/0xFF, 1.0f };
    
    
    CGGradientRef myGradient2;
    CGColorSpaceRef myColorspace2;
    myColorspace2 = CGColorSpaceCreateDeviceRGB();
    myGradient2 = CGGradientCreateWithColorComponents(myColorspace2, components, locations, num_locations);
    
    myStartPoint.x = 0.0;
    myStartPoint.y = 0.0;
    myEndPoint.x = 0.0;
    myEndPoint.y = self.frame.size.height - 7;
    CGContextDrawLinearGradient (UIGraphicsGetCurrentContext(), myGradient2, myStartPoint, myEndPoint, 0);
    CGColorSpaceRelease(myColorspace2);
    CGGradientRelease(myGradient2);
}

@end
