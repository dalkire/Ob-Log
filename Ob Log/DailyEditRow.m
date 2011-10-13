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
@synthesize popoverHeader;
@synthesize previousIndexPath;
@synthesize currentIndexPath;
@synthesize previousIndex;

- (id)initWithFrame:(CGRect)frame andStudent:(Student *)tStudent inCourse:(Course *)tCourse forDate:(NSDate *)tDate
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

- (void)assignOptionsArray:(NSMutableArray *)options
{
    _arr = options;
}

- (void)dealloc
{
    [_student release];
    [_course release];
    [_date release];
    [_nameCell release];
    [_noteCell release];
    [super dealloc];
}

@end
