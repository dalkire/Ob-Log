//
//  SettingsTableViewController.h
//  Ob Log
//
//  Created by David Alkire on 10/18/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsTableViewController : UITableViewController
{
    __weak id delegate;
    NSArray *settingsArray;
}

@property (nonatomic, assign) __weak id delegate;
@property (nonatomic, retain) NSArray *settingsArray;

@end

@protocol SettingsTableViewControllerDelegate <NSObject>
        
- (void)selectedOptionPickersRow;

@end