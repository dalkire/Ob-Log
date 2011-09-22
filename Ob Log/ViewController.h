//
//  ViewController.h
//  Ob Log
//
//  Created by David Alkire on 9/22/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShortCell.h"
#import "NoteCell.h"
#import "DateHeader.h"

@interface ViewController : UIViewController
{
    UIImageView *bg;
    UIScrollView *scrollView;
    DateHeader *dateHeader;
}

@property (nonatomic, retain) UIImageView *bg;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) DateHeader *dateHeader;

@end
