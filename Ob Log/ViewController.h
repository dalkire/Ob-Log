//
//  ViewController.h
//  Ob Log
//
//  Created by David Alkire on 9/22/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "DailyEditRow.h"
#import "NameCell.h"
#import "NoteCell.h"
#import "DateHeader.h"
#import "EditModalViewController.h"
#import "Container.h"

@interface ViewController : UIViewController
{
    UIImageView *bg;
    UIScrollView *scrollView;
    DateHeader *dateHeader;
    UIView *dateHeaderDropShadow;
    EditModalViewController *editModal;
}

@property (nonatomic, retain) UIImageView *bg;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) DateHeader *dateHeader;
@property (nonatomic, retain) UIView *dateHeaderDropShadow;
@property (nonatomic, retain) EditModalViewController *editModal;

- (void)initModalForUser:(NSUInteger)uid andDate:(NSDate *)date;
- (void)showOptionsForIndexPath:(NSIndexPath *)indexPath;

@end
