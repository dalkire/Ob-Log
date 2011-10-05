//
//  NavigationController.h
//  Ob Log
//
//  Created by David Alkire on 10/2/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Theme.h"
#import "HomeViewController.h"
#import "ClassViewController.h"
#import "CoursesViewController.h"
#import "DailyEditViewController.h"

@interface NavigationController : UINavigationController
{
    NSManagedObjectContext *managedObjectContext;
    
    HomeViewController *homeViewController;
    ClassViewController *classViewController;
    CoursesViewController *coursesViewController;
    DailyEditViewController *viewController;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, retain) HomeViewController *homeViewController;
@property (nonatomic, retain) ClassViewController *classViewController;
@property (nonatomic, retain) CoursesViewController *coursesViewController;
@property (nonatomic, retain) DailyEditViewController *dailyEditViewController;

- (void)loadInitialViewControllers;
- (void)didTouchDoneFromDailyEditViewController;

@end
