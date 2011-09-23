//
//  OptionsScroll.h
//  Ob Log
//
//  Created by David Alkire on 9/22/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OptionPicker.h"

@interface OptionsScroll : UIScrollView
{
    NSMutableArray *pickers;
}

@property (nonatomic, retain) NSMutableArray *pickers;

- (void)addOptionPicker:(OptionPicker *)picker;

@end
