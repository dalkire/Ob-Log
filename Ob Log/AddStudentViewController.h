//
//  AddStudentViewController.h
//  Ob Log
//
//  Created by David Alkire on 10/5/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#import "Student.h"

@interface AddStudentViewController : UIViewController
{
    id delegate;
    Header *header;
    UITextField *firstNameTextField;
    UITextField *lastNameTextField;
    UIButton *cancelBtn;
    UIButton *submitBtn;
}

@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) Header *header;
@property (nonatomic, retain) UITextField *firstNameTextField;
@property (nonatomic, retain) UITextField *lastNameTextField;
@property (nonatomic, retain) UIButton *cancelBtn;
@property (nonatomic, retain) UIButton *submitBtn;

- (void)touchedCancel;
- (void)touchedSubmit;

@end

@protocol AddStudentDelegate <NSObject>

- (void)addStudentWithFirstName:(NSString *)first lastName:(NSString *)last;

@end
