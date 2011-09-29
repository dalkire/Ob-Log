//
//  OptionsScroll.h
//  Ob Log
//
//  Created by David Alkire on 9/22/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OptionPicker.h"

@interface OptionsScroll : UIScrollView
{
    NSMutableArray *optionPickers;
    NSUInteger currX;
}

@property (nonatomic, retain) NSMutableArray *optionPickers;
@property NSUInteger currX;

- (NSMutableArray *)createOptionPickersFromArray:(NSMutableArray *)pickersData;
- (OptionPicker *)createOptionPickerWithHeader:(NSMutableString *)header andOptions:(NSMutableArray *)options;

@end
