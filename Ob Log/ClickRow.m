//
//  ClickRow.m
//  Ob Log
//
//  Created by David Alkire on 10/2/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "ClickRow.h"

@implementation ClickRow

@synthesize delegate;
@synthesize cell;
@synthesize mainLabel;
@synthesize course;
@synthesize clickColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:(float)0xEE/0xFF 
                                               green:(float)0xEE/0xFF 
                                                blue:(float)0xEE/0xFF 
                                               alpha:1];
        
        cell = [[UIView alloc] initWithFrame:CGRectMake(0, 
                                                        0, 
                                                        frame.size.width, 
                                                        frame.size.height)];
        cell.backgroundColor = [UIColor clearColor];
        
        mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, frame.size.width - 60, frame.size.height - 20)];
        mainLabel.backgroundColor = [UIColor clearColor];
        mainLabel.textColor = [UIColor blackColor];
        mainLabel.font = [UIFont fontWithName:@"Helvetica" size:28];
        mainLabel.text = @"";
        [mainLabel sizeToFit];
        mainLabel.frame = CGRectMake(30, 
                                     (frame.size.height - mainLabel.frame.size.height)/2, 
                                     frame.size.width - 60, 
                                     mainLabel.frame.size.height);
        [cell addSubview:mainLabel];
        [self addSubview:cell];
        marginLine.hidden = YES;
    }
    return self;
}

- (void)setMainLabelText:(NSString *)text
{
    mainLabel.text = text;
    [mainLabel sizeToFit];
    mainLabel.frame = CGRectMake(30, 
                                 (self.frame.size.height - mainLabel.frame.size.height)/2, 
                                 self.frame.size.width - 60, 
                                 mainLabel.frame.size.height);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.cell.backgroundColor = [UIColor colorWithRed:(float)0xDD/0xFF 
                                                green:(float)0xDD/0xFF 
                                                 blue:(float)0xDD/0xFF 
                                                alpha:1];
    self.mainLabel.textColor = [UIColor blackColor];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.cell.backgroundColor = [UIColor clearColor];
    self.mainLabel.textColor = [UIColor blackColor];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTouchClickRow:)]) {
        [self.delegate didTouchClickRow:self];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.cell.backgroundColor = [UIColor clearColor];
    self.mainLabel.textColor = [UIColor blackColor];
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
