//
//  CourseViewController.h
//  Ob Log
//
//  Created by David Alkire on 10/6/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CoreDataHelperFunctions.h"
#import "AddStudentViewController.h"
#import "Header.h"
#import "ClickRow.h"
#import "ColorTag.h"

@interface CourseViewController : UIViewController <ClickRowDelegate, AddStudentDelegate>
{
    NSManagedObjectContext *managedObjectContext;
    
    id delegate;
    
    UIToolbar *toolbar;
    Header *header;
    UIScrollView *scrollView;
    NSMutableArray *studentsArray;
    NSUInteger activeSegment;
    Course *course;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, assign) id delegate;

@property (nonatomic, retain) UIToolbar *toolbar;
@property (nonatomic, retain) UISegmentedControl *segmentedControl;
@property (nonatomic, retain) Header *header;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) NSMutableArray *studentsArray;
@property NSUInteger activeSegment;
@property (nonatomic, retain) Course *course;

- (id)initWithCourse:(Course *)course;
- (void)didTouchSegmentedControl;
- (void)didTouchCoursesBtn;
- (void)initStudents;
- (void)addStudentModal;

@end 

@protocol CourseViewControllerDelegate <NSObject>

- (void)loadCoursesViewController;
- (void)loadDailyEditViewForCourse:(Course *)course andDate:(NSDate *)date;

@end