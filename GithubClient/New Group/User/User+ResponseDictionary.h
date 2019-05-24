//
//  User+ResponseDictionary.h
//  GithubClient
//
//  Created by book on 26/03/2019.
//  Copyright © 2019 Yuriy Craft. All rights reserved.
//

#import "User+CoreDataClass.h"
#import "NSManagedObject+GithubClient.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (ResponseDictionary)

- (void)populateFromResponseDictionary:(NSDictionary*)responseDictionary context:(NSManagedObjectContext*)context;
@end

NS_ASSUME_NONNULL_END
