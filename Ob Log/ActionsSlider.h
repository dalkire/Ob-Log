//
//  ActionsSlider.h
//  ObLog
//
//  Created by David Alkire on 9/21/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionButton.h"
#import "OptionsScroll.h"

@interface ActionsSlider : UIView
{
    OptionsScroll *optionsScroll;
    ActionButton *toggle;
}

@property (nonatomic, retain) OptionsScroll *optionsScroll;
@property (nonatomic, retain) ActionButton *toggle;

@end
