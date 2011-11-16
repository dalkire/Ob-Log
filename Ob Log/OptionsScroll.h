//
//  OptionsScroll.h
//  Ob Log
//
//  Created by David Alkire on 9/22/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataHelperFunctions.h"
#import "OptionHeader.h"
#import "OptionChoice.h"
#import "OptionPicker.h"

@interface OptionsScroll : UIScrollView
{
    __weak id dailyEditRow;
    
    NSMutableArray *optionPickers;
    NSUInteger currX;
}

@property (nonatomic, assign) __weak id dailyEditRow;

@property (nonatomic, retain) NSMutableArray *optionPickers;
@property NSUInteger currX;

- (void)propagateDailyEditRow:(__weak id)der;
- (NSMutableArray *)createOptionPickersFromArray:(NSMutableArray *)pickersData;
- (OptionPicker *)createOptionPickerForHeader:(OptionHeader *)header;

@end
