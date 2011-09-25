//
//  ShortCell.h
//  oblog
//
//  Created by David Alkire on 9/20/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cell.h"
#import "ViewController.h"

@interface ShortCell : Cell
{
    UIViewController *controller;
    UILabel *name;
}

@property (nonatomic, retain) UIViewController *controller;
@property (nonatomic, retain) UILabel *name;

@end
