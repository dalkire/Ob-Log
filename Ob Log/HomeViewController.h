//
//  HomeViewController.h
//  Ob Log
//
//  Created by David Alkire on 10/2/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@interface HomeViewController : UIViewController
{
    Header *header;
}

@property (nonatomic, retain) Header *header;

@end
