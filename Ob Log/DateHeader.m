//
//  DateHeader.m
//  oblog
//
//  Created by David Alkire on 9/20/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "DateHeader.h"

@implementation DateHeader

@synthesize dateTitle;
@synthesize sectionSubtitle;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [Theme getThemeColor];
        
        CAGradientLayer *gradient = [CAGradientLayer layer];
        [gradient setFrame:frame];
        [gradient setColors:[NSArray arrayWithObjects:(id)[UIColor colorWithRed:(float)0xCC/0xFF 
                                                                          green:(float)0xCC/0xFF 
                                                                           blue:(float)0xCC/0xFF 
                                                                          alpha:0.1f].CGColor, 
                             (id)[UIColor colorWithRed:(float)0x99/0xFF 
                                                 green:(float)0x99/0xFF 
                                                  blue:(float)0x99/0xFF 
                                                 alpha:0.1f].CGColor, 
                             nil]];
        gradient.startPoint = CGPointMake(0, 0);
        gradient.endPoint = CGPointMake(0, 1);
        [[self layer] addSublayer:gradient];
        
        dateTitle = [[[UILabel alloc] initWithFrame:CGRectMake(30, 20, 400, 40)] autorelease];
        dateTitle.backgroundColor = [UIColor clearColor];
        dateTitle.textColor = [UIColor whiteColor];
        dateTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:36];
        dateTitle.text = @"Wednesday, 21 September 2011";
        [dateTitle sizeToFit];
        dateTitle.frame = CGRectMake((frame.size.width - dateTitle.frame.size.width)/2, 
                                     (frame.size.height - dateTitle.frame.size.height)/2 - 8, 
                                     dateTitle.frame.size.width, 
                                     dateTitle.frame.size.height);
        
        sectionSubtitle = [[[UILabel alloc] initWithFrame:CGRectMake(30, 20, 400, 40)] autorelease];
        sectionSubtitle.backgroundColor = [UIColor clearColor];
        sectionSubtitle.textColor = [UIColor whiteColor];
        sectionSubtitle.font = [UIFont fontWithName:@"Helvetica" size:18];
        sectionSubtitle.text = @"American History: 1800-1940";
        [sectionSubtitle sizeToFit];
        sectionSubtitle.frame = CGRectMake((frame.size.width - sectionSubtitle.frame.size.width)/2, 
                                           dateTitle.frame.origin.y + dateTitle.frame.size.height, 
                                           sectionSubtitle.frame.size.width, 
                                           sectionSubtitle.frame.size.height);
        [self addSubview:dateTitle];
        [self addSubview:sectionSubtitle];
    }
    return self;
}

- (void)assignDateTitle:(NSDate *)date
{
    
}

/*- (void)drawRect:(CGRect)rect
{
    CGGradientRef myGradient;
    CGColorSpaceRef myColorspace;
    size_t num_locations = 2;
    
    CGFloat locations2[2] = { 0.0, 1.0 };
    CGFloat components2[8] = {  (float)0xFF/0xFF, (float)0xFF/0xFF, (float)0xFF/0xFF, 0.2f,
                                (float)0x33/0xFF, (float)0x33/0xFF, (float)0x33/0xFF, 0.2f };
    myColorspace = CGColorSpaceCreateDeviceRGB();
    myGradient = CGGradientCreateWithColorComponents(myColorspace, components2, locations2, num_locations);
    
    CGPoint myStartPoint, myEndPoint;
    myStartPoint.x = 0.0;
    myStartPoint.y = 0;
    myEndPoint.x = 0.0;
    myEndPoint.y = self.frame.size.height;
    CGContextDrawLinearGradient (UIGraphicsGetCurrentContext(), myGradient, myStartPoint, myEndPoint, 0);
    CGColorSpaceRelease(myColorspace);
    CGGradientRelease(myGradient);
}*/

@end
