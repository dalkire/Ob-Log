//
//  ColorSlider.h
//  Ob Log
//
//  Created by David Alkire on 10/3/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorSlider : UISlider
{
    id delegate;
    UILabel *colorLabel;
    UILabel *valueLabel;
}

@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) UILabel *colorLabel;
@property (nonatomic, retain) UILabel *valueLabel;

@end

@protocol ColorSliderDelegate <NSObject>

- (void)movedSlider;

@end
