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
    UILabel *nameLabel;
}

@property (nonatomic, retain) UILabel *nameLabel;

- (id)initWithFrame:(CGRect)frame andName:(NSString *)name;

@end
