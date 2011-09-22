//
//  OptionsScroll.h
//  Ob Log
//
//  Created by David Alkire on 9/22/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "OptionPicker.h"

@interface OptionsScroll : UIView
{
    UIScrollView *scrollView;
    UIView *leftShadow;
    UIView *rightShadow;
}

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIView *leftShadow;
@property (nonatomic, retain) UIView *rightShadow;

- (void)addOptionPicker:(OptionPicker *)picker;

@end
