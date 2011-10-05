//
//  ColorTag.m
//  Ob Log
//
//  Created by David Alkire on 10/4/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "ColorTag.h"

@implementation ColorTag

- (id)initWithColor:(UIColor *)color
{
    self = [super initWithFrame:CGRectMake(0, 0, 40, 40)];
    if (self) {
        self.backgroundColor = color;
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
