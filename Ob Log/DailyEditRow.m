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

@synthesize date = _date;
@synthesize course = _course;
@synthesize student = _student;
@synthesize entry = _entry;
@synthesize optionChoices = _optionChoices;

@synthesize nameCell = _nameCell;
@synthesize noteCell = _noteCell;
@synthesize actionsSlider = _actionSlider;
@synthesize actionButton = _actionButton;
@synthesize optionsScrollWrapper = _optionsScrollWrapper;
@synthesize optionsScroll = _optionsScroll;
@synthesize optionPickers = _optionPicker;
@synthesize arr = _arr;

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
        _student  = tStudent;
        _course   = tCourse;
        _date     = tDate;
        _nameCell = [[NameCell alloc] initWithFrame:CGRectMake(0, 0, 299, frame.size.height - 2) 
                                            andName:[NSString stringWithFormat:@"%@, %@", _student.lastName, _student.firstName]];
        _noteCell = [[NoteCell alloc] initWithFrame:CGRectMake(302, 0, frame.size.width - 308, frame.size.height)];
        
        [self addSubview:_nameCell];
        [self addSubview:_noteCell];
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
