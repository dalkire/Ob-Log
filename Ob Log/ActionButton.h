//
//  ActionButton.h
//  ObLog
//
//  Created by David Alkire on 9/21/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActionButton : UIView
{
    UIImageView *icon;
    NSString *name;
    BOOL isExtended;
}

@property (nonatomic, retain) UIImageView *icon;
@property (nonatomic, retain) NSString *name;
@property BOOL isExtended;

- (void)createButtonOfType:(NSString *)type;

@end
