//
//  Entry.h
//  Ob Log
//
//  Created by David Alkire on 10/7/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entry : NSManagedObject

@property (nonatomic, retain) NSNumber * courseId;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * noteText;
@property (nonatomic, retain) NSNumber * studentId;

@end
