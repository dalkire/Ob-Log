//
//  OptionPicker.h
//  Ob Log
//
//  Created by David Alkire on 9/22/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface OptionPicker : UIView
{
    
}

+ (OptionPicker *)pickerWithHeader:(NSString *)header andOptions:(NSArray *)options;

@end
