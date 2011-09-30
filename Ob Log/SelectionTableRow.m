//
//  SelectionTableRow.m
//  Ob Log
//
//  Created by David Alkire on 9/26/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "SelectionTableRow.h"
#import "SelectionTable.h"

@implementation SelectionTableRow

@synthesize delegate;

@synthesize rowLabel;
@synthesize active;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        delegate = nil;
        self.backgroundColor = [UIColor colorWithRed:(float)0xAA/0xFF 
                                               green:(float)0xAA/0xFF 
                                                blue:(float)0xAA/0xFF 
                                               alpha:1];
        rowLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 
                                                             10, 
                                                             self.frame.size.width - 40, 
                                                             self.frame.size.height - 20)];
        [rowLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
        rowLabel.textColor = [UIColor whiteColor];
        [rowLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:rowLabel];
        active = NO;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    active = !active;
    
    if (active) {
        self.backgroundColor = [Theme getThemeColor];
        if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectSelectionTableRow:)]) {
            [self.delegate didSelectSelectionTableRow:self];
        }
    }
    
    //[super touchesEnded:touches withEvent:event];
}

- (void)deselectRow
{
    self.backgroundColor = [UIColor colorWithRed:(float)0xAA/0xFF 
                                           green:(float)0xAA/0xFF 
                                            blue:(float)0xAA/0xFF 
                                           alpha:1];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context1 = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context1, 2.0);
    CGContextSetStrokeColorWithColor(context1, [UIColor colorWithRed:(float)0x88/0xFF 
                                                               green:(float)0x88/0xFF 
                                                                blue:(float)0x88/0xFF 
                                                               alpha:1.0f].CGColor);
    CGContextMoveToPoint(context1, 0, self.frame.size.height);
    CGContextAddLineToPoint(context1, self.frame.size.width, self.frame.size.height);
    CGContextStrokePath(context1);
    
    [super drawRect:rect];
}

@end
