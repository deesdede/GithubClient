//
//  RepoTableViewCell.h
//  GithubClient
//
//  Created by qwerty on 24/03/2019.
//  Copyright © 2019 Yuriy Craft. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RepoTableViewCell : UITableViewCell

- (void)configWithName:(NSString*)name description:(NSString*)description;
@end

NS_ASSUME_NONNULL_END
