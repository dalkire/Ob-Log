//
//  EditCoursesCellContentColorView.m
//  Ob Log
//
//  Created by David Alkire on 11/25/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "EditCoursesCellContentColorView.h"

@implementation EditCoursesCellContentColorView

- (id)initWithColor:(UIColor *)color
{
    self = [super initWithFrame:CGRectMake(14, 10, 24, 24)];
    if (self) {
        [self setBackgroundColor:color];
    }
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touched COLOR");
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
