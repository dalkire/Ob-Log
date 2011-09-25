//
//  EditModalViewController.h
//  Ob Log
//
//  Created by David Alkire on 9/24/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OptionsScrollWrapper.h"

@interface EditModalViewController : UIViewController
{
    UINavigationBar *navBar;
    OptionsScrollWrapper *optionsScrollWrapper;
    UIScrollView *notesScroll;
    UITextView *notes;
}

@property (nonatomic, retain) UINavigationBar *navBar;
@property (nonatomic, retain) OptionsScrollWrapper *optionsScrollWrapper;
@property (nonatomic, retain) UIScrollView *notesScroll;
@property (nonatomic, retain) UITextView *notes;

@end