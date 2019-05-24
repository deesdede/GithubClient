//
//  Commit+CoreDataProperties.h
//  GithubClient
//
//  Created by book on 26/03/2019.
//  Copyright © 2019 Yuriy Craft. All rights reserved.
//
//

#import "Commit+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Commit (CoreDataProperties)

+ (NSFetchRequest<Commit *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *sha;
@property (nullable, nonatomic, copy) NSDate *date;
@property (nullable, nonatomic, copy) NSString *message;
@property (nullable, nonatomic, copy) NSString *branch;
@property (nullable, nonatomic, copy) NSString *repoFullName;
@property (nullable, nonatomic, retain) User *owner;

@end

NS_ASSUME_NONNULL_END
