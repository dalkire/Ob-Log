//
//  OptionPicker.h
//  Ob Log
//
//  Created by David Alkire on 9/22/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "PickerOptionsViewController.h"
#import "Theme.h"
#import "DailyEditRow.h"

@interface OptionPicker : UIView <UIPopoverControllerDelegate>
{
    UIPopoverController *optionPickerPopover;
    NSMutableArray *arr;
    NSString *popoverHeader;
    UILabel *headerLabel;
    NSUInteger rowID;
    NSUInteger rowPos;
}

@property (nonatomic, retain) UIPopoverController *optionPickerPopover;
@property (nonatomic, retain) NSMutableArray *arr;
@property (nonatomic, retain) NSString *popoverHeader;
@property (nonatomic, retain) UILabel *headerLabel;
@property NSUInteger rowId;
@property NSUInteger rowPos;

- (void)setPickerHeader:(NSString *)header andOptions:(NSMutableArray *)options;
//+ (OptionPicker *)pickerWithHeader:(NSString *)header andOptions:(NSMutableArray *)options;

@end
