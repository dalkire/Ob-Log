//
//  Row.h
//  Ob Log
//
//  Created by David Alkire on 9/25/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Row : UIView
{
    NSUInteger id;
    UIView *blueLine;
    UIView *marginLine;
}

@property NSUInteger id;
@property (nonatomic, retain) UIView *blueLine;
@property (nonatomic, retain) UIView *marginLine;

@end