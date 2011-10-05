//
//  Student.h
//  Ob Log
//
//  Created by David Alkire on 10/5/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Student : NSManagedObject

@property (nonatomic, retain) NSString * last_name;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * first_name;

@end
