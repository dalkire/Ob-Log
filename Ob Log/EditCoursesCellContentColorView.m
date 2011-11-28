//
//  EditCoursesCellContentColorView.m
//  Ob Log
//
//  Created by David Alkire on 11/25/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "EditCoursesCellContentColorView.h"

@implementation EditCoursesCellContentColorView

- (id)initWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
    self = [super initWithFrame:CGRectMake(0, 0, 20, 20)];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithRed:red green:green blue:blue alpha:alpha]];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
