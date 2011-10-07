//
//  CourseViewController.h
//  Ob Log
//
//  Created by David Alkire on 10/6/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Course.h"
#import "AddStudentViewController.h"
#import "Header.h"
#import "ClickRow.h"
#import "ColorTag.h"

@interface CourseViewController : UIViewController <ClickRowDelegate, AddStudentDelegate>
{
    NSManagedObjectContext *managedObjectContext;
    NSUInteger nextStudentId;
    
    UIToolbar *toolbar;
    Header *header;
    UIScrollView *scrollView;
    NSMutableArray *studentsArray;
    NSUInteger activeSegment;
    Course *course;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property NSUInteger nextStudentId;

@property (nonatomic, retain) UIToolbar *toolbar;
@property (nonatomic, retain) UISegmentedControl *segmentedControl;
@property (nonatomic, retain) Header *header;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) NSMutableArray *studentsArray;
@property NSUInteger activeSegment;
@property (nonatomic, retain) Course *course;

- (id)initWithCourse:(Course *)course;
- (void)loadStudentsForCourse:(Course *)course;
- (void)initStudents;
- (void)addStudentModal;

@end 