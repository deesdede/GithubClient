//
//  Commit+ResponseDictionary.m
//  GithubClient
//
//  Created by book on 26/03/2019.
//  Copyright © 2019 Yuriy Craft. All rights reserved.
//

#import "Commit+ResponseDictionary.h"
#import "User+ResponseDictionary.h"

@implementation Commit (ResponseDictionary)

- (void)populateFromResponseDictionary:(NSDictionary*)responseDictionary context:(NSManagedObjectContext*)context {
    NSDictionary *com = [responseDictionary objectForKey:@"commit"] != [NSNull null] ? (NSDictionary*)[responseDictionary objectForKey:@"commit"]  : nil;
    self.message = com[@"message"];
    self.sha = [responseDictionary objectForKey:@"sha"] != [NSNull null] ? (NSString*)[responseDictionary objectForKey:@"sha"] : nil;
    if (!self.owner)
        self.owner = [User createInContext:context];
    NSDictionary *committer = com[@"committer"];
    NSString *dateString = committer[@"date"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:enUSPOSIXLocale];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    
    self.date = [dateFormatter dateFromString:dateString];

    if (responseDictionary[@"committer"] != [NSNull null])
    [self.owner populateFromResponseDictionary:responseDictionary[@"committer"] context:context];
}
@end
