//
//  OptionsPopoverTableViewController.h
//  Ob Log
//
//  Created by David Alkire on 10/3/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OptionsPopoverTableViewController : UITableViewController
{
    id delegate;
    NSMutableArray *optionsArray;
}

@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) NSMutableArray *optionsArray;

@end

@protocol OptionsPopoverTVCDelegate <NSObject>

- (void)didSelectOptionRowAtIndexPath:(NSIndexPath *)indexPath;

@end