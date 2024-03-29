//
//  CoursesViewController.h
//  Ob Log
//
//  Created by David Alkire on 10/5/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CoreDataHelperFunctions.h"
#import "Header.h"
#import "ClickRow.h"
#import "Toolbar.h"
#import "ColorTag.h"
#import "DailyEditViewController.h"
#import "AddStudentViewController.h"
#import "EditNavController.h"
#import "EditCoursesTableViewController.h"
#import "SettingsTableViewController.h"
#import "SettingsNavigationController.h"
#import "OptionPickersTableViewController.h"

@interface CoursesViewController : UIViewController <ClickRowDelegate, UINavigationControllerDelegate, SettingsTableViewControllerDelegate, UIPopoverControllerDelegate>
{
    NSManagedObjectContext *managedObjectContext;
    NSUInteger nextCourseId;
    
    id delegate;
    UIToolbar *toolbar;
    UISegmentedControl *segmentedControl;
    NSUInteger activeSegment;
    Header *header;
    UIScrollView *scrollView;
    NSMutableArray *coursesArray;
    
    UIPopoverController *settingsPopoverController;
    SettingsNavigationController *settingsNavController;
    BOOL popoverShowing;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property NSUInteger nextCourseId;

@property (nonatomic, assign) id delegate;
@property (nonatomic, retain) UIToolbar *toolbar;
@property (nonatomic, retain) UISegmentedControl *segmentedControl;
@property NSUInteger activeSegment;
@property (nonatomic, retain) Header *header;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) NSMutableArray *coursesArray;

@property (nonatomic, retain) UIPopoverController *settingsPopoverController;
@property (nonatomic, retain) SettingsNavigationController *settingsNavController;
@property BOOL popoverShowing;

- (void)initCourses;
- (void)didTouchSettings;
- (void)didTouchSegmentedControl;

@end

@protocol CoursesViewControllerDelegate <NSObject>

- (void)didTouchCoursesList;
- (void)didTouchCoursesHistory;
- (void)loadDailyEditViewForCourse:(Course *)course andDate:(NSDate *)date;
- (void)loadCourseViewControllerForCourse:(Course *)course;

@end
