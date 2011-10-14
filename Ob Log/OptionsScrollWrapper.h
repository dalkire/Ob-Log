//
//  OptionsScrollWrapper.h
//  Ob Log
//
//  Created by David Alkire on 9/22/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "OptionsScroll.h"

@interface OptionsScrollWrapper : UIView
{
    __weak id dailyEditRow;
    
    OptionsScroll *optionsScroll;
    UIView *leftShadow;
    UIView *rightShadow;
}

@property (nonatomic, assign) __weak id dailyEditRow;

@property (nonatomic, retain) OptionsScroll *optionsScroll;
@property (nonatomic, retain) UIView *leftShadow;
@property (nonatomic, retain) UIView *rightShadow;

- (void)propagateDailyEditRow:(__weak id)der;

@end
