//
//  OptionHeader.h
//  Ob Log
//
//  Created by David Alkire on 10/19/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OptionChoice;

@interface OptionHeader : NSManagedObject

@property (nonatomic, retain) NSString * headerText;
@property (nonatomic, retain) NSSet *options;
@end

@interface OptionHeader (CoreDataGeneratedAccessors)

- (void)addOptionsObject:(OptionChoice *)value;
- (void)removeOptionsObject:(OptionChoice *)value;
- (void)addOptions:(NSSet *)values;
- (void)removeOptions:(NSSet *)values;
@end
