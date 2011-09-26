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

@interface DailyEditRow : Row <UITableViewDelegate, UITableViewDataSource> {
    NameCell *nameCell;
    NoteCell *noteCell;
    UITableView *optionsTable;
    NSUInteger rowId;
    NSUInteger rowPos;
    
    
    
    UITableView *tv;
    NSMutableArray *arr;
    NSString *popoverHeader;
    NSIndexPath *previousIndexPath;
    NSIndexPath *currentIndexPath;
    NSInteger previousIndex;
}

@property (nonatomic, retain) NameCell *nameCell;
@property (nonatomic, retain) NoteCell *noteCell;
@property (nonatomic, retain) UITableView *optionsTable;
@property NSUInteger rowId;
@property NSUInteger rowPos;



@property (nonatomic, retain) UITableView *tv;
@property (nonatomic, retain) NSMutableArray *arr;
@property (nonatomic, retain) NSString *popoverHeader;
@property (nonatomic, retain) NSIndexPath *previousIndexPath;
@property (nonatomic, retain) NSIndexPath *currentIndexPath;
@property NSInteger previousIndex;



- (void)propogateRowId:(NSUInteger)rid andPosition:(NSUInteger)rpos;
- (void)assignOptionsArray:(NSMutableArray *)options withHeader:(NSString *)header;

@end
