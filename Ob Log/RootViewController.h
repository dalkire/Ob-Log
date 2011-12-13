//
//  RootViewController.h
//  Ob Log
//
//  Created by David Alkire on 10/6/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoursesViewController.h"
#import "DailyEditViewController.h"
#import "CourseViewController.h"
#import "HistoryEditViewController.h"

@interface RootViewController : UIViewController <CoursesViewControllerDelegate, CourseViewControllerDelegate, DailyEditViewControllerDelegate, HistoryEditViewControllerDelegate>
{
    NSManagedObjectContext *managedObjectContext;
    
    NSUInteger currentViewController;
    CoursesViewController *coursesViewController;
    DailyEditViewController *dailyEditViewController;
    CourseViewController *courseViewController;
    HistoryEditViewController *historyEditViewController;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property NSUInteger currentViewController;
@property (nonatomic, retain) CoursesViewController *coursesViewController;
@property (nonatomic, retain) DailyEditViewController *dailyEditViewController;
@property (nonatomic, retain) CourseViewController *courseViewController;
@property (nonatomic, retain) HistoryEditViewController *historyEditViewController;

- (void)initContext;

@end
