//
//  Header.h
//  Ob Log
//
//  Created by David Alkire on 10/2/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "Theme.h"

@interface Header : UIView
{
    UILabel *maintitleLabel;
    UILabel *subtitleLabel;
    UIView *gradientOverlay;
    UIView *dropShadow;
}

@property (nonatomic, retain) UILabel *maintitleLabel;
@property (nonatomic, retain) UILabel *subtitleLabel;
@property (nonatomic, retain) UIView *dropShadow;

- (void)setMaintitleLabelText:(NSString *)title;
- (void)setSubtitleLabelText:(NSString *)title;

@end
