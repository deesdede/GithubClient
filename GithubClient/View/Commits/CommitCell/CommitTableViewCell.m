//
//  CommitTableViewCell.m
//  GithubClient
//
//  Created by book on 26/03/2019.
//  Copyright © 2019 Yuriy Craft. All rights reserved.
//

#import "CommitTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface CommitTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *messgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *shaLabel;
@end

@implementation CommitTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configWithAuthorName:(NSString*)name avatarString:(NSString*)avatarString messageString:(NSString*)message sha:(NSString*)sha {
    self.nameLabel.text = name;
    self.messgeLabel.text = message;
    self.shaLabel.text = sha;
    @autoreleasepool {
        [self.avatarImageView setImageWithURL:[NSURL URLWithString:avatarString] placeholderImage: [UIImage imageNamed:@"placeholder"]];
    }
    
}
@end
