//
//  SelectionTable.h
//  Ob Log
//
//  Created by David Alkire on 9/26/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectionTableRow.h"

@interface SelectionTable : UIView
{
    NSMutableArray *optionsArray;
}

@property (nonatomic, retain) NSMutableArray *optionsArray;

- (void)createTableWithOptions:(NSMutableArray *)options;

@end
