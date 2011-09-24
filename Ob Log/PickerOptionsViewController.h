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
    NSMutableArray *arr;
    NSString *popoverHeader;
    NSIndexPath *previousIndexPath;
    NSIndexPath *currentIndexPath;
    NSInteger previousIndex;
}

@property (nonatomic, retain) UITableView *tv;
@property (nonatomic, retain) NSMutableArray *arr;
@property (nonatomic, retain) NSString *popoverHeader;
@property (nonatomic, retain) NSIndexPath *previousIndexPath;
@property (nonatomic, retain) NSIndexPath *currentIndexPath;
@property NSInteger previousIndex;

- (void)assignOptionsArray:(NSMutableArray *)options withHeader:(NSString *)header;

@end
