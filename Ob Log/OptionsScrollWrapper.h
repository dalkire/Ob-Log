//
//  OptionsScrollWrapper.h
//  Ob Log
//
//  Created by David Alkire on 9/22/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OptionsScroll.h"

@interface OptionsScrollWrapper : UIView
{
    OptionsScroll *optionsScroll;
    UIView *leftShadow;
    UIView *rightShadow;
}

@property (nonatomic, retain) OptionsScroll *optionsScroll;
@property (nonatomic, retain) UIView *leftShadow;
@property (nonatomic, retain) UIView *rightShadow;

@end
