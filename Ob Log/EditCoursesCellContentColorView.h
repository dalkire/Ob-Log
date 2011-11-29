//
//  EditCoursesCellContentColorView.h
//  Ob Log
//
//  Created by David Alkire on 11/25/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditCoursesCellContentColorView : UIView
{
    id delegate;
}

@property (nonatomic, assign) id delegate;

- (id)initWithColor:(UIColor *)color;

@end

@protocol EditCoursesCellContentColorDelegate <NSObject>

- (void)didTouchColorSquare;

@end
