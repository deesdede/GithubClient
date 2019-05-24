//
//  Repo+ResponseDictionary.h
//  GithubClient
//
//  Created by qwerty on 24/03/2019.
//  Copyright © 2019 Yuriy Craft. All rights reserved.
//

#import "Repo+CoreDataClass.h"
#import "NSManagedObject+GithubClient.h"

NS_ASSUME_NONNULL_BEGIN

@interface Repo (ResponseDictionary)

- (void)populateFromResponseDictionary:(NSDictionary*)responseDictionary context:(NSManagedObjectContext*)context;
@end

NS_ASSUME_NONNULL_END
