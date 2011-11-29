//
//  EditCoursesCellContentView.m
//  Ob Log
//
//  Created by David Alkire on 11/25/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "EditCoursesCellContentView.h"

@implementation EditCoursesCellContentView

@synthesize delegate = _delegate;
@synthesize course = _course;
@synthesize colorSquare = _colorSquare;
@synthesize titleField = _titleField;
@synthesize colorPicker = _colorPicker;
@synthesize closeBtn = _closeBtn;

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
        [_colorSquare setDelegate:self];
        
        [self addSubview:_colorSquare];
        
        _titleField = [[UITextField alloc] initWithFrame:CGRectMake(50, 
                                                                    11, 
                                                                    200, 
                                                                    30)];
        [_titleField setFont:[UIFont boldSystemFontOfSize:17]];
        [_titleField setText:[crse courseTitle]];
        [_titleField setPlaceholder:[crse courseTitle]];
        [self addSubview:_titleField];
        
        _colorPicker = [[ColorPicker alloc] initWithFrame:CGRectMake(47, 
                                                                     10, 
                                                                     186, 
                                                                     24)];
        [_colorPicker setDelegate:self];
        [_colorPicker setHidden:YES];
        [self addSubview:_colorPicker];
        
        _closeBtn = [[CloseBtn alloc] init];
        [_closeBtn setFrame:CGRectMake(240, 12, _closeBtn.frame.size.width, _closeBtn.frame.size.height)];
        [_closeBtn setDelegate:self];
        [_closeBtn setHidden:YES];
        [self addSubview:_closeBtn];
        
        [self setUserInteractionEnabled:NO];
    }
    return self;
}

- (void)didTouchColorSquare
{
    [self showColorPicker];
}

- (void)didTouchCloseBtn
{
    [self hideColorPicker];
}

- (void)showColorPicker
{
    [_colorPicker setHidden:NO];
    [_closeBtn setHidden:NO];
    [_titleField setHidden:YES];
}

- (void)hideColorPicker
{
    [_colorPicker setHidden:YES];
    [_closeBtn setHidden:YES];
    [_titleField setHidden:NO];
}

- (void)selectedColor:(UIColor *)color
{
    [_colorSquare setBackgroundColor:color];
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
