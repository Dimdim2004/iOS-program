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
    self.avatarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.avatarButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.avatarButton.layer.cornerRadius = 5;
    self.avatarButton.clipsToBounds = YES;
    self.avatarButton.contentMode = UIViewContentModeScaleAspectFill; // 设置 contentMode

    // 添加按钮点击事件
    [self.avatarButton addTarget:self action:@selector(avatarButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.avatarButton];

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
        [self.avatarButton.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:15],
        [self.avatarButton.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
        [self.avatarButton.widthAnchor constraintEqualToConstant:60],
        [self.avatarButton.heightAnchor constraintEqualToConstant:60],

        [self.nameLabel.leadingAnchor constraintEqualToAnchor:self.avatarButton.trailingAnchor constant:15],
        [self.nameLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:15],

        [self.wechatIDLabel.leadingAnchor constraintEqualToAnchor:self.nameLabel.leadingAnchor],
        [self.wechatIDLabel.topAnchor constraintEqualToAnchor:self.nameLabel.bottomAnchor constant:5]
    ]];
}


- (void)avatarButtonTapped:(UIButton *)sender {

    NSLog(@"Avatar button tapped");
    // Example: Show UIImagePickerController to pick an image
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self.window.rootViewController presentViewController:imagePicker animated:YES completion:nil];
}

@end
