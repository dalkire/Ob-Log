//
//  CoursesViewController.h
//  Ob Log
//
//  Created by David Alkire on 10/5/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Course.h"
#import "AddCourseViewController.h"
#import "Header.h"
#import "ClickRow.h"
#import "ColorTag.h"
#import "Toolbar.h"
#import "DailyEditViewController.h"
#import "AddStudentViewController.h"
#import "EditNavController.h"
#import "EditCoursesViewController.h"

@interface CoursesViewController : UIViewController <ClickRowDelegate, AddCourseDelegate, UINavigationControllerDelegate>
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

- (void)initCourses;
- (void)didTouchSegmentedControl;
- (void)addCourseModal;

@end

@protocol CoursesViewControllerDelegate <NSObject>

- (void)didTouchCoursesList;
- (void)didTouchCoursesHistory;
- (void)loadDailyEditViewForCourse:(Course *)course andDate:(NSDate *)date;
- (void)loadCourseViewControllerForCourse:(Course *)course;

@end
