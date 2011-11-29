//
//  ColorPicker.h
//  Ob Log
//
//  Created by David Alkire on 11/28/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Theme.h"

@interface ColorPicker : UIView
{
    id delegate;
    UIImageView *slider;
}

@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) UIImageView *slider;

@end

@protocol ColorPickerDelegate <NSObject>

- (void)selectedColor:(UIColor *)color;

@end
