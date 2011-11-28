//
//  EditCoursesTableViewController.h
//  Ob Log
//
//  Created by David Alkire on 10/7/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CoreDataHelperFunctions.h"
#import "Course.h"
#import "EditCoursesCellContentView.h"

@interface EditCoursesTableViewController : UITableViewController <UITextFieldDelegate>
{
    NSManagedObjectContext *managedObjectContext;
    NSMutableArray *coursesArray;
    NSMutableArray *coursesCoreDataArray;
    BOOL mayAddRow;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSMutableArray *coursesArray;
@property (nonatomic, retain) NSMutableArray *coursesCoreDataArray;
@property BOOL mayAddRow;

- (void)didTouchEditButton;
- (void)didTouchDoneButton;
- (void)saveCourses;

@end
