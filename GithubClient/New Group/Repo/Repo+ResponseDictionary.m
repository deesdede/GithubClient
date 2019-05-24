//
//  Repo+ResponseDictionary.m
//  GithubClient
//
//  Created by qwerty on 24/03/2019.
//  Copyright © 2019 Yuriy Craft. All rights reserved.
//

#import "Repo+ResponseDictionary.h"
#import "User+ResponseDictionary.h"

@implementation Repo (ResponseDictionary)

- (void)populateFromResponseDictionary:(NSDictionary*)responseDictionary context:(NSManagedObjectContext*)context {
    self.idx = (NSNumber*)[responseDictionary objectForKey:@"id"];
    self.name = [responseDictionary objectForKey:@"full_name"] != [NSNull null] ? (NSString*)[responseDictionary objectForKey:@"full_name"] : nil;
    self.desc = [responseDictionary objectForKey:@"description"] != [NSNull null] ? (NSString*)[responseDictionary objectForKey:@"description"] : nil;
    NSNumber *count = (NSNumber*)[responseDictionary objectForKey:@"stargazers_count"];
    self.stargazers_count = count ? count : nil;
    if (!self.owner)
        self.owner = [User createInContext:context];
    [self.owner populateFromResponseDictionary:responseDictionary[@"owner"] context:context];
}

@end
