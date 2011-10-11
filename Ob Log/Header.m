//
//  Header.m
//  Ob Log
//
//  Created by David Alkire on 10/2/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "Header.h"

@implementation Header

@synthesize maintitleLabel;
@synthesize subtitleLabel;
@synthesize dropShadow;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [Theme getThemeColor];
        
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = CGRectMake(0, 
                                    0, 
                                    self.frame.size.width, 
                                    self.frame.size.height);
        [gradient setColors:[NSArray arrayWithObjects:(id)[UIColor colorWithRed:(float)0xCC/0xFF 
                                                                          green:(float)0xCC/0xFF 
                                                                           blue:(float)0xCC/0xFF 
                                                                          alpha:0.1f].CGColor, 
                             (id)[UIColor colorWithRed:(float)0x99/0xFF 
                                                 green:(float)0x99/0xFF 
                                                  blue:(float)0x99/0xFF 
                                                 alpha:0.1f].CGColor, 
                             nil]];
        gradient.startPoint = CGPointMake(0, 0);
        gradient.endPoint = CGPointMake(0, 1);
        [[self layer] addSublayer:gradient];
        
        dropShadow = [[UIView alloc] initWithFrame:CGRectMake(0, 
                                                              self.frame.size.height, 
                                                              self.frame.size.width, 
                                                              8)];
        
        dropShadow.backgroundColor = [UIColor clearColor];
        [dropShadow setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        
        CAGradientLayer *headerDrop = [CAGradientLayer layer];
        headerDrop.frame = CGRectMake(0, 
                                      0, 
                                      dropShadow.frame.size.width, 
                                      dropShadow.frame.size.height);
        [headerDrop setColors:[NSArray arrayWithObjects:    (id)[UIColor colorWithRed:(float)0x33/0xFF 
                                                                                green:(float)0x33/0xFF 
                                                                                 blue:(float)0x33/0xFF 
                                                                                alpha:0.4f].CGColor, 
                                                            (id)[UIColor colorWithRed:(float)0x33/0xFF 
                                                                                green:(float)0x33/0xFF 
                                                                                 blue:(float)0x33/0xFF 
                                                                                alpha:0.0f].CGColor, 
                                                            nil]];
        headerDrop.startPoint = CGPointMake(0, 0);
        headerDrop.endPoint = CGPointMake(0, 1);
        [headerDrop setNeedsDisplayOnBoundsChange:YES];
        [[dropShadow layer] addSublayer:headerDrop];
        
        self.maintitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 
                                                                   20, 
                                                                   frame.size.width - 40, 
                                                                   40)];
        [self.maintitleLabel setBackgroundColor:[UIColor clearColor]];
        [self.maintitleLabel setTextColor:[UIColor whiteColor]];
        [self.maintitleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:36]];
        [self.maintitleLabel setTextAlignment:UITextAlignmentCenter];
        
        
        self.subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 
                                                                  maintitleLabel.frame.origin.y + maintitleLabel.frame.size.height, 
                                                                  frame.size.width - 40, 20)];
        [self.subtitleLabel setBackgroundColor:[UIColor clearColor]];
        [self.subtitleLabel setTextColor:[UIColor whiteColor]];
        [self.subtitleLabel setFont:[UIFont fontWithName:@"Helvetica" size:18]];
        [self.subtitleLabel setTextAlignment:UITextAlignmentCenter];
        
        [self addSubview:self.maintitleLabel];
        [self addSubview:self.subtitleLabel];
        [self addSubview:self.dropShadow];
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
