//
//  ColorPicker.h
//  Ob Log
//
//  Created by David Alkire on 10/3/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorPicker : UIView
{
    UIView *colorPanel;
    
    NSNumber *rValue;
    NSNumber *gValue;
    NSNumber *bValue;
    
    UISlider *rSlider;
    UISlider *gSlider;
    UISlider *bSlider;
}

@property (nonatomic, retain) UIView *colorPanel;
@property (nonatomic, retain) UISlider *rSlider;
@property (nonatomic, retain) UISlider *gSlider;
@property (nonatomic, retain) UISlider *bSlider;

@end
