//
//  OptionChoice.h
//  Ob Log
//
//  Created by David Alkire on 10/11/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Entry;

@interface OptionChoice : NSManagedObject

@property (nonatomic, retain) NSNumber *position;
@property (nonatomic, retain) NSString * choiceText;
@property (nonatomic, retain) NSManagedObject *optionHeader;
@property (nonatomic, retain) NSSet *entries;
@end

@interface OptionChoice (CoreDataGeneratedAccessors)

- (void)addEntriesObject:(Entry *)value;
- (void)removeEntriesObject:(Entry *)value;
- (void)addEntries:(NSSet *)values;
- (void)removeEntries:(NSSet *)values;
@end
