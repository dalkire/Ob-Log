//
//  PickerOptionsViewController.h
//  Ob Log
//
//  Created by David Alkire on 9/23/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerOptionsViewController : UITableViewController
{
    UITableView *tv;
    NSArray *arr;
    NSIndexPath *previousIndexPath;
    NSIndexPath *currentIndexPath;
    NSInteger previousIndex;
}

@property (nonatomic, retain) UITableView *tv;
@property (nonatomic, retain) NSArray *arr;
@property (nonatomic, retain) NSIndexPath *previousIndexPath;
@property (nonatomic, retain) NSIndexPath *currentIndexPath;
@property NSInteger previousIndex;

@end
