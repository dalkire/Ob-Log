//
//  EditCoursesCellContentView.h
//  Ob Log
//
//  Created by David Alkire on 11/25/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"
#import "EditCoursesCellContentColorView.h"
#import "ColorPicker.h"
#import "CloseBtn.h"
#import "Theme.h"

@interface EditCoursesCellContentView : UIView <EditCoursesCellContentColorDelegate, CloseBtnDelegate, ColorPickerDelegate>
{
    id delegate;
    Course *course;
    EditCoursesCellContentColorView *colorSquare;
    UITextField *titleField;
    ColorPicker *colorPicker;
    CloseBtn *closeBtn;
}

@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) Course *course;
@property (nonatomic, retain) EditCoursesCellContentColorView *colorSquare;
@property (nonatomic, retain) UITextField *titleField;
@property (nonatomic, retain) ColorPicker *colorPicker;
@property (nonatomic, retain) CloseBtn *closeBtn;

- (id)initWithCourse:(Course *)crse;
- (void)showColorPicker;
- (void)hideColorPicker;

@end
