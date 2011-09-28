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
#import "SelectionTable.h"
#import "OptionPicker.h"

@interface DailyEditRow : Row 
{
    NameCell *nameCell;
    NoteCell *noteCell;
    SelectionTable *selectionTable;
    NSUInteger rowId;
    NSUInteger rowPos;
    NSMutableArray *arr;
    NSString *popoverHeader;
    NSIndexPath *previousIndexPath;
    NSIndexPath *currentIndexPath;
    NSInteger previousIndex;
    OptionPicker *activePicker;
}

@property (nonatomic, retain) NameCell *nameCell;
@property (nonatomic, retain) NoteCell *noteCell;
@property (nonatomic, retain) SelectionTable *selectionTable;
@property NSUInteger rowId;
@property NSUInteger rowPos;
@property (nonatomic, retain) NSMutableArray *arr;
@property (nonatomic, retain) NSString *popoverHeader;
@property (nonatomic, retain) NSIndexPath *previousIndexPath;
@property (nonatomic, retain) NSIndexPath *currentIndexPath;
@property NSInteger previousIndex;
@property (nonatomic, retain) OptionPicker *activePicker;


- (void)addSelectionTableForOptions:(NSMutableArray *)options;
- (void)collapseRow;
- (void)propogateRowId:(NSUInteger)rid andPosition:(NSUInteger)rpos;
- (void)assignOptionsArray:(NSMutableArray *)options;

@end
