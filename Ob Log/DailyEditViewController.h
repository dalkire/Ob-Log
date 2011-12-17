//
//  DailyEditViewController.h
//  Ob Log
//
//  Created by David Alkire on 10/2/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CoreDataHelperFunctions.h"
#import "DailyEditRow.h"
#import "ClickRow.h"
#import "NameCell.h"
#import "NoteCell.h"
#import "Header.h"
#import "EditStudentsTableViewController.h"
#import "EditNavController.h"
#import "OptionPicker.h"
#import "OptionsPopoverTableViewController.h"

@interface DailyEditViewController : UIViewController <UIPopoverControllerDelegate>
{
    id delegate;
    
    NSMutableArray *studentsMutableArray;
    NSMutableArray *entriesArray;
    NSManagedObjectContext *managedObjectContext;
    UIToolbar *toolbar;
    UISegmentedControl *segmentedControl;
    UIImageView *bg;
    UIScrollView *scrollView;
    Header *header;
    Course *course;
    NSDate *date;
    BOOL popoverShowing;
}

@property (nonatomic, assign) id delegate;

@property (nonatomic, retain) NSMutableArray *studentsMutableArray;
@property (nonatomic, retain) NSMutableArray *entriesArray;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) UIToolbar *toolbar;
@property (nonatomic, retain) UISegmentedControl *segmentedControl;
@property (nonatomic, retain) UIImageView *bg;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) Header *header;
@property (nonatomic, retain) Course *course;
@property (nonatomic, retain) NSDate *date;
@property BOOL popoverShowing;

- (void)loadStudentsForCourse:(Course *)crse andDate:(NSDate *)dat;
- (void)didTouchHomeBtn;
- (void)didTouchStudentsBtn;
- (void)didTouchSegmentedControl;
- (void)showOptionsForPicker:(OptionPicker *)picker;

@end

@protocol DailyEditViewControllerDelegate <NSObject>

- (void)loadCoursesViewController;
- (void)loadCourseViewControllerForCourse:(Course *)crse;

@end