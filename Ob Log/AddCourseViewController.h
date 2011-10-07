//
//  AddClassViewController.h
//  Ob Log
//
//  Created by David Alkire on 10/2/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#import "Course.h"
#import "ColorPicker.h"

@interface AddCourseViewController : UIViewController <ColorPickerDelegate>
{
    id delegate;
    Header *header;
    UITextField *textField;
    ColorPicker *colorPicker;
    UIButton *cancelBtn;
    UIButton *submitBtn;
}

@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) Header *header;
@property (nonatomic, retain) UITextField *textField;
@property (nonatomic, retain) ColorPicker *colorPicker;
@property (nonatomic, retain) UIButton *cancelBtn;
@property (nonatomic, retain) UIButton *submitBtn;

- (void)touchedCancel;
- (void)touchedSubmit;

@end

@protocol AddCourseDelegate <NSObject>

- (void)addCourseWithTitle:(NSString *)courseTitle andRed:(float)red green:(float)green blue:(float)blue;

@end