//
//  Repo+CoreDataProperties.h
//  GithubClient
//
//  Created by qwerty on 24/03/2019.
//  Copyright © 2019 Yuriy Craft. All rights reserved.
//
//

#import "Repo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Repo (CoreDataProperties)

+ (NSFetchRequest<Repo *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *idx;
@property (nullable, nonatomic, copy) NSNumber *stargazers_count;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *desc;
@property (nullable, nonatomic, retain) User *owner;

@end

NS_ASSUME_NONNULL_END
