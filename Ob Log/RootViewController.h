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

@interface RootViewController : UIViewController <CoursesViewControllerDelegate>
{
    NSManagedObjectContext *managedObjectContext;
    CoursesViewController *coursesViewController;
    DailyEditViewController *dailyEditViewController;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) CoursesViewController *coursesViewController;
@property (nonatomic, retain) DailyEditViewController *dailyEditViewController;

- (void)initContext;

@end
