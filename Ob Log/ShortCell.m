//
//  ShortCell.m
//  oblog
//
//  Created by David Alkire on 9/20/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "ShortCell.h"

@implementation ShortCell

@synthesize controller;
@synthesize name;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        name = [[UILabel alloc] initWithFrame:CGRectMake(20, 
                                                          5, 
                                                          frame.size.width - 40, 
                                                          frame.size.height - 10)];
        name.backgroundColor = [UIColor clearColor];
        name.font = [UIFont fontWithName:@"Helvetica" size:28];
        
        [self addSubview:name];
    }
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //NSLog(@"%@", self.superview.superview);
    if (self.controller && [self.controller respondsToSelector:@selector(initModalForUser:andDate:)]) {
        NSLog(@"RESPONDS TO SELECTOR");
        [(ViewController *)self.controller initModalForUser:12234 andDate:[NSDate date]];
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 3.0);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:(float)0xFF/0xFF 
                                                              green:(float)0xA0/0xFF 
                                                               blue:(float)0xC8/0xFF 
                                                              alpha:1.0f].CGColor);
    CGContextMoveToPoint(context, self.frame.size.width - 1, 0);
    CGContextAddLineToPoint(context, self.frame.size.width - 1, self.frame.size.height);
    CGContextStrokePath(context);
}

@end
