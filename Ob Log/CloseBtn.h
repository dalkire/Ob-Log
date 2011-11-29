//
//  CloseBtn.h
//  Ob Log
//
//  Created by David Alkire on 11/29/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CloseBtn : UIView
{
    id delegate;
}

@property (nonatomic, assign) id delegate;

@end

@protocol CloseBtnDelegate <NSObject>

- (void)didTouchCloseBtn;

@end
