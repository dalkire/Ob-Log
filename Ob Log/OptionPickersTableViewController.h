//
//  OptionPickersTableViewController.h
//  Ob Log
//
//  Created by David Alkire on 10/18/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OptionPickersTableViewController : UITableViewController
{
    NSMutableArray *optionsArray;
}

@property (nonatomic, retain) NSMutableArray *optionsArray;

@end
