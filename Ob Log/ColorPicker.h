//
//  ColorPicker.h
//  Ob Log
//
//  Created by David Alkire on 10/3/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Theme.h"
#import "ColorSlider.h"

@interface ColorPicker : UIView <ColorSliderDelegate>
{
    id delegate;
    
    ColorSlider *rSlider;
    ColorSlider *gSlider;
    ColorSlider *bSlider;
}

@property (nonatomic, retain) id delegate;

@property (nonatomic, retain) ColorSlider *rSlider;
@property (nonatomic, retain) ColorSlider *gSlider;
@property (nonatomic, retain) ColorSlider *bSlider;

@end

@protocol ColorPickerDelegate <NSObject>

- (void)didSelectRed:(float)red green:(float)green blue:(float)blue;

@end