//
//  ClassViewController.h
//  Ob Log
//
//  Created by David Alkire on 10/5/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Course.h"
#import "AddStudentViewController.h"
#import "Header.h"
#import "ClickRow.h"
#import "ColorTag.h"

@interface ClassViewController : UIViewController <ClickRowDelegate, AddStudentDelegate>
{
    NSManagedObjectContext *managedObjectContext;
    NSUInteger nextStudentId;
    
    UIToolbar *toolbar;
    Header *header;
    UIScrollView *scrollView;
    NSMutableArray *studentsArray;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property NSUInteger nextStudentId;

@property (nonatomic, retain) UIToolbar *toolbar;
@property (nonatomic, retain) UISegmentedControl *segmentedControl;
@property (nonatomic, retain) Header *header;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) NSMutableArray *studentsArray;

- (id)initWithCourse:(Course *)course;
- (void)addStudentModal;

@end 