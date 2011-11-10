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

@interface OptionPickersTableViewController : UITableViewController <UITextFieldDelegate>
{
    NSManagedObjectContext *managedObjectContext;
    NSMutableArray *optionsArray;
    NSMutableArray *optionsCoreDataArray;
    BOOL myEditing;
    BOOL mayAddRow;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSMutableArray *optionsArray;
@property (nonatomic, retain) NSMutableArray *optionsCoreDataArray;
@property BOOL myEditing;
@property BOOL mayAddRow;

- (void)loadOptionPickers;
- (void)didTouchEditButton;
- (void)didTouchDoneButton;
- (void)saveOptionChoices;

@end
