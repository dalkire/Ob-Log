//
//  EditCoursesViewController.h
//  Ob Log
//
//  Created by David Alkire on 10/7/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"

@interface EditCoursesViewController : UITableViewController
{
    NSMutableArray *coursesArray;
}

@property (nonatomic, retain) NSMutableArray *coursesArray;

@end
