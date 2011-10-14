//
//  ActionsSlider.h
//  ObLog
//
//  Created by David Alkire on 9/21/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionButton.h"
#import "OptionsScrollWrapper.h"
#import "OptionPicker.h"

@interface ActionsSlider : UIView
{
    id dailyEditRow;
    
    ActionButton *actionButton;
    OptionsScrollWrapper *optionsScrollWrapper;
    OptionsScroll *optionsScroll;
    NSMutableArray *pickers;
    
    NSUInteger rowId;
    NSUInteger rowPos;
}

@property (nonatomic, assign) id dailyEditRow;

@property (nonatomic, retain) ActionButton *actionButton;
@property (nonatomic, retain) OptionsScrollWrapper *optionsScrollWrapper;
@property (nonatomic, retain) OptionsScroll *optionsScroll;
@property (nonatomic, retain) NSMutableArray *optionPickers;

@property NSUInteger rowId;
@property NSUInteger rowPos;

- (void)propagateDailyEditRow:(__weak id)der;

@end
