//
//  ActionsSlider.h
//  ObLog
//
//  Created by David Alkire on 9/21/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionButton.h"
#import "OptionsScrollWrapper.h"

@interface ActionsSlider : UIView
{
    OptionsScrollWrapper *optionsScrollWrapper;
    ActionButton *toggle;
}

@property (nonatomic, retain) OptionsScrollWrapper *optionsScrollWrapper;
@property (nonatomic, retain) ActionButton *toggle;

@end
