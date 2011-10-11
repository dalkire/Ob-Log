//
//  Entry.h
//  Ob Log
//
//  Created by David Alkire on 10/11/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Student;

@interface Entry : NSManagedObject

@property (nonatomic, retain) NSNumber * courseId;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * noteText;
@property (nonatomic, retain) Student *student;
@property (nonatomic, retain) NSSet *options;
@end

@interface Entry (CoreDataGeneratedAccessors)

- (void)addOptionsObject:(NSManagedObject *)value;
- (void)removeOptionsObject:(NSManagedObject *)value;
- (void)addOptions:(NSSet *)values;
- (void)removeOptions:(NSSet *)values;
@end
