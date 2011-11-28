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
#import "Theme.h"

@interface EditCoursesCellContentView : UIView
{
    Course *course;
    EditCoursesCellContentColorView *colorSquare;
    UITextField *titleField;
}

@property (nonatomic, retain) Course *course;
@property (nonatomic, retain) EditCoursesCellContentColorView *colorSquare;
@property (nonatomic, retain) UITextField *titleField;

- (id)initWithCourse:(Course *)crse;

@end
