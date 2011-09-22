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

@interface OptionsScroll : UIScrollView
{
    
}

- (void)addOptionPicker:(OptionPicker *)picker;

@end
