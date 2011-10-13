//
//  NoteCell.h
//  oblog
//
//  Created by David Alkire on 9/21/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionsSlider.h"
#import "ActionButton.h"
#import "OptionsScrollWrapper.h"
#import "OptionsScroll.h"
#import "OptionPicker.h"

@interface NoteCell : UIView
{
    id dailyEditRow;
    
    ActionsSlider *actionsSlider;
    ActionButton *actionButton;
    OptionsScrollWrapper *optionsScrollWrapper;
    OptionsScroll *optionsScroll;
    OptionPicker *optionPicker;
    BOOL sliderIsExtended;
    UIScrollView *scrollView;
    UITextView *textView;
    NSUInteger rowId;
    NSUInteger rowPos;
}

@property (nonatomic, assign) __weak id dailyEditRow;

@property (nonatomic, retain) ActionsSlider *actionsSlider;
@property (nonatomic, retain) ActionButton *actionButton;
@property (nonatomic, retain) OptionsScrollWrapper *optionsScrollWrapper;
@property (nonatomic, retain) OptionsScroll *optionsScroll;
@property (nonatomic, retain) OptionPicker *optionPicker;
@property BOOL sliderIsExtended;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UITextView *textView;
@property NSUInteger rowId;
@property NSUInteger rowPos;

@end
