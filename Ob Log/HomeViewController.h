//
//  HomeViewController.h
//  Ob Log
//
//  Created by David Alkire on 10/2/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Theme.h"
#import "Header.h"
#import "ClickRow.h"

@interface HomeViewController : UIViewController <ClickRowDelegate>
{
    Header *header;
}

@property (nonatomic, retain) Header *header;

- (void)finishRow:(ClickRow *)row;

@end
