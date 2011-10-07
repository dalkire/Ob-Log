//
//  Course.h
//  Ob Log
//
//  Created by David Alkire on 10/3/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Course : NSManagedObject

@property (nonatomic, retain) NSNumber *id;
@property (nonatomic, retain) NSString *courseTitle;
@property (nonatomic, retain) NSNumber *colorR;
@property (nonatomic, retain) NSNumber *colorG;
@property (nonatomic, retain) NSNumber *colorB;

@end
