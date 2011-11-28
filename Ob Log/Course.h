//
//  Course.h
//  Ob Log
//
//  Created by David Alkire on 10/11/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Student;

@interface Course : NSManagedObject

@property (nonatomic, retain) NSNumber *position;
@property (nonatomic, retain) NSNumber * colorB;
@property (nonatomic, retain) NSNumber * colorG;
@property (nonatomic, retain) NSNumber * colorR;
@property (nonatomic, retain) NSString * courseTitle;
@property (nonatomic, retain) NSSet *students;
@end

@interface Course (CoreDataGeneratedAccessors)

- (void)addStudentsObject:(Student *)value;
- (void)removeStudentsObject:(Student *)value;
- (void)addStudents:(NSSet *)values;
- (void)removeStudents:(NSSet *)values;
@end
