//
//  User+ResponseDictionary.m
//  GithubClient
//
//  Created by book on 26/03/2019.
//  Copyright © 2019 Yuriy Craft. All rights reserved.
//

#import "User+ResponseDictionary.h"

@implementation User (ResponseDictionary)

- (void)populateFromResponseDictionary:(NSDictionary*)responseDictionary context:(NSManagedObjectContext*)context {
    if (responseDictionary) {
        if ([self objectForKeyNotNull:@"id" inDict:responseDictionary])
        self.idx = (NSNumber*)[responseDictionary objectForKey:@"id"];
         if ([self objectForKeyNotNull:@"login" inDict:responseDictionary])
        self.name = (NSString*)[responseDictionary objectForKey:@"login"];
        if ([self objectForKeyNotNull:@"avatar_url" inDict:responseDictionary])
        self.avatar_url = (NSString*)[responseDictionary objectForKey:@"avatar_url"];
    }
}

- (id)objectForKeyNotNull:(NSString*)key inDict:(NSDictionary*)map {
    id object = [map objectForKey:key];
    if (object == [NSNull null])
        return nil;
    else
        return object;
}
@end
