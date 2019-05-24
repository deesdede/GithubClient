//
//  CommitsPresenter.h
//  GithubClient
//
//  Created by book on 26/03/2019.
//  Copyright © 2019 Yuriy Craft. All rights reserved.
//

#import "YCPresenter.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommitsPresenter : YCPresenter

- (instancetype)initWithFullName:(NSString*)fullName;
- (void)commitsWithRepoFullName:(NSString*)fullName nextPage:(BOOL)nextPage;
@end

NS_ASSUME_NONNULL_END
