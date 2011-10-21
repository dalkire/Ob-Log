//
//  OptionChoicesTableViewController.h
//  Ob Log
//
//  Created by David Alkire on 10/21/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "OptionHeader.h"
#import "OptionChoice.h"

@interface OptionChoicesTableViewController : UITableViewController
{
    OptionHeader *optionHeader;
    NSMutableArray *optionChoices;
}

@property (nonatomic, retain) OptionHeader *optionHeader;
@property (nonatomic, retain) NSMutableArray *optionChoices;

- (id)initWithStyle:(UITableViewStyle)style andOptionHeader:(OptionHeader *)oh;
- (NSMutableArray *)loadOptionChoices;

@end
