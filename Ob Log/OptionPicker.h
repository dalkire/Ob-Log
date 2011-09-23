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

@interface OptionPicker : UIView <UIPopoverControllerDelegate>
{
    UIPopoverController *optionPickerPopover;
}

@property (nonatomic, retain) UIPopoverController *optionPickerPopover;

+ (OptionPicker *)pickerWithHeader:(NSString *)header andOptions:(NSArray *)options;

@end
