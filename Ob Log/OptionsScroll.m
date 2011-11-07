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
    NSMutableString *header = [[NSMutableString alloc] initWithString:@"participation"];
    NSMutableArray *options = [[NSMutableArray alloc] initWithObjects:@"1ne", @"2wo", @"3hree", @"4our", @"5ive", nil];
    
    int len = 8;
    for (int i = 0; i < len; i++) {
        [header appendFormat:@".%d", i];
        [localOptionPickers addObject:[self createOptionPickerWithHeader:header andOptions:options]];
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

- (OptionPicker *)createOptionPickerWithHeader:(NSMutableString *)header andOptions:(NSMutableArray *)options
{
    OptionPicker *picker = [[OptionPicker alloc] initWithFrame:CGRectMake(currX, 0, 100, CELL_HEIGHT) 
                                                     andHeader:header andOptions:options];
    
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
