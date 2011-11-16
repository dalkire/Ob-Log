//
//  OptionsScroll.m
//  Ob Log
//
//  Created by David Alkire on 9/22/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "OptionsScroll.h"
#import "OptionsScrollWrapper.h"
#import "DailyEditRow.h"

@implementation OptionsScroll

@synthesize dailyEditRow;

@synthesize optionPickers = _optionPickers;
@synthesize currX;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        currX = 0;
        self.backgroundColor = [UIColor clearColor];
        _optionPickers = [self createOptionPickersFromArray:[[NSMutableArray alloc] initWithCapacity:0]];
    }
    return self;
}

- (NSMutableArray *)createOptionPickersFromArray:(NSMutableArray *)pickersData
{
    NSMutableArray *localOptionPickers = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *optionHeaders = [[NSMutableArray alloc] initWithArray:[CoreDataHelperFunctions fetchOptionHeaders]];
    
    int len = [optionHeaders count];
    for (int i = 0; i < len; i++) {
        [localOptionPickers addObject:[self createOptionPickerForHeader:[optionHeaders objectAtIndex:i]]];
    }
    NSLog(@"creating pickers");
    
    return localOptionPickers;
}

- (void)propagateDailyEditRow:(__weak id)der
{
    [self setDailyEditRow:der];
    NSLog(@"DER in OS: %@ %@ and OP length=%d", [der student].firstName, [der student].lastName, [_optionPickers count]);
    int len = [_optionPickers count];
    for (int i = 0; i < len; i++) {
        [(OptionPicker *)[_optionPickers objectAtIndex:i] propagateDailyEditRow:der];
        [[(DailyEditRow *)der optionPickers] addObject:(OptionPicker *)[_optionPickers objectAtIndex:i]];
    }
}

- (OptionPicker *)createOptionPickerForHeader:(OptionHeader *)header
{
    NSMutableArray *optionChoices = [[NSMutableArray alloc] initWithArray:[CoreDataHelperFunctions fetchOptionChoicesForOptionHeader:header]];
    OptionPicker *picker = [[OptionPicker alloc] initWithFrame:CGRectMake(currX, 0, 100, CELL_HEIGHT) 
                                                     andHeader:header andOptions:optionChoices];
    
    currX = picker.frame.origin.x + picker.frame.size.width + 1;
    [self addSubview:picker];
    
    self.contentSize = CGSizeMake(self.contentSize.width + picker.frame.size.width + 1, self.contentSize.height);
    
    return picker;
}

/*- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
     NSLog(@"touchesENDED in OptionsScroll");
    [super touchesEnded:touches withEvent:event];
}*/

/*- (void)drawRect:(CGRect)rect
{
 
}*/

@end
