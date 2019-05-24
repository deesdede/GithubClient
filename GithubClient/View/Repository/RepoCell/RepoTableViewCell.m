//
//  RepoTableViewCell.m
//  GithubClient
//
//  Created by qwerty on 24/03/2019.
//  Copyright © 2019 Yuriy Craft. All rights reserved.
//

#import "RepoTableViewCell.h"

@interface RepoTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation RepoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configWithName:(NSString*)name description:(NSString*)description {
    self.nameLabel.text = name;
    self.descriptionLabel.text = description;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
