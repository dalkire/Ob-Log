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
    id delegate;
    
    UILabel *rowLabel;
    BOOL active;
}

@property (nonatomic, retain) id delegate;

@property (nonatomic, retain) UILabel *rowLabel;
@property BOOL active;

- (void)deselectRow;

@end

@protocol SelectionTableRowDelegate

- (void)didSelectSelectionTableRow:(SelectionTableRow *)row;

@end
