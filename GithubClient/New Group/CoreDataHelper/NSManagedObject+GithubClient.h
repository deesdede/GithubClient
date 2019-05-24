//
//  NSManagedObject+GithubClient.h
//  GithubClient
//
//  Created by qwerty on 24/03/2019.
//  Copyright © 2019 Yuriy Craft. All rights reserved.
//

#import <CoreData/CoreData.h>
@class Repo;

NS_ASSUME_NONNULL_BEGIN

@interface NSManagedObject (GithubClient)

+ (id)createInContext:(NSManagedObjectContext*)context;
+ (void)deleteWithPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context;
- (void)deleteInContext:(NSManagedObjectContext*)context;
+ (void)deleteAllInContext:(NSManagedObjectContext *)context;

+ (id)objectWithId:(NSNumber*)idx inContext:(NSManagedObjectContext*)context relationshipKeyPathsForPrefetchingArray:(NSArray*)prefetchKeysArray;
+ (id)objectWithPropertyName:(NSString*)propertyName andValue:(id)value inContext:(NSManagedObjectContext*)context relationshipKeyPathsForPrefetchingArray:(NSArray*)prefetchKeysArray;
@end

NS_ASSUME_NONNULL_END
