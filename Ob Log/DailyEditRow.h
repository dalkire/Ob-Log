//
//  DailyEditRow.h
//  Ob Log
//
//  Created by David Alkire on 9/25/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Row.h"
#import "NameCell.h"
#import "NoteCell.h"
#import "ActionsSlider.h"
#import "ActionButton.h"
#import "OptionsScrollWrapper.h"
#import "OptionsScroll.h"
#import "OptionPicker.h"
#import "SelectionTable.h"

@interface DailyEditRow : Row <OptionPickerDelegate>
{
    id delegate;
    NSUInteger containerTag;
    
    NameCell *nameCell;
    NoteCell *noteCell;
    ActionsSlider *actionsSlider;
    ActionButton *actionButton;
    OptionsScrollWrapper *optionsScrollWrapper;
    OptionsScroll *optionsScroll;
    NSMutableArray *optionPickers;
    OptionPicker *activeOptionPicker;
    SelectionTable *selectionTable;
    NSMutableArray *selectionTableRows;
    SelectionTableRow *activeSelectionTableRow;
    
    NSUInteger rowId;
    NSUInteger rowPos;
    NSMutableArray *arr;
    NSString *popoverHeader;
    NSIndexPath *previousIndexPath;
    NSIndexPath *currentIndexPath;
    NSInteger previousIndex;
    OptionPicker *activePicker;
}


@property (nonatomic, retain) id delegate;
@property NSUInteger containerTag;

@property (nonatomic, retain) NameCell *nameCell;
@property (nonatomic, retain) NoteCell *noteCell;
@property (nonatomic, retain) ActionsSlider *actionsSlider;
@property (nonatomic, retain) ActionButton *actionButton;
@property (nonatomic, retain) OptionsScrollWrapper *optionsScrollWrapper;
@property (nonatomic, retain) OptionsScroll *optionsScroll;
@property (nonatomic, retain) NSMutableArray *optionPickers;
@property (nonatomic, retain) OptionPicker *activeOptionPicker;
@property (nonatomic, retain) SelectionTable *selectionTable;
@property (nonatomic, retain) NSMutableArray *selectionTableRows;
@property (nonatomic, retain) SelectionTableRow *activeSelectionTableRow;
@property NSUInteger rowId;
@property NSUInteger rowPos;
@property (nonatomic, retain) NSMutableArray *arr;
@property (nonatomic, retain) NSString *popoverHeader;
@property (nonatomic, retain) NSIndexPath *previousIndexPath;
@property (nonatomic, retain) NSIndexPath *currentIndexPath;
@property NSInteger previousIndex;
@property (nonatomic, retain) OptionPicker *activePicker;

- (NameCell *)createNameCellWithName:(NSString *)name;
- (NoteCell *)createNoteCellWithObject:(NSObject *)object;
- (void)createSelectionTableForOptionPicker:(OptionPicker *)optionPicker;
- (void)removeSelectionTable;
- (void)selectOptionPicker:(OptionPicker *)picker;
- (void)deselectOptionPickers;
- (void)assignOptionsArray:(NSMutableArray *)options;

@end

@protocol DailyEditRowDelegate <NSObject>

- (void)didAddSelectionTableToRow:(DailyEditRow *)row;
- (void)didRemoveSelectionTableFromRow:(DailyEditRow *)row;

@end
