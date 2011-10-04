//
//  ClassesViewController.h
//  Ob Log
//
//  Created by David Alkire on 10/2/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Course.h"
#import "AddClassViewController.h"
#import "Header.h"
#import "ClickRow.h"

@interface ClassesViewController : UIViewController <ClickRowDelegate, AddCourseDelegate>
{
    NSManagedObjectContext *managedObjectContext;
    NSUInteger nextCourseId;
    
    Header *header;
    UIScrollView *scrollView;
    NSMutableArray *coursesArray;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property NSUInteger nextCourseId;

@property (nonatomic, retain) Header *header;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) NSMutableArray *coursesArray;

- (void)addCourseModal;

@end
