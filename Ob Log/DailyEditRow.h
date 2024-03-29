//
//  DailyEditRow.h
//  Ob Log
//
//  Created by David Alkire on 9/25/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Course.h"
#import "Student.h"
#import "Entry.h"
#import "OptionChoice.h"

#import "Row.h"
#import "NameCell.h"
#import "NoteCell.h"
#import "ActionsSlider.h"
#import "ActionButton.h"
#import "OptionsScrollWrapper.h"
#import "OptionsScroll.h"
#import "OptionPicker.h"
#import "DailyEditViewController.h"
#import "OptionsPopoverTableViewController.h"

@interface DailyEditRow : Row <OptionPickerDelegate, OptionsPopoverTVCDelegate>
{
    id delegate;
    NSUInteger containerTag;
    
    NSDate *date;
    Course *course;
    Student *student;
    Entry *entry;
    NSSet *optionChoices;
    
    UIPopoverController *optionsPopoverController;
    
    NameCell *nameCell;
    NoteCell *noteCell;
    ActionsSlider *actionsSlider;
    ActionButton *actionButton;
    OptionsScrollWrapper *optionsScrollWrapper;
    OptionsScroll *optionsScroll;
    NSMutableArray *optionPickers;
    OptionPicker *activePicker;
    NSMutableArray *arr;
    
    NSUInteger rowId;
    NSUInteger rowPos;
    NSString *popoverHeader;
    NSIndexPath *previousIndexPath;
    NSIndexPath *currentIndexPath;
    NSInteger previousIndex;
    UIColor *highlightColor;
    BOOL popoverShowing;
}


@property (nonatomic, retain) id delegate;
@property NSUInteger containerTag;

@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) Course *course;
@property (nonatomic, retain) Student *student;
@property (nonatomic, retain) Entry *entry;
@property (nonatomic, retain) NSSet *optionChoices;

@property (nonatomic, retain) UIPopoverController *optionsPopoverController;

@property (nonatomic, retain) NameCell *nameCell;
@property (nonatomic, retain) NoteCell *noteCell;
@property (nonatomic, retain) ActionsSlider *actionsSlider;
@property (nonatomic, retain) ActionButton *actionButton;
@property (nonatomic, retain) OptionsScrollWrapper *optionsScrollWrapper;
@property (nonatomic, retain) OptionsScroll *optionsScroll;
@property (nonatomic, retain) NSMutableArray *optionPickers;
@property (nonatomic, retain) OptionPicker *activePicker;
@property (nonatomic, retain) NSMutableArray *arr;

@property NSUInteger rowId;
@property NSUInteger rowPos;
@property (nonatomic, retain) NSString *popoverHeader;
@property (nonatomic, retain) NSIndexPath *previousIndexPath;
@property (nonatomic, retain) NSIndexPath *currentIndexPath;
@property NSInteger previousIndex;
@property (nonatomic, retain) UIColor *highlightColor;
@property BOOL popoverShowing;

- (id)initWithFrame:(CGRect)frame andStudent:(Student *)iStudent inCourse:(Course *)iCourse forDate:(NSDate *)iDate;
- (void)assignOptionsArray:(NSMutableArray *)options;

@end
