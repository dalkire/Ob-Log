//
//  SelectionTableRow.h
//  Ob Log
//
//  Created by David Alkire on 9/26/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Theme.h"
#import "SelectionTableRowDelegate.h"

@interface SelectionTableRow : UIView
{
    id delegate;
    UILabel *rowLabel;
    BOOL rowSelected;
    id<SelectionTableRowDelegate> picker;
}

@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) UILabel *rowLabel;
@property BOOL rowSelected;

- (void)deselectRow;

@end

@protocol SelectionTableRowDelegate

- (void)didSelectRow:(SelectionTableRow *)row;

@end
