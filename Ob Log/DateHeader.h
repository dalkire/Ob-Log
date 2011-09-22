//
//  DateHeader.h
//  oblog
//
//  Created by David Alkire on 9/20/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface DateHeader : UIView
{
    UILabel *dayOfWeek;
    UILabel *date;
}

@property (nonatomic, retain) UILabel *dayOfWeek;
@property (nonatomic, retain) UILabel *date;

- (void)assignDate:(NSDate *)date;

@end
