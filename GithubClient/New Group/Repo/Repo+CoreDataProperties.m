//
//  Repo+CoreDataProperties.m
//  GithubClient
//
//  Created by qwerty on 24/03/2019.
//  Copyright © 2019 Yuriy Craft. All rights reserved.
//
//

#import "Repo+CoreDataProperties.h"

@implementation Repo (CoreDataProperties)

+ (NSFetchRequest<Repo *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Repo"];
}

@dynamic name;
@dynamic desc;
@dynamic owner;
@dynamic stargazers_count;
@dynamic idx;

@end
