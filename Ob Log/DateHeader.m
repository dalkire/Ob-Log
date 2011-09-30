//
//  DateHeader.m
//  oblog
//
//  Created by David Alkire on 9/20/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "DateHeader.h"
#import "Item.h"

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
        [gradient setFrame:frame];
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
        dateTitle.text = @"Wednesday, 21 September 2011";
        [dateTitle sizeToFit];
        dateTitle.frame = CGRectMake((frame.size.width - dateTitle.frame.size.width)/2, 
                                     (frame.size.height - dateTitle.frame.size.height)/2 - 8, 
                                     dateTitle.frame.size.width, 
                                     dateTitle.frame.size.height);
        
        sectionSubtitle = [[UILabel alloc] initWithFrame:CGRectMake(30, 20, 400, 40)];
        sectionSubtitle.backgroundColor = [UIColor clearColor];
        sectionSubtitle.textColor = [UIColor whiteColor];
        sectionSubtitle.font = [UIFont fontWithName:@"Helvetica" size:18];
        sectionSubtitle.text = @"American History: 1800-1940";
        [sectionSubtitle sizeToFit];
        sectionSubtitle.frame = CGRectMake((frame.size.width - sectionSubtitle.frame.size.width)/2, 
                                           dateTitle.frame.origin.y + dateTitle.frame.size.height, 
                                           sectionSubtitle.frame.size.width, 
                                           sectionSubtitle.frame.size.height);
        [self addSubview:dateTitle];
        [self addSubview:sectionSubtitle];
    }
    return self;
}

- (void)assignDateTitle:(NSDate *)date
{
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [delegate didTouchDateHeader];
}

@end
