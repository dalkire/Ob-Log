//
//  ClassesViewController.h
//  Ob Log
//
//  Created by David Alkire on 10/2/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Item.h"
#import "AddClassViewController.h"
#import "Header.h"
#import "ClickRow.h"

@interface ClassesViewController : UIViewController <ClickRowDelegate>
{
    NSManagedObjectContext *managedObjectContext;
    
    Header *header;
    UIScrollView *scrollView;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, retain) Header *header;
@property (nonatomic, retain) UIScrollView *scrollView;

@end
