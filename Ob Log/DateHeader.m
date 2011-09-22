//
//  DateHeader.m
//  oblog
//
//  Created by David Alkire on 9/20/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "DateHeader.h"

@implementation DateHeader

@synthesize dayOfWeek;
@synthesize date;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        dayOfWeek = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 270, 40)];
        date = [[UILabel alloc] initWithFrame:CGRectMake(310, 20, 400, 40)];
        dayOfWeek.backgroundColor = [UIColor clearColor];
        date.backgroundColor = [UIColor clearColor];
        dayOfWeek.textColor = [UIColor whiteColor];
        date.textColor = [UIColor whiteColor];
        dayOfWeek.font = [UIFont fontWithName:@"Helvetica-Bold" size:36];
        date.font = [UIFont fontWithName:@"Helvetica-Bold" size:36];
        dayOfWeek.text = @"Wednesday";
        date.text = @"21 September 2011";
        dayOfWeek.textAlignment = UITextAlignmentRight;
        [self addSubview:dayOfWeek];
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
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = {   (float)0xD3/0xFF, (float)0x1C/0xFF, (float)0x0C/0xFF, 1.0f,
                                (float)0xA3/0xFF, (float)0x0F/0xFF, (float)0x05/0xFF, 1.0f };
    myColorspace = CGColorSpaceCreateDeviceRGB();
    myGradient = CGGradientCreateWithColorComponents(myColorspace, components, locations, num_locations);
    
    CGPoint myStartPoint, myEndPoint;
    myStartPoint.x = 0.0;
    myStartPoint.y = 0.0;
    myEndPoint.x = 0.0;
    myEndPoint.y = self.frame.size.height - 7;
    CGContextDrawLinearGradient (UIGraphicsGetCurrentContext(), myGradient, myStartPoint, myEndPoint, 0);
    
    CGFloat locations2[2] = { 0.0, 1.0 };
    CGFloat components2[8] = {  (float)0x33/0xFF, (float)0x33/0xFF, (float)0x33/0xFF, 0.8f,
                                (float)0xFF/0xFF, (float)0xFF/0xFF, (float)0xFF/0xFF, 0.0f };
    myColorspace = CGColorSpaceCreateDeviceRGB();
    myGradient = CGGradientCreateWithColorComponents(myColorspace, components2, locations2, num_locations);
    
    myStartPoint.x = 0.0;
    myStartPoint.y = self.frame.size.height - 7;
    myEndPoint.x = 0.0;
    myEndPoint.y = self.frame.size.height;
    CGContextDrawLinearGradient (UIGraphicsGetCurrentContext(), myGradient, myStartPoint, myEndPoint, 0);
}

@end
