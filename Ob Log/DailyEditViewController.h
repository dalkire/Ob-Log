//
//  DailyEditViewController.h
//  Ob Log
//
//  Created by David Alkire on 10/2/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "DailyEditRow.h"
#import "NameCell.h"
#import "NoteCell.h"
#import "DateHeader.h"
#import "EditModalViewController.h"
#import "OptionPicker.h"
#import "OptionsPopoverTableViewController.h"
#import "Entry.h"

@interface DailyEditViewController : UIViewController <OptionPickerDelegate, OptionsPopoverTVCDelegate>
{
    NSMutableArray *entryArray;
    NSManagedObjectContext *managedObjectContext;
    
    UIPopoverController *optionsPopoverController;
    UIToolbar *toolbar;
    UISegmentedControl *segmentedControl;
    UIImageView *bg;
    UIScrollView *scrollView;
    DateHeader *dateHeader;
    UIView *dateHeaderDropShadow;
    EditModalViewController *editModal;
    OptionPicker *activePicker;
}

@property (nonatomic, retain) NSMutableArray *entryArray;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, retain) UIPopoverController *optionsPopoverController;

@property (nonatomic, retain) UIToolbar *toolbar;
@property (nonatomic, retain) UISegmentedControl *segmentedControl;
@property (nonatomic, retain) UIImageView *bg;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) DateHeader *dateHeader;
@property (nonatomic, retain) UIView *dateHeaderDropShadow;
@property (nonatomic, retain) EditModalViewController *editModal;
@property (nonatomic, retain) OptionPicker *activePicker;

- (void)queryEntries;
- (void)initModalForUser:(NSUInteger)uid andDate:(NSDate *)date;
- (void)showOptionsForPicker:(OptionPicker *)picker;

@end