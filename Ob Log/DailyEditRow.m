//
//  DailyEditRow.m
//  Ob Log
//
//  Created by David Alkire on 9/25/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "DailyEditRow.h"

@implementation DailyEditRow

@synthesize nameCell;
@synthesize noteCell;
@synthesize actionsSlider;
@synthesize actionButton;
@synthesize optionsScrollWrapper;
@synthesize optionsScroll;
@synthesize activeOptionPicker;
@synthesize selectionTable;
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
    actionsSlider = [noteCell createActionsSlider];
    [actionsSlider loadOptionPickers];
    
    [self addSubview:noteCell];
    
    return noteCell;
}

- (void)addSelectionTableForOptions:(NSMutableArray *)options
{
    self.selectionTable = [[SelectionTable alloc] initWithFrame:CGRectMake(0, 
                                                                      self.frame.size.height - 1, 
                                                                      self.frame.size.width, 
                                                                      [options count]*40)];
    [selectionTable createTableWithOptions:options];
    
    self.frame = CGRectMake(self.frame.origin.x, 
                            self.frame.origin.y, 
                            self.frame.size.width, 
                            self.frame.size.height + [options count]*40);
    
    [self addSubview:selectionTable];
}

- (void)collapseRow
{
    self.frame = CGRectMake(self.frame.origin.x, 
                            self.frame.origin.y, 
                            self.frame.size.width, 
                            self.frame.size.height - selectionTable.frame.size.height);
    [selectionTable removeFromSuperview];
    selectionTable = nil;
    //[selectionTable release];
}

- (void)propogateRowId:(NSUInteger)rid andPosition:(NSUInteger)rpos
{
    /*[self setRowId:rid];
    [self setRowPos:rpos];
    [nameCell setRowId:rid];
    [nameCell setRowPos:rpos];
    [noteCell setRowId:rid];
    [noteCell setRowPos:rpos];
    [noteCell.slider setRowId:rid];
    [noteCell.slider setRowPos:rpos];
    [noteCell.slider loadOptionPickers];*/
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touches ended for daily edit row");
    [super touchesEnded:touches withEvent:event];
}


- (void)assignOptionsArray:(NSMutableArray *)options
{
    arr = options;
}

@end
