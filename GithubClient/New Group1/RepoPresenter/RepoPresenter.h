//
//  RepoPresenter.h
//  GithubClient
//
//  Created by qwerty on 24/03/2019.
//  Copyright © 2019 Yuriy Craft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Repo+CoreDataClass.h"
#import "YCPresenter.h"


NS_ASSUME_NONNULL_BEGIN

@interface RepoPresenter : YCPresenter

- (void)searchReposWithText:(NSString*)searchText nextPage:(BOOL)nextPage;
@end

NS_ASSUME_NONNULL_END
