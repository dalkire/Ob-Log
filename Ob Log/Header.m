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
        
        maintitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 20, 400, 40)];
        maintitleLabel.backgroundColor = [UIColor clearColor];
        maintitleLabel.textColor = [UIColor whiteColor];
        maintitleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:36];
        
        subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 20, 400, 40)];
        subtitleLabel.backgroundColor = [UIColor clearColor];
        subtitleLabel.textColor = [UIColor whiteColor];
        subtitleLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
        
        [self addSubview:maintitleLabel];
        [self addSubview:subtitleLabel];
        [self addSubview:dropShadow];
    }
    return self;
}

- (void)setMaintitleLabelText:(NSString *)title
{
    maintitleLabel.text = title;
    [maintitleLabel sizeToFit];
    maintitleLabel.frame = CGRectMake((self.frame.size.width - maintitleLabel.frame.size.width)/2, 
                                 (self.frame.size.height - maintitleLabel.frame.size.height)/2, 
                                 maintitleLabel.frame.size.width, 
                                 maintitleLabel.frame.size.height);
}

- (void)setSubtitleLabelText:(NSString *)title
{
    maintitleLabel.frame = CGRectMake(maintitleLabel.frame.origin.x, 
                                      maintitleLabel.frame.origin.y - 8, 
                                      maintitleLabel.frame.size.width, 
                                      maintitleLabel.frame.size.height);
    subtitleLabel.text = title;
    [subtitleLabel sizeToFit];
    subtitleLabel.frame = CGRectMake((self.frame.size.width - subtitleLabel.frame.size.width)/2, 
                                maintitleLabel.frame.origin.y + maintitleLabel.frame.size.height - 6, 
                                subtitleLabel.frame.size.width, 
                                subtitleLabel.frame.size.height);
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
