//
//  SelectionTable.m
//  Ob Log
//
//  Created by David Alkire on 9/26/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "SelectionTable.h"

@implementation SelectionTable

@synthesize optionsArray;
@synthesize topShadow;
@synthesize bottomShadow;
@synthesize rowsArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:(float)0x88/0xFF 
                                               green:(float)0x88/0xFF 
                                                blue:(float)0x88/0xFF 
                                               alpha:1];
        rowsArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)createTableWithOptions:(NSMutableArray *)options
{
    optionsArray = options;
    int len = [optionsArray count];
    for (int i = 0; i < len; i++) {
        SelectionTableRow *row = [[SelectionTableRow alloc] initWithFrame:CGRectMake(306, 
                                                                                     i*40, 
                                                                                     self.frame.size.width - 306, 
                                                                                     40)];
        [row.rowLabel setText:[optionsArray objectAtIndex:i]];
        [self addSubview:row];
        [self.rowsArray addObject:row];
    }

    topShadow = [[UIView alloc] initWithFrame:CGRectMake(0, 
                                                          0, 
                                                          self.frame.size.width, 
                                                          8)];
    
    bottomShadow = [[UIView alloc] initWithFrame:CGRectMake(0, 
                                                           self.frame.size.height - 8, 
                                                           self.frame.size.width, 
                                                           8)];
    
    CAGradientLayer *gradientT = [CAGradientLayer layer];
    gradientT.frame = CGRectMake(
                                 0, 
                                 0, 
                                 topShadow.frame.size.width, 
                                 topShadow.frame.size.height);
    [gradientT setColors:[NSArray arrayWithObjects:(id)[UIColor colorWithRed:(float)0x33/0xFF 
                                                                       green:(float)0x33/0xFF 
                                                                        blue:(float)0x33/0xFF 
                                                                       alpha:0.2f].CGColor, 
                          (id)[UIColor colorWithRed:(float)0x33/0xFF 
                                              green:(float)0x33/0xFF 
                                               blue:(float)0x33/0xFF 
                                              alpha:0.0f].CGColor, 
                          nil]];
    gradientT.startPoint = CGPointMake(0, 0);
    gradientT.endPoint = CGPointMake(0, 1);
    [[topShadow layer] addSublayer:gradientT];
    topShadow.backgroundColor = [UIColor clearColor];
    
    CAGradientLayer *gradientB = [CAGradientLayer layer];
    [gradientB setColors:[NSArray arrayWithObjects:(id)[UIColor colorWithRed:(float)0x33/0xFF 
                                                                       green:(float)0x33/0xFF 
                                                                        blue:(float)0x33/0xFF 
                                                                       alpha:0.2f].CGColor, 
                          (id)[UIColor colorWithRed:(float)0x33/0xFF 
                                              green:(float)0x33/0xFF 
                                               blue:(float)0x33/0xFF 
                                              alpha:0.0f].CGColor, 
                          nil]];
    gradientB.frame = CGRectMake(
                                 0, 
                                 0, 
                                 bottomShadow.frame.size.width, 
                                 bottomShadow.frame.size.height);
    gradientB.startPoint = CGPointMake(0, 1);
    gradientB.endPoint = CGPointMake(0, 0);
    [[bottomShadow layer] addSublayer:gradientB];
    bottomShadow.backgroundColor = [UIColor clearColor];
    
    [self addSubview:topShadow];
    [self addSubview:bottomShadow];
}

- (void)deselectRows
{
    int len = [self.rowsArray count];
    for (int i = 0; i < len; i++) {
        [(SelectionTableRow *)[self.rowsArray objectAtIndex:i] deselectRow];
    }
}

/*- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touches ended for selection table");
    [super touchesEnded:touches withEvent:event];
}*/

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
