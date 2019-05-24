//
//  Commit+CoreDataProperties.m
//  GithubClient
//
//  Created by book on 26/03/2019.
//  Copyright © 2019 Yuriy Craft. All rights reserved.
//
//

#import "Commit+CoreDataProperties.h"

@implementation Commit (CoreDataProperties)

+ (NSFetchRequest<Commit *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Commit"];
}

@dynamic sha;
@dynamic message;
@dynamic branch;
@dynamic owner;
@dynamic repoFullName;
@dynamic date;
@end
