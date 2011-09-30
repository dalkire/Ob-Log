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

@interface OptionPicker : UIView <UIPopoverControllerDelegate>
{
    id delegate;
    
    UIPopoverController *optionPickerPopover;
    NSMutableArray *options;
    NSString *popoverHeader;
    UILabel *headerLabel;
    NSUInteger rowID;
    NSUInteger rowPos;
    BOOL expanded;
    CAGradientLayer *gradient;
    BOOL active;
}

@property (nonatomic, retain) id delegate;

@property (nonatomic, retain) UIPopoverController *optionPickerPopover;
@property (nonatomic, retain) NSMutableArray *options;
@property (nonatomic, retain) NSString *popoverHeader;
@property (nonatomic, retain) UILabel *headerLabel;
@property NSUInteger rowId;
@property NSUInteger rowPos;
@property BOOL expanded;
@property (nonatomic, retain) CAGradientLayer *gradient;
@property BOOL active;

- (id)initWithFrame:(CGRect)frame andHeader:(NSMutableString *)header andOptions:(NSMutableArray *)localOptions;
- (void)selectPicker;
- (void)deselectPicker;

@end

@protocol OptionPickerDelegate <NSObject>

- (void)didSelectOptionPicker:(OptionPicker *)picker;
- (void)didDeselectOptionPicker:(OptionPicker *)picker;

@end
