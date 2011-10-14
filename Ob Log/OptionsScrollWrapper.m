//
//  OptionsScrollWrapper.m
//  Ob Log
//
//  Created by David Alkire on 9/22/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "OptionsScrollWrapper.h"

@implementation OptionsScrollWrapper

@synthesize dailyEditRow;

@synthesize optionsScroll = _optionsScroll;
@synthesize leftShadow;
@synthesize rightShadow;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:(float)0xBB/0xFF 
                                               green:(float)0xBB/0xFF 
                                                blue:(float)0xBB/0xFF 
                                               alpha:1];
        
        leftShadow = [[UIView alloc] initWithFrame:CGRectMake(0, 
                                                              0, 
                                                              8, 
                                                              frame.size.height)];
        
        rightShadow = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width - 8, 
                                                               0, 
                                                               8, 
                                                               frame.size.height)];
        
        CAGradientLayer *gradientL = [CAGradientLayer layer];
        gradientL.frame = CGRectMake(
                                     0, 
                                     0, 
                                     leftShadow.frame.size.width, 
                                     leftShadow.frame.size.height);
        [gradientL setColors:[NSArray arrayWithObjects:(id)[UIColor colorWithRed:(float)0x33/0xFF 
                                                                          green:(float)0x33/0xFF 
                                                                           blue:(float)0x33/0xFF 
                                                                          alpha:0.2f].CGColor, 
                             (id)[UIColor colorWithRed:(float)0x33/0xFF 
                                                 green:(float)0x33/0xFF 
                                                  blue:(float)0x33/0xFF 
                                                 alpha:0.0f].CGColor, 
                             nil]];
        gradientL.startPoint = CGPointMake(0, 0);
        gradientL.endPoint = CGPointMake(1, 0);
        [[leftShadow layer] addSublayer:gradientL];
        leftShadow.backgroundColor = [UIColor clearColor];
        
        CAGradientLayer *gradientR = [CAGradientLayer layer];
        [gradientR setColors:[NSArray arrayWithObjects:(id)[UIColor colorWithRed:(float)0x33/0xFF 
                                                                           green:(float)0x33/0xFF 
                                                                            blue:(float)0x33/0xFF 
                                                                           alpha:0.2f].CGColor, 
                              (id)[UIColor colorWithRed:(float)0x33/0xFF 
                                                  green:(float)0x33/0xFF 
                                                   blue:(float)0x33/0xFF 
                                                  alpha:0.0f].CGColor, 
                              nil]];
        gradientR.frame = CGRectMake(
                                     0, 
                                     0, 
                                     rightShadow.frame.size.width, 
                                     rightShadow.frame.size.height);
        gradientR.startPoint = CGPointMake(1, 0);
        gradientR.endPoint = CGPointMake(0, 0);
        [[rightShadow layer] addSublayer:gradientR];
        rightShadow.backgroundColor = [UIColor clearColor];
        
        _optionsScroll = [[OptionsScroll alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:_optionsScroll];
        
        [self addSubview:leftShadow];
        [self addSubview:rightShadow];
    }
    return self;
}

- (void)propagateDailyEditRow:(__weak id)der
{
    [self setDailyEditRow:der];
    [_optionsScroll propagateDailyEditRow:der];
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
