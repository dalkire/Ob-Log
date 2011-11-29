//
//  ColorPicker.m
//  Ob Log
//
//  Created by David Alkire on 11/28/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "ColorPicker.h"

@implementation ColorPicker

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        int w = frame.size.width;
        int segLen = (float)w/6;
        NSLog(@"SegLen: %d", segLen);
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
