//
//  DateHeader.h
//  oblog
//
//  Created by David Alkire on 9/20/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>
#import "Theme.h"

@interface DateHeader : UIView
{
    UILabel *dateTitle;
    UILabel *sectionSubtitle;
}

@property (nonatomic, retain) UILabel *dateTitle;
@property (nonatomic, retain) UILabel *sectionSubtitle;

- (void)assignDateTitle:(NSDate *)date;

@end
