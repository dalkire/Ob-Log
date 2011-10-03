//
//  AddClassViewController.h
//  Ob Log
//
//  Created by David Alkire on 10/2/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@interface AddClassViewController : UIViewController
{
    Header *header;
    UITextField *textField;
    UIButton *cancelBtn;
    UIButton *submitBtn;
}

@property (nonatomic, retain) Header *header;
@property (nonatomic, retain) UITextField *textField;
@property (nonatomic, retain) UIButton *cancelBtn;
@property (nonatomic, retain) UIButton *submitBtn;

- (void)touchedCancel;
- (void)touchedSubmit;

@end
