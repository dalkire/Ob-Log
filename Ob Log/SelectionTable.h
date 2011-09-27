//
//  SelectionTable.h
//  Ob Log
//
//  Created by David Alkire on 9/26/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SelectionTableRow.h"

@interface SelectionTable : UIView
{
    NSMutableArray *optionsArray;
    UIView *topShadow;
    UIView *bottomShadow;
    NSMutableArray *rowsArray;
}

@property (nonatomic, retain) NSMutableArray *optionsArray;
@property (nonatomic, retain) UIView *topShadow;
@property (nonatomic, retain) UIView *bottomShadow;
@property (nonatomic, retain) NSMutableArray *rowsArray;

- (void)deselectRows;
- (void)createTableWithOptions:(NSMutableArray *)options;

@end
