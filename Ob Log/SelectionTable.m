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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:(float)0x66/0xFF 
                                               green:(float)0x66/0xFF 
                                                blue:(float)0x66/0xFF 
                                               alpha:1];
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
    }
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, len*40)];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touches ended for selection table");
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
