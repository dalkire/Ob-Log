//
//  Entry.h
//  Ob Log
//
//  Created by David Alkire on 10/5/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entry : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * studentId;
@property (nonatomic, retain) NSString * noteText;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * courseId;

@end
