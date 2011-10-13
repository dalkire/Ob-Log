//
//  DailyEditRow.m
//  Ob Log
//
//  Created by David Alkire on 9/25/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "DailyEditRow.h"

@implementation DailyEditRow

@synthesize delegate;
@synthesize containerTag;

@synthesize course;
@synthesize student;
@synthesize entry;
@synthesize optionChoices;

@synthesize nameCell;
@synthesize noteCell;
@synthesize actionsSlider;
@synthesize actionButton;
@synthesize optionsScrollWrapper;
@synthesize optionsScroll;
@synthesize optionPickers;

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
        self.course = nil;
        self.student = nil;
        self.entry = nil;
        self.optionChoices = nil;
        
        self.nameCell = nil;
        self.noteCell = nil;
        [self createNoteCellWithObject:[[NSObject alloc] init]];
        self.actionsSlider = self.noteCell.actionsSlider;
        self.optionsScrollWrapper = self.noteCell.actionsSlider.optionsScrollWrapper;
        self.optionsScroll = self.noteCell.actionsSlider.optionsScrollWrapper.optionsScroll;
        self.optionPickers = self.noteCell.actionsSlider.optionsScrollWrapper.optionsScroll.optionPickers;
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

- (void)assignOptionsArray:(NSMutableArray *)options
{
    arr = options;
}

@end
