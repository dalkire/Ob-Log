//
//  ViewController.h
//  Ob Log
//
//  Created by David Alkire on 9/22/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "DailyEditRow.h"
#import "NameCell.h"
#import "NoteCell.h"
#import "DateHeader.h"
#import "EditModalViewController.h"
#import "Container.h"
#import "OptionPicker.h"

@interface ViewController : UIViewController <DailyEditRowDelegate>
{
    UIImageView *bg;
    UIScrollView *scrollView;
    DateHeader *dateHeader;
    UIView *dateHeaderDropShadow;
    EditModalViewController *editModal;
    DailyEditRow *activeRow;
    OptionPicker *activePicker;
    Container *expandedContainer;
}

@property (nonatomic, retain) UIImageView *bg;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) DateHeader *dateHeader;
@property (nonatomic, retain) UIView *dateHeaderDropShadow;
@property (nonatomic, retain) EditModalViewController *editModal;
@property (nonatomic, retain) DailyEditRow *activeRow;
@property (nonatomic, retain) OptionPicker *activePicker;
@property (nonatomic, retain) Container *expandedContainer;

- (void)initModalForUser:(NSUInteger)uid andDate:(NSDate *)date;
- (void)showOptionsForPicker:(OptionPicker *)picker;
- (void)expandContainer:(Container *)container;
- (void)collapseContainer:(Container *)container;

@end
