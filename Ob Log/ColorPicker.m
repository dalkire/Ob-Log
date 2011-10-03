//
//  ColorPicker.m
//  Ob Log
//
//  Created by David Alkire on 10/3/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "ColorPicker.h"

@implementation ColorPicker

@synthesize colorPanel;
@synthesize rSlider;
@synthesize gSlider;
@synthesize bSlider;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        colorPanel = [[UIView alloc] initWithFrame:CGRectMake(0, 
                                                              0, 
                                                              300, 
                                                              50)];
        colorPanel.backgroundColor = [UIColor colorWithRed:(float)26 
                                                      green:(float)108 
                                                       blue:(float)155
                                                      alpha:1];
        
        
        self.rSlider = [[UISlider alloc] initWithFrame:CGRectMake(0, 
                                                                  110, 
                                                                  300, 
                                                                  20)];
        self.gSlider = [[UISlider alloc] initWithFrame:CGRectMake(0, 
                                                                  150, 
                                                                  300, 
                                                                  20)];
        self.bSlider = [[UISlider alloc] initWithFrame:CGRectMake(0, 
                                                                  190, 
                                                                  300, 
                                                                  20)];
        
        [self.rSlider setMaximumValue:255];
        [self.gSlider setMaximumValue:255];
        [self.bSlider setMaximumValue:255];
        
        [self.rSlider setValue:255/2];
        [self.gSlider setValue:255/2];
        [self.bSlider setValue:255/2];
        
        [self addSubview:self.colorPanel];
        [self addSubview:self.rSlider];
        [self addSubview:self.gSlider];
        [self addSubview:self.bSlider];
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
