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
#import "SelectionTableRow.h"
#import "Theme.h"

@interface OptionPicker : UIView <UIPopoverControllerDelegate, SelectionTableRowDelegate>
{
    UIPopoverController *optionPickerPopover;
    NSMutableArray *options;
    NSString *popoverHeader;
    UILabel *headerLabel;
    NSUInteger rowID;
    NSUInteger rowPos;
    BOOL expanded;
    CAGradientLayer *gradient;
}

@property (nonatomic, retain) UIPopoverController *optionPickerPopover;
@property (nonatomic, retain) NSMutableArray *options;
@property (nonatomic, retain) NSString *popoverHeader;
@property (nonatomic, retain) UILabel *headerLabel;
@property NSUInteger rowId;
@property NSUInteger rowPos;
@property BOOL expanded;
@property (nonatomic, retain) CAGradientLayer *gradient;

- (id)initWithFrame:(CGRect)frame andHeader:(NSMutableString *)header andOptions:(NSMutableArray *)localOptions;

@end
