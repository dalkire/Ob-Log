//
//  NoteCell.m
//  oblog
//
//  Created by David Alkire on 9/21/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "NoteCell.h"

@implementation NoteCell

@synthesize slider;
@synthesize sliderIsExtended;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        slider = [[ActionsSlider alloc] initWithFrame:CGRectMake(-6, 0, frame.size.width, frame.size.height - 1)];
        [self addSubview:slider];
        sliderIsExtended = YES;
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
