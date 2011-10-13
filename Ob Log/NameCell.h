//
//  NameCell.h
//  Ob Log
//
//  Created by David Alkire on 9/25/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NameCell : UIView
{
    id dailyEditRow;
    UILabel *nameLabel;
}

@property (nonatomic, assign) __weak id dailyEditRow;
@property (nonatomic, retain) UILabel *nameLabel;

- (id)initWithFrame:(CGRect)frame andName:(NSString *)name;

@end
