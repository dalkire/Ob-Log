//
//  Container.h
//  Ob Log
//
//  Created by David Alkire on 9/26/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DailyEditRow.h"

@interface Container : UIView
{
    DailyEditRow *mainRow;
}

@property (nonatomic, retain) DailyEditRow *mainRow;

@end
