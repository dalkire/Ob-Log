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
#import "AddClassViewController.h"
#import "Header.h"
#import "ClickRow.h"
#import "ColorTag.h"
#import "Toolbar.h"
#import "DailyEditViewController.h"
#import "AddStudentViewController.h"

@interface CoursesViewController : UIViewController <ClickRowDelegate, AddCourseDelegate>
{
    NSManagedObjectContext *managedObjectContext;
    NSUInteger nextCourseId;
    
    UIToolbar *toolbar;
    UISegmentedControl *segmentedControl;
    NSUInteger activeSegment;
    Header *header;
    UIScrollView *scrollView;
    NSMutableArray *coursesArray;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property NSUInteger nextCourseId;

@property (nonatomic, retain) UIToolbar *toolbar;
@property (nonatomic, retain) UISegmentedControl *segmentedControl;
@property NSUInteger activeSegment;
@property (nonatomic, retain) Header *header;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) NSMutableArray *coursesArray;

- (void)didTouchSegmentedControl;
- (void)addCourseModal;

@end
