//
//  NSManagedObject+Request.h
//  GithubClient
//
//  Created by qwerty on 24/03/2019.
//  Copyright © 2019 Yuriy Craft. All rights reserved.
//

#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSManagedObject (Request)

+ (NSFetchRequest*)requestInContext:(NSManagedObjectContext *)context;
+ (NSFetchRequest*)requestWithPredicate:(NSPredicate *)searchTerm inContext:(NSManagedObjectContext *)context;
+ (NSFetchRequest*)requestForProperty:(NSString *)property withValue:(id)value inContext:(NSManagedObjectContext *)context;
+ (NSFetchRequest*)requestSortedBy:(NSArray<NSString*>*)sortKeys ascending:(BOOL)ascending withPredicate:(NSPredicate *)searchTerm inContext:(NSManagedObjectContext *)context;
@end

NS_ASSUME_NONNULL_END
