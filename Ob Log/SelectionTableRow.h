//
//  SelectionTableRow.h
//  Ob Log
//
//  Created by David Alkire on 9/26/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Theme.h"

@interface SelectionTableRow : UIView
{
    UILabel *rowLabel;
    BOOL rowSelected;
}

@property (nonatomic, retain) UILabel *rowLabel;
@property BOOL rowSelected;

- (void)deselectRow;

@end
