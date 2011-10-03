//
//  ClickRow.h
//  Ob Log
//
//  Created by David Alkire on 10/2/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Row.h"
#import "Theme.h"

@interface ClickRow : Row
{
    id delegate;
    UIView *cell;
    UILabel *mainLabel;
}

@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) UIView *cell;
@property (nonatomic, retain) UILabel *mainLabel;

- (void)setMainLabelText:(NSString *)text;

@end

@protocol ClickRowDelegate <NSObject>

- (void)didTouchClickRow:(ClickRow *)clickRow;

@end
