//
//  OptionChoicesTableViewController.h
//  Ob Log
//
//  Created by David Alkire on 10/21/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CoreDataHelperFunctions.h"
#import "OptionHeader.h"
#import "OptionChoice.h"

@interface OptionChoicesTableViewController : UITableViewController <UITextFieldDelegate>
{
    NSManagedObjectContext *managedObjectContext;
    OptionHeader *optionHeader;
    NSMutableArray *optionChoicesCoreDataArray;
    NSMutableArray *optionChoicesArray;
    BOOL mayAddRow;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) OptionHeader *optionHeader;
@property (nonatomic, retain) NSMutableArray *optionChoicesCoreDataArray;
@property (nonatomic, retain) NSMutableArray *optionChoicesArray;
@property BOOL mayAddRow;

- (id)initWithStyle:(UITableViewStyle)style andOptionHeader:(OptionHeader *)oh;
- (void)saveOptionChoices;

@end
