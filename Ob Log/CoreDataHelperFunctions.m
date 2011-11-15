//
//  CoreDataHelperFunctions.m
//  Ob Log
//
//  Created by David Alkire on 10/21/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "CoreDataHelperFunctions.h"
#import "AppDelegate.h"

@implementation CoreDataHelperFunctions

+ (NSManagedObjectContext *)managedObjectContext
{
    return ((AppDelegate *)[[UIApplication sharedApplication] delegate]).managedObjectContext;
}

+ (NSMutableArray *)fetchCourses
{
    NSManagedObjectContext *moc = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).managedObjectContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Course" inManagedObjectContext:moc];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"courseTitle" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setEntity:entity];
    [request setSortDescriptors:sortDescriptors];
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[moc executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        NSLog(@"fetchResults error");
    }
    else {
        NSLog(@"fetchResults Success..");
        return mutableFetchResults;
    }
    
    return [NSMutableArray arrayWithCapacity:0];
}

+ (NSMutableArray *)fetchStudentsForCourse:(Course *)crs
{
    NSManagedObjectContext *moc = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).managedObjectContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:moc];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@ IN courses", crs];
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc]
                                         initWithKey:@"lastName" ascending:YES];
    NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc]
                                         initWithKey:@"firstName" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor1, sortDescriptor2, nil]];
    [sortDescriptor1 release];
    [sortDescriptor2 release];
    [request setEntity:entity];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[moc executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        NSLog(@"fetchResults error");
    }
    else {
        NSLog(@"fetchResults Success...");
        return mutableFetchResults;
    }
    
    return [NSMutableArray arrayWithCapacity:0];
}

+ (NSMutableArray *)fetchOptionChoicesForOptionHeader:(OptionHeader *)optionHeader
{
    NSManagedObjectContext *moc = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).managedObjectContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"OptionHeader" inManagedObjectContext:moc];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self == %@", optionHeader];
    [request setEntity:entity];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[moc executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        NSLog(@"fetchResults error");
    }
    else {
        NSLog(@"fetchResults Success.. ");
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"position" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        NSMutableArray *optionChoices = [NSMutableArray arrayWithArray:[[(OptionHeader *)[mutableFetchResults objectAtIndex:0] options] allObjects]];
        [optionChoices sortUsingDescriptors:sortDescriptors];
        
        return optionChoices;
    }
    
    return [NSMutableArray arrayWithCapacity:0];
}

@end
