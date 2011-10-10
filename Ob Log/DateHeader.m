//
//  DateHeader.m
//  oblog
//
//  Created by David Alkire on 9/20/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "DateHeader.h"

@implementation DateHeader

@synthesize delegate;

@synthesize dateTitle;
@synthesize sectionSubtitle;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [Theme getThemeColor];
        
        CAGradientLayer *gradient = [CAGradientLayer layer];
        [gradient setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
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
        
        dateTitle = [[UILabel alloc] initWithFrame:CGRectMake(30, 20, 400, 40)];
        dateTitle.backgroundColor = [UIColor clearColor];
        dateTitle.textColor = [UIColor whiteColor];
        dateTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:36];
        dateTitle.text = @"";
        dateTitle.textAlignment = UITextAlignmentCenter;
        //[dateTitle sizeToFit];
        dateTitle.frame = CGRectMake(20, 
                                     16, 
                                     frame.size.width - 40, 
                                     40);
        
        sectionSubtitle = [[UILabel alloc] initWithFrame:CGRectMake(30, 20, 400, 40)];
        sectionSubtitle.backgroundColor = [UIColor clearColor];
        sectionSubtitle.textColor = [UIColor whiteColor];
        sectionSubtitle.textAlignment = UITextAlignmentCenter;
        sectionSubtitle.font = [UIFont fontWithName:@"Helvetica" size:18];
        sectionSubtitle.text = @"";
        //[sectionSubtitle sizeToFit];
        sectionSubtitle.frame = CGRectMake(20, 
                                           dateTitle.frame.origin.y + dateTitle.frame.size.height, 
                                           frame.size.width - 20, 
                                           20);
        [self addSubview:dateTitle];
        [self addSubview:sectionSubtitle];
    }
    return self;
}

- (void)assignDateTitle:(NSDate *)date
{
    
}

@end
