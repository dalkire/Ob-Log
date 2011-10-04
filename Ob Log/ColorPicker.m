//
//  ColorPicker.m
//  Ob Log
//
//  Created by David Alkire on 10/3/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "ColorPicker.h"

@implementation ColorPicker

@synthesize delegate;

@synthesize rSlider;
@synthesize gSlider;
@synthesize bSlider;

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, 300, 160)];
    if (self) {
        self.rSlider = [[ColorSlider alloc] initWithFrame:CGRectMake(0, 
                                                                     20, 
                                                                     300, 
                                                                     20)];
        self.gSlider = [[ColorSlider alloc] initWithFrame:CGRectMake(0, 
                                                                     70, 
                                                                     300, 
                                                                     20)];
        self.bSlider = [[ColorSlider alloc] initWithFrame:CGRectMake(0, 
                                                                     120, 
                                                                     300, 
                                                                     20)];
        
        [self.rSlider setDelegate:self];
        [self.gSlider setDelegate:self];
        [self.bSlider setDelegate:self];
        
        [self.rSlider setContinuous:NO];
        [self.gSlider setContinuous:NO];
        [self.bSlider setContinuous:NO];
        
        [self.rSlider setMaximumValue:255];
        [self.gSlider setMaximumValue:255];
        [self.bSlider setMaximumValue:255];
        
        [self.rSlider setValue:115];
        [self.gSlider setValue:182];
        [self.bSlider setValue:107];
        
        self.rSlider.colorLabel.text = @"Red";
        self.gSlider.colorLabel.text = @"Green";
        self.bSlider.colorLabel.text = @"Blue";
        self.rSlider.valueLabel.text = [NSString stringWithFormat:@"%d", (int)self.rSlider.value];
        self.gSlider.valueLabel.text = [NSString stringWithFormat:@"%d", (int)self.gSlider.value];
        self.bSlider.valueLabel.text = [NSString stringWithFormat:@"%d", (int)self.bSlider.value];
        
        [self addSubview:self.rSlider];
        [self addSubview:self.gSlider];
        [self addSubview:self.bSlider];
    }
    return self;
}
- (void)movedSlider
{
    self.rSlider.valueLabel.text = [NSString stringWithFormat:@"%d", (int)self.rSlider.value];
    self.gSlider.valueLabel.text = [NSString stringWithFormat:@"%d", (int)self.gSlider.value];
    self.bSlider.valueLabel.text = [NSString stringWithFormat:@"%d", (int)self.bSlider.value];
    [delegate didSelectRed:self.rSlider.value/255.0 green:self.gSlider.value/255.0 blue:self.bSlider.value/255.0];
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
