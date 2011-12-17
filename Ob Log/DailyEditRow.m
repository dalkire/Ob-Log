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

@synthesize optionsPopoverController = _optionsPopoverController;

@synthesize nameCell = _nameCell;
@synthesize noteCell = _noteCell;
@synthesize actionsSlider = _actionSlider;
@synthesize actionButton = _actionButton;
@synthesize optionsScrollWrapper = _optionsScrollWrapper;
@synthesize optionsScroll = _optionsScroll;
@synthesize optionPickers = _optionPickers;
@synthesize activePicker = _activePicker;
@synthesize arr = _arr;

@synthesize rowId;
@synthesize rowPos;
@synthesize popoverHeader;
@synthesize previousIndexPath;
@synthesize currentIndexPath;
@synthesize previousIndex;
@synthesize highlightColor = _highlightColor;
@synthesize popoverShowing = _popoverShowing;

- (id)initWithFrame:(CGRect)frame andStudent:(Student *)iStudent inCourse:(Course *)iCourse forDate:(NSDate *)iDate
{
    self = [super initWithFrame:frame];
    if (self) {
        _student  = iStudent;
        _course   = iCourse;
        _date     = iDate;
        _nameCell = [[NameCell alloc] initWithFrame:CGRectMake(0, 0, 299, frame.size.height - 2) 
                                            andName:[NSString stringWithFormat:@"%@, %@", _student.lastName, _student.firstName]];
        _noteCell = [[NoteCell alloc] initWithFrame:CGRectMake(302, 0, frame.size.width - 308, frame.size.height)];
        [_noteCell propagateDailyEditRow:self];
        
        [self addSubview:_nameCell];
        [self addSubview:_noteCell];
    }
    
    return self;
}

- (void)assignOptionsArray:(NSMutableArray *)options
{
    _arr = options;
}


- (void)didSelectOptionPicker:(OptionPicker *)picker
{
    if (!_popoverShowing) {
        [picker selectPicker];
        if (_activePicker) {
            [_activePicker deselectPicker];
        }
        _activePicker = picker;
    
        NSLog(@"didSelectOptionPickerin row: %@", picker.dailyEditRow);
        OptionsPopoverTableViewController *optionsPopTVC = [[OptionsPopoverTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        [optionsPopTVC setOptionsArray:picker.options];
        _optionsPopoverController = [[UIPopoverController alloc] initWithContentViewController:optionsPopTVC];
        [_optionsPopoverController setPopoverContentSize:CGSizeMake(200, 200) 
                                                animated:YES];
        [_optionsPopoverController presentPopoverFromRect:[picker bounds] 
                                                   inView:picker
                                 permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [optionsPopTVC setDelegate:self];
        _popoverShowing = YES;
    }
}

- (void)didSelectOptionRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@", indexPath);
    [_optionsPopoverController dismissPopoverAnimated:YES];
    _activePicker.headerLabel.text = [_activePicker.options objectAtIndex:[indexPath indexAtPosition:1]];
    _popoverShowing = NO;
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
