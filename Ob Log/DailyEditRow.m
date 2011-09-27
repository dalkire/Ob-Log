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
@synthesize selectionTable;
@synthesize rowId;
@synthesize rowPos;
@synthesize arr;
@synthesize popoverHeader;
@synthesize previousIndexPath;
@synthesize currentIndexPath;
@synthesize previousIndex;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        nameCell = [[[NameCell alloc] initWithFrame:CGRectMake(0, 
                                                               0, 
                                                               299, 
                                                               frame.size.height - 2)] autorelease];
        nameCell.backgroundColor = [UIColor clearColor];
         
        noteCell = [[[NoteCell alloc] initWithFrame:CGRectMake(302, 
                                                               0, 
                                                               frame.size.width - 308, 
                                                               frame.size.height)] autorelease];         
        [self addSubview:nameCell];
        [self addSubview:noteCell];
        
        selectionTable = [[SelectionTable alloc] initWithFrame:CGRectMake(0, 
                                                                     frame.size.height, 
                                                                     frame.size.width, 
                                                                     60)];
        
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (void)propogateRowId:(NSUInteger)rid andPosition:(NSUInteger)rpos
{
    [self setRowId:rid];
    [self setRowPos:rpos];
    [nameCell setRowId:rid];
    [nameCell setRowPos:rpos];
    [noteCell setRowId:rid];
    [noteCell setRowPos:rpos];
    [noteCell.slider setRowId:rid];
    [noteCell.slider setRowPos:rpos];
    [noteCell.slider loadOptionPickers];
}


- (void)assignOptionsArray:(NSMutableArray *)options
{
    arr = options;
}

@end
