//
//  DailyEditRow.m
//  Ob Log
//
//  Created by David Alkire on 9/25/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "DailyEditRow.h"
#import "ViewController.h"

@implementation DailyEditRow

@synthesize delegate;
@synthesize containerTag;

@synthesize nameCell;
@synthesize noteCell;
@synthesize actionsSlider;
@synthesize actionButton;
@synthesize optionsScrollWrapper;
@synthesize optionsScroll;
@synthesize optionPickers;
@synthesize activeOptionPicker;
@synthesize selectionTable;
@synthesize selectionTableRows;
@synthesize activeSelectionTableRow;

@synthesize rowId;
@synthesize rowPos;
@synthesize arr;
@synthesize popoverHeader;
@synthesize previousIndexPath;
@synthesize currentIndexPath;
@synthesize previousIndex;
@synthesize activePicker;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        nameCell = nil;
        noteCell = nil;
        activePicker = nil;
        [self createNoteCellWithObject:[[NSObject alloc] init]];
        actionsSlider = noteCell.actionsSlider;
        optionsScrollWrapper = noteCell.actionsSlider.optionsScrollWrapper;
        optionsScroll = noteCell.actionsSlider.optionsScrollWrapper.optionsScroll;
        optionPickers = noteCell.actionsSlider.optionsScrollWrapper.optionsScroll.optionPickers;
        
        int len = [optionPickers count];
        for (int i = 0; i < len; i++) {
            [(OptionPicker *)[optionPickers objectAtIndex:i] setDelegate:self];
        }
        UIView *blueLine = [[UIView alloc] initWithFrame:CGRectMake(0, 
                                                                    frame.size.height - 1, 
                                                                    frame.size.width, 
                                                                    1)];
        blueLine.backgroundColor = [UIColor colorWithRed:(float)0x77/0xFF 
                                                    green:(float)0x9D/0xFF 
                                                     blue:(float)0xE8/0xFF 
                                                    alpha:1];
        [self addSubview:blueLine];
    }
    return self;
}

- (NameCell *)createNameCellWithName:(NSString *)name
{
    nameCell = nil;
    nameCell = [[NameCell alloc] initWithFrame:CGRectMake(0, 
                                                          0, 
                                                          299, 
                                                          self.frame.size.height - 2) 
                                       andName:name];
    [self addSubview:nameCell];
    
    return nameCell;
}

- (NoteCell *)createNoteCellWithObject:(NSObject *)object
{
    noteCell = nil;
    noteCell = [[NoteCell alloc] initWithFrame:CGRectMake(302, 
                                                          0, 
                                                          self.frame.size.width - 308, 
                                                          self.frame.size.height)];
    
    [self addSubview:noteCell];
    
    return noteCell;
}

- (void)createSelectionTableForOptionPicker:(OptionPicker *)optionPicker
{
    self.selectionTableRows = nil;
    self.selectionTable = nil;
    self.selectionTable = [[SelectionTable alloc] initWithFrame:CGRectMake(0, 
                                                                      self.frame.size.height - 1, 
                                                                      self.frame.size.width, 
                                                                      [optionPicker.options count]*40)];
    NSLog(@"createSelectionTableForOptionPicker -> self.selectionTable %@", self.selectionTable);
    [selectionTable createTableWithOptions:optionPicker.options];
    self.selectionTableRows = self.selectionTable.rowsArray;
    int len = [self.selectionTableRows count];
    for (int i = 0; i < len; i++) {
        [(SelectionTableRow *)[self.selectionTableRows objectAtIndex:i] setDelegate:self];
    }
    
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            self.frame.size.width,
                            self.frame.size.height + self.selectionTable.frame.size.height);
    
    [self addSubview:selectionTable];
    [delegate didAddSelectionTableToRow:self];
}

- (void)removeSelectionTable
{
    //[delegate didRemoveSelectionTableFromRow:self];
    if (self.selectionTable) {
        self.frame = CGRectMake(self.frame.origin.x, 
                                self.frame.origin.y, 
                                self.frame.size.width, 
                                self.frame.size.height - self.selectionTable.frame.size.height);
        [delegate didRemoveSelectionTableFromRow:self];
        [self.selectionTable removeFromSuperview];
        self.selectionTable = nil;
        self.selectionTableRows = nil;
    }
}

- (void)didSelectOptionPicker:(OptionPicker *)picker
{
    NSLog(@"didSelectOptionPicker");
    self.activeOptionPicker = picker;
    [self deselectOptionPickers];
    [self removeSelectionTable];
    [self selectOptionPicker:picker];
    [self createSelectionTableForOptionPicker:picker];
}

- (void)didDeselectOptionPicker:(OptionPicker *)picker
{
    NSLog(@"didDESELECTOptionPicker");
    self.activeOptionPicker = nil;
    [self removeSelectionTable];
}

- (void)selectOptionPicker:(OptionPicker *)picker
{
    [picker selectPicker];
}

- (void)deselectOptionPickers
{
    int len = [self.optionPickers count];
    for (int i = 0; i < len; i++) {
        [(OptionPicker *)[self.optionPickers objectAtIndex:i] deselectPicker];
    }
}

- (void)didSelectSelectionTableRow:(SelectionTableRow *)row
{
    self.activeSelectionTableRow.backgroundColor = [UIColor colorWithRed:(float)0xAA/0xFF 
                                                                   green:(float)0xAA/0xFF 
                                                                    blue:(float)0xAA/0xFF 
                                                                   alpha:1];
    self.activeSelectionTableRow = row;
    self.activeOptionPicker.headerLabel.text = row.rowLabel.text;
}


- (void)assignOptionsArray:(NSMutableArray *)options
{
    arr = options;
}

@end
