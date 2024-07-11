//
//  UserInfoTableViewCell.m
//  JC无限轮播图
//
//  Created by 刘原甫 on 2024/6/14.
//

#import "UserInfoTableViewCell.h"

@implementation UserInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    // 初始化 avatarButton
    self.avatarImageView = [[UIImageView alloc] init];
    self.avatarImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.avatarImageView.layer.cornerRadius = 5;
    self.avatarImageView.clipsToBounds = YES;
        self.avatarImageView.contentMode = UIViewContentModeScaleAspectFill; // 设置 contentMode
        [self.contentView addSubview:self.avatarImageView];
    // 其他视图初始化和布局约束
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.nameLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.contentView addSubview:self.nameLabel];
    
    self.wechatIDLabel = [[UILabel alloc] init];
    self.wechatIDLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.wechatIDLabel.font = [UIFont systemFontOfSize:14];
    self.wechatIDLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.wechatIDLabel];

    // 设置约束
    [NSLayoutConstraint activateConstraints:@[
        [self.avatarImageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:15],
        [self.avatarImageView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
        [self.avatarImageView.widthAnchor constraintEqualToConstant:60],
        [self.avatarImageView.heightAnchor constraintEqualToConstant:60],

        [self.nameLabel.leadingAnchor constraintEqualToAnchor:self.avatarImageView.trailingAnchor constant:15],
        [self.nameLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:15],

        [self.wechatIDLabel.leadingAnchor constraintEqualToAnchor:self.nameLabel.leadingAnchor],
        [self.wechatIDLabel.topAnchor constraintEqualToAnchor:self.nameLabel.bottomAnchor constant:5]
    ]];
}



@end
