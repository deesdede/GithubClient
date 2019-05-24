//
//  NSFetchRequest+request.m
//  GithubClient
//
//  Created by qwerty on 24/03/2019.
//  Copyright © 2019 Yuriy Craft. All rights reserved.
//

#import "NSFetchRequest+request.h"

@implementation NSFetchRequest (request)

- (NSUInteger)fetchedCountInContext:(NSManagedObjectContext*)context {
    NSError *error = nil;
    NSUInteger count = [context countForFetchRequest:self error:&error];
    if (error)
        NSLog(@"ERROR : %@", error.description);
    return count;
}


- (NSArray*)requestedAllInContext:(NSManagedObjectContext*)context {
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:self error:&error];
    if (error)
        NSLog(@"ERROR : %@", error.description);
    return results;
}


- (id)requestedFirstInContext:(NSManagedObjectContext*)context {
    [self setFetchLimit:1];
    NSArray *results = [self requestedAllInContext:context];
    if (results && [results count] > 0)
        return [results objectAtIndex:0];
    return nil;
}

@end
