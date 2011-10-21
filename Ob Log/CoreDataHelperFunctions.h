//
//  CoreDataHelperFunctions.h
//  Ob Log
//
//  Created by David Alkire on 10/21/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "OptionHeader.h"
#import "Course.h"
#import "Student.h"
#import "Entry.h"

@interface CoreDataHelperFunctions : NSObject

+ (NSMutableArray *)fetchCourses;
+ (NSMutableArray *)fetchStudentsForCourse:(Course *)crs;
+ (NSMutableArray *)fetchOptionChoicesForOptionHeader:(OptionHeader *)optionHeader;

@end
