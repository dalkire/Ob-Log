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
    BOOL myEditing;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSMutableArray *optionsArray;
@property BOOL myEditing;

- (void)loadOptionPickers;
- (void)didTouchEditButton;
- (void)didTouchDoneButton;

@end
