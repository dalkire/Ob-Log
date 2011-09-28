//
//  SelectionTableRowDelegate.h
//  Ob Log
//
//  Created by David Alkire on 9/28/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SelectionTableRowDelegate <NSObject>

- (void)didSelectOption:(NSString *)option;

@end
