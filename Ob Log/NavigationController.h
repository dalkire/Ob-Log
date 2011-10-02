//
//  NavigationController.h
//  Ob Log
//
//  Created by David Alkire on 10/2/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DailyEditViewController.h"

@interface NavigationController : UINavigationController
{
    DailyEditViewController *viewController;
    RootViewController *rootViewController;
}

@property (nonatomic, retain) DailyEditViewController *dailyEditViewController;

- (void)didTouchDone;

@end
