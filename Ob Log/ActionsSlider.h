//
//  ActionsSlider.h
//  ObLog
//
//  Created by David Alkire on 9/21/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionButton.h"

@interface ActionsSlider : UIView
{
    ActionButton *toggle;
}

@property (nonatomic, retain) ActionButton *toggle;

@end
