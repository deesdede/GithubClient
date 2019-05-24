//
//  NSManagedObject+Request.m
//  GithubClient
//
//  Created by qwerty on 24/03/2019.
//  Copyright © 2019 Yuriy Craft. All rights reserved.
//

#import "NSManagedObject+Request.h"

@implementation NSManagedObject (Request)

+ (NSFetchRequest*)requestInContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:NSStringFromClass(self) inManagedObjectContext:context]];
    return request;
}

+ (NSFetchRequest*)requestWithPredicate:(NSPredicate *)searchTerm inContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [self requestInContext:context];
    [request setPredicate:searchTerm];
    return request;
}

+ (NSFetchRequest*)requestForProperty:(NSString *)property withValue:(id)value inContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [self requestInContext:context];
    [request setPredicate:[NSPredicate predicateWithFormat:@"%K = %@", property, value]];
    return request;
}

+ (NSFetchRequest*)requestSortedBy:(NSArray<NSString*>*)sortKeys ascending:(BOOL)ascending withPredicate:(NSPredicate *)searchTerm inContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [self requestWithPredicate:searchTerm inContext:context];
    NSMutableArray* sortDescriptors = [[NSMutableArray alloc] initWithCapacity:sortKeys.count];
    for (NSString* sortKey in sortKeys)
        [sortDescriptors addObject:[[NSSortDescriptor alloc] initWithKey:sortKey ascending:ascending]];
    [request setSortDescriptors:sortDescriptors];
    return request;
}

@end
