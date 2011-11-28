//
//  EditCoursesCellContentView.m
//  Ob Log
//
//  Created by David Alkire on 11/25/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "EditCoursesCellContentView.h"

@implementation EditCoursesCellContentView

@synthesize course = _course;
@synthesize colorSquare = _colorSquare;
@synthesize titleField = _titleField;

- (id)initWithCourse:(Course *)crse
{
    self = [super initWithFrame:CGRectMake(0, 
                                           0, 
                                           300, 
                                           43)];
    if (self) {
        UIColor *color = ([crse colorR] && [crse colorG] && [crse colorB]) ? [UIColor colorWithRed:[[crse colorR] floatValue]/255.0 
                                                                                             green:[[crse colorG] floatValue]/255.0 
                                                                                              blue:[[crse colorB] floatValue]/255.0 
                                                                                             alpha:1.0] 
                                                                            : [Theme getThemeColor];
        
        _colorSquare = [[EditCoursesCellContentColorView alloc] initWithColor:color];
        [self addSubview:_colorSquare];
        
        _titleField = [[UITextField alloc] initWithFrame:CGRectMake(50, 
                                                                    11, 
                                                                    200, 
                                                                    30)];
        [_titleField setFont:[UIFont boldSystemFontOfSize:17]];
        [_titleField setText:[crse courseTitle]];
        [_titleField setPlaceholder:[crse courseTitle]];
        [self addSubview:_titleField];
        [self setUserInteractionEnabled:NO];
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
