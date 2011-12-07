//
//  EditStudentsTableViewController.h
//  Ob Log
//
//  Created by David Alkire on 11/17/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataHelperFunctions.h"
#import "Course.h"
#import "Student.h"

@interface EditStudentsTableViewController : UITableViewController <UITextFieldDelegate>
{
    NSManagedObjectContext *managedObjectContext;
    Course *course;
    NSMutableArray *studentsArray;
    NSMutableArray *studentsCoreDataArray;
    BOOL myEditing;
    BOOL mayAddRow;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) Course *course;
@property (nonatomic, retain) NSMutableArray *studentsArray;
@property (nonatomic, retain) NSMutableArray *studentsCoreDataArray;
@property BOOL mayAddRow;

- (id)initWithStyle:(UITableViewStyle)style andCourse:(Course *)crs;
- (void)loadStudentsArray;
- (void)didTouchEditButton;
- (void)didTouchDoneButton;
- (void)saveStudents;

@end
