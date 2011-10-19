//
//  OptionPickersTableViewController.h
//  Ob Log
//
//  Created by David Alkire on 10/18/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "OptionHeader.h"

@interface OptionPickersTableViewController : UITableViewController
{
    NSManagedObjectContext *managedObjectContext;
    NSMutableArray *optionsArray;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSMutableArray *optionsArray;

- (void)loadOptionPickers;
- (void)didTouchEditButton;

@end
