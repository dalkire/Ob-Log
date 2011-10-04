//
//  ColorSlider.m
//  Ob Log
//
//  Created by David Alkire on 10/3/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "ColorSlider.h"

@implementation ColorSlider

@synthesize delegate;
@synthesize colorLabel;
@synthesize valueLabel;

-(id)initWithFrame:(CGRect)frame
{
    [super initWithFrame:frame];
    if (self) {
        colorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -16, 100, 16)];
        [colorLabel setTextAlignment:UITextAlignmentLeft];
        colorLabel.backgroundColor = [UIColor clearColor];
        valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width - 100, -16, 100, 16)];
        [valueLabel setTextAlignment:UITextAlignmentRight];
        valueLabel.backgroundColor = [UIColor clearColor];
        
        [self addSubview:colorLabel];
        [self addSubview:valueLabel];
    }
    return self;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    [delegate movedSlider];
}

@end
