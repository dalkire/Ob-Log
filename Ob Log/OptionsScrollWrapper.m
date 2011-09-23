//
//  OptionsScrollWrapper.m
//  Ob Log
//
//  Created by David Alkire on 9/22/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "OptionsScrollWrapper.h"

@implementation OptionsScrollWrapper

@synthesize optionsScroll;
@synthesize leftShadow;
@synthesize rightShadow;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        optionsScroll = [[OptionsScroll alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        optionsScroll.contentSize = CGSizeMake(700, frame.size.height);
        
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:optionsScroll];
        
        leftShadow = [[UIView alloc] initWithFrame:CGRectMake(0, 
                                                              0, 
                                                              8, 
                                                              frame.size.height)];
        
        rightShadow = [[UIView alloc] initWithFrame:CGRectMake(200, 
                                                               0, 
                                                               8, 
                                                               frame.size.height)];
        
        CAGradientLayer *gradientL = [CAGradientLayer layer];
        [gradientL setFrame:[leftShadow frame]];
        [gradientL setColors:[NSArray arrayWithObjects:(id)[UIColor colorWithRed:(float)0x33/0xFF 
                                                                          green:(float)0x33/0xFF 
                                                                           blue:(float)0x33/0xFF 
                                                                          alpha:0.4f].CGColor, 
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
                                                                           alpha:0.4f].CGColor, 
                              (id)[UIColor colorWithRed:(float)0x33/0xFF 
                                                  green:(float)0x33/0xFF 
                                                   blue:(float)0x33/0xFF 
                                                  alpha:0.0f].CGColor, 
                              nil]];
        [gradientR setFrame:[rightShadow frame]];
        gradientR.startPoint = CGPointMake(1, 0);
        gradientR.endPoint = CGPointMake(0, 0);
        [[rightShadow layer] addSublayer:gradientR];
        rightShadow.backgroundColor = [UIColor clearColor];
        
        //leftShadow.hidden = YES;
        //rightShadow.hidden = YES;
        
        [self addSubview:leftShadow];
        [self addSubview:rightShadow];
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
