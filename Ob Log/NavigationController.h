//
//  NavigationController.h
//  Ob Log
//
//  Created by David Alkire on 10/2/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "ClassesViewController.h"
#import "DailyEditViewController.h"

@interface NavigationController : UINavigationController
{
    NSManagedObjectContext *managedObjectContext;
    
    HomeViewController *homeViewController;
    ClassesViewController *classesViewController;
    DailyEditViewController *viewController;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, retain) HomeViewController *homeViewController;
@property (nonatomic, retain) ClassesViewController *classesViewController;
@property (nonatomic, retain) DailyEditViewController *dailyEditViewController;

- (void)didTouchDoneFromDailyEditViewController;

@end
