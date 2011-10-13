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

@interface DailyEditRow : Row
{
    id delegate;
    NSUInteger containerTag;
    
    Course *course;
    Student *student;
    Entry *entry;
    NSSet *optionChoices;
    
    NameCell *nameCell;
    NoteCell *noteCell;
    ActionsSlider *actionsSlider;
    ActionButton *actionButton;
    OptionsScrollWrapper *optionsScrollWrapper;
    OptionsScroll *optionsScroll;
    NSMutableArray *optionPickers;
    NSMutableArray *arr;
    
    NSUInteger rowId;
    NSUInteger rowPos;
    NSString *popoverHeader;
    NSIndexPath *previousIndexPath;
    NSIndexPath *currentIndexPath;
    NSInteger previousIndex;
}


@property (nonatomic, assign) id delegate;
@property NSUInteger containerTag;

@property (nonatomic, retain) Course *course;
@property (nonatomic, retain) Student *student;
@property (nonatomic, retain) Entry *entry;
@property (nonatomic, retain) NSSet *optionChoices;

@property (nonatomic, retain) NameCell *nameCell;
@property (nonatomic, retain) NoteCell *noteCell;
@property (nonatomic, retain) ActionsSlider *actionsSlider;
@property (nonatomic, retain) ActionButton *actionButton;
@property (nonatomic, retain) OptionsScrollWrapper *optionsScrollWrapper;
@property (nonatomic, retain) OptionsScroll *optionsScroll;
@property (nonatomic, retain) NSMutableArray *optionPickers;
@property (nonatomic, retain) NSMutableArray *arr;

@property NSUInteger rowId;
@property NSUInteger rowPos;
@property (nonatomic, retain) NSString *popoverHeader;
@property (nonatomic, retain) NSIndexPath *previousIndexPath;
@property (nonatomic, retain) NSIndexPath *currentIndexPath;
@property NSInteger previousIndex;

- (id)initWithFrame:(CGRect)frame andStudent:(Student *)tStudent inCourse:(Course *)tCourse forDate:(NSDate *)tDate;
- (void)assignOptionsArray:(NSMutableArray *)options;

@end
