//
//  ColorPicker.m
//  Ob Log
//
//  Created by David Alkire on 11/28/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "ColorPicker.h"

@implementation ColorPicker

@synthesize delegate = _delegate;
@synthesize slider = _slider;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        _slider = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-slider.png"]];
        [_slider setFrame:CGRectMake(0, -2, _slider.frame.size.width, _slider.frame.size.height)];
        [self addSubview:_slider];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    int w = self.frame.size.width;
    int segLen = (float)w/6;
    UIColor *color = [Theme getThemeColor];
    
    
    for (int i = 0; i < 6; i++) {
        for (int j = 0; j < segLen; j++) {
            switch (i) {
                case 0:
                    color = [UIColor colorWithRed:(float)1 
                                            green:(float)0 
                                             blue:(float)j/segLen
                                            alpha:(float)1];
                    break;
                case 1:
                    color = [UIColor colorWithRed:(float)1 - (float)j/segLen 
                                            green:(float)0 
                                             blue:(float)1
                                            alpha:(float)1];
                    break;
                case 2:
                    color = [UIColor colorWithRed:(float)0 
                                            green:(float)j/segLen 
                                             blue:(float)1
                                            alpha:(float)1];
                    break;
                case 3:
                    color = [UIColor colorWithRed:(float)0 
                                            green:(float)1 
                                             blue:(float)1 - (float)j/segLen
                                            alpha:(float)1];
                    break;
                case 4:
                    color = [UIColor colorWithRed:(float)j/segLen 
                                            green:(float)1
                                             blue:(float)0
                                            alpha:(float)1];
                    break;
                case 5:
                    color = [UIColor colorWithRed:(float)1 
                                            green:(float)1 - (float)j/segLen 
                                             blue:(float)0
                                            alpha:(float)1];
                    break;
                    
                default:
                    break;
            }
            
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSetAlpha(context, 1.0);
            CGContextSetLineWidth(context, 1.0);
            CGContextSetStrokeColorWithColor(context, color.CGColor);
            CGContextMoveToPoint(context, j+segLen*i, 0);
            CGContextAddLineToPoint(context, j+segLen*i, self.frame.size.height);
            CGContextStrokePath(context);
        }
    }
    
    [super drawRect:rect];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self];
    
    int x = currentTouchPosition.x - 5;
    x = x < -4 ? -4 : x;
    x = x > self.frame.size.width - 5 ? self.frame.size.width - 5 : x;
    
    [_slider setFrame:CGRectMake(currentTouchPosition.x - 5, _slider.frame.origin.y, _slider.frame.size.width, _slider.frame.size.height)];
    
    float pct = self.frame.size.width/6;
    pct = (x + 4)/pct;
    
    int section = (int)pct;
    pct = pct - section;
    
    UIColor *color = [Theme getThemeColor];
    
    switch (section) {
        case 0:
            color = [UIColor colorWithRed:(float)1 
                                    green:(float)0 
                                     blue:(float)pct
                                    alpha:(float)1];
            break;
        case 1:
            color = [UIColor colorWithRed:(float)1 - pct 
                                    green:(float)0 
                                     blue:(float)1
                                    alpha:(float)1];
            break;
        case 2:
            color = [UIColor colorWithRed:(float)0 
                                    green:(float)pct 
                                     blue:(float)1
                                    alpha:(float)1];
            break;
        case 3:
            color = [UIColor colorWithRed:(float)0 
                                    green:(float)1 
                                     blue:(float)1 - pct
                                    alpha:(float)1];
            break;
        case 4:
            color = [UIColor colorWithRed:(float)pct 
                                    green:(float)1
                                     blue:(float)0
                                    alpha:(float)1];
            break;
        case 5:
            color = [UIColor colorWithRed:(float)1 
                                    green:(float)1 - pct 
                                     blue:(float)0
                                    alpha:(float)1];
            break;
            
        default:
            break;
    }
    
    [_delegate selectedColor:color];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self];
    
    int x = currentTouchPosition.x - 5;
    x = x < -4 ? -4 : x;
    x = x > self.frame.size.width - 5 ? self.frame.size.width - 5 : x;
    
    [_slider setFrame:CGRectMake(x, _slider.frame.origin.y, _slider.frame.size.width, _slider.frame.size.height)];
    
    float pct = self.frame.size.width/6;
    pct = (x + 4)/pct;
    
    int section = (int)pct;
    pct = pct - section;
    
    UIColor *color = [Theme getThemeColor];
    
    switch (section) {
        case 0:
            color = [UIColor colorWithRed:(float)1 
                                    green:(float)0 
                                     blue:(float)pct
                                    alpha:(float)1];
            break;
        case 1:
            color = [UIColor colorWithRed:(float)1 - pct 
                                    green:(float)0 
                                     blue:(float)1
                                    alpha:(float)1];
            break;
        case 2:
            color = [UIColor colorWithRed:(float)0 
                                    green:(float)pct 
                                     blue:(float)1
                                    alpha:(float)1];
            break;
        case 3:
            color = [UIColor colorWithRed:(float)0 
                                    green:(float)1 
                                     blue:(float)1 - pct
                                    alpha:(float)1];
            break;
        case 4:
            color = [UIColor colorWithRed:(float)pct 
                                    green:(float)1
                                     blue:(float)0
                                    alpha:(float)1];
            break;
        case 5:
            color = [UIColor colorWithRed:(float)1 
                                    green:(float)1 - pct 
                                     blue:(float)0
                                    alpha:(float)1];
            break;
            
        default:
            break;
    }
    
    [_delegate selectedColor:color];
}

// Color picker:
// 100 [1] 101 [2] 001 [3] 011 [4] 010 [5] 110 [6] 100
// Six segments, e.g. 0-102, 17 wide. If 87, 87/17 = 5.117...
// In segment 5 btw 010 and 110, .117... = percentage for 1'10

@end
