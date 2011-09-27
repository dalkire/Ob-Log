//
//  Row.m
//  Ob Log
//
//  Created by David Alkire on 9/25/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "Row.h"

@implementation Row

@synthesize id;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:(float)0xEE/0xFF 
                                               green:(float)0xEE/0xFF 
                                                blue:(float)0xEE/0xFF 
                                               alpha:1];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context1 = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context1, 2.0);
    CGContextSetStrokeColorWithColor(context1, [UIColor colorWithRed:(float)0x77/0xFF 
                                                               green:(float)0x9D/0xFF 
                                                                blue:(float)0xE8/0xFF 
                                                               alpha:1.0f].CGColor);
    CGContextMoveToPoint(context1, 0, self.frame.size.height);
    CGContextAddLineToPoint(context1, self.frame.size.width, self.frame.size.height);
    CGContextStrokePath(context1);
    
    CGContextRef context2 = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context2, 3.0);
    CGContextSetStrokeColorWithColor(context2, [UIColor colorWithRed:(float)0xFF/0xFF 
                                                              green:(float)0xA0/0xFF 
                                                               blue:(float)0xC8/0xFF 
                                                              alpha:1.0f].CGColor);
    CGContextMoveToPoint(context2, 300, 0);
    CGContextAddLineToPoint(context2, 300, self.frame.size.height);
    CGContextStrokePath(context2);
    
    [super drawRect:rect];
}

@end
