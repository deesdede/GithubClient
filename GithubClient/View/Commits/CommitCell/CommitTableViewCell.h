//
//  CommitTableViewCell.h
//  GithubClient
//
//  Created by book on 26/03/2019.
//  Copyright © 2019 Yuriy Craft. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommitTableViewCell : UITableViewCell

- (void)configWithAuthorName:(NSString*)name avatarString:(NSString*)avatarString messageString:(NSString*)message sha:(NSString*)sha;
@end

NS_ASSUME_NONNULL_END
