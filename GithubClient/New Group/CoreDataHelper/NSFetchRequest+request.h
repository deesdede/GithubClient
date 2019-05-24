//
//  NSFetchRequest+request.h
//  GithubClient
//
//  Created by qwerty on 24/03/2019.
//  Copyright © 2019 Yuriy Craft. All rights reserved.
//

#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFetchRequest (request)

- (NSUInteger)fetchedCountInContext:(NSManagedObjectContext*)context;
- (NSArray*)requestedAllInContext:(NSManagedObjectContext*)context;
- (id)requestedFirstInContext:(NSManagedObjectContext*)context;
@end

NS_ASSUME_NONNULL_END
