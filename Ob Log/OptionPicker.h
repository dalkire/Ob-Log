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

@interface OptionPicker : UIView <UIPopoverControllerDelegate>
{
    id delegate;
    
    __weak id dailyEditRow;
    
    UIPopoverController *optionPickerPopover;
    NSMutableArray *options;
    NSString *popoverHeader;
    UILabel *headerLabel;
    NSUInteger rowId;
    BOOL expanded;
    CAGradientLayer *gradient;
    BOOL active;
    UIColor *highlightColor;
}

@property (nonatomic, retain) id delegate;

@property (nonatomic, assign) __weak id dailyEditRow;

@property (nonatomic, retain) UIPopoverController *optionPickerPopover;
@property (nonatomic, retain) NSMutableArray *options;
@property (nonatomic, retain) NSString *popoverHeader;
@property (nonatomic, retain) UILabel *headerLabel;
@property NSUInteger rowId;
@property BOOL expanded;
@property (nonatomic, retain) CAGradientLayer *gradient;
@property BOOL active;
@property (nonatomic, retain) UIColor *highlightColor;

- (void)propagateDailyEditRow:(__weak id)der;
- (id)initWithFrame:(CGRect)frame andHeader:(NSMutableString *)header andOptions:(NSMutableArray *)localOptions;
- (void)selectPicker;
- (void)deselectPicker;

@end

@protocol OptionPickerDelegate <NSObject>

- (void)didSelectOptionPicker:(OptionPicker *)picker;

@end
