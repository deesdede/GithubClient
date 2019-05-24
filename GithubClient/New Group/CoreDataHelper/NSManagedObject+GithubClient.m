//
//  NSManagedObject+GithubClient.m
//  GithubClient
//
//  Created by qwerty on 24/03/2019.
//  Copyright © 2019 Yuriy Craft. All rights reserved.
//

#import "NSManagedObject+GithubClient.h"
#import "NSManagedObject+Request.h"
#import "NSFetchRequest+request.h"


@implementation NSManagedObject (GithubClient)

+ (id)objectWithId:(NSNumber*)idx inContext:(NSManagedObjectContext*)context relationshipKeyPathsForPrefetchingArray:(NSArray*)prefetchKeysArray {
    if (!idx)
        return nil;
    NSFetchRequest *request = [self requestForProperty:@"idx" withValue:idx inContext:context];
    if (prefetchKeysArray)
        request.relationshipKeyPathsForPrefetching = prefetchKeysArray;
    request.returnsObjectsAsFaults = NO;
    return [request requestedFirstInContext:context];
}

+ (id)objectWithPropertyName:(NSString*)propertyName andValue:(id)value inContext:(NSManagedObjectContext*)context relationshipKeyPathsForPrefetchingArray:(NSArray*)prefetchKeysArray {
    if (!value)
        return nil;
    NSFetchRequest *request = [self requestForProperty:propertyName withValue:value inContext:context];
    if (prefetchKeysArray)
        request.relationshipKeyPathsForPrefetching = prefetchKeysArray;
    request.returnsObjectsAsFaults = NO;
    return [request requestedFirstInContext:context];
}

+ (id)createInContext:(NSManagedObjectContext*)context {
    return [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(self) inManagedObjectContext:context];
}

- (void)deleteInContext:(NSManagedObjectContext*)context {
    [context deleteObject:self];
}

+ (void)deleteWithPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [self requestWithPredicate:predicate inContext:context];
    request.includesPropertyValues = NO;
    request.returnsObjectsAsFaults = YES;
    NSArray *objects = [request requestedAllInContext:context];
    for (NSManagedObject *object in objects)
        [context deleteObject:object];
}

+ (void)deleteAllInContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [self requestInContext:context];
    request.includesPropertyValues = NO;
    request.returnsObjectsAsFaults = YES;
    NSArray *objects = [request requestedAllInContext:context];
    for (NSManagedObject *object in objects)
        [context deleteObject:object];
}


@end
