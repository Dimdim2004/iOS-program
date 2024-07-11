//
//  JCThird.m
//  JC无限轮播图
//

#import "JCThird.h"
#import "UserInfoTableViewCell.h"
#import "MenuItemTableViewCell.h"
#import "JCFirst.h"
#import "changeNameDelegate.h"
@interface JCThird () <changeDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *menuItems;
@property (nonatomic, strong) NSString *userName;

@end

@implementation JCThird



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的";
    
    self.menuItems = @[
        @{@"icon": @"creditcard", @"title": @"支付"},
        @{@"icon": @"heart", @"title": @"收藏"},
        @{@"icon": @"photo.on.rectangle", @"title": @"相册"},
        @{@"icon": @"wallet.pass", @"title": @"卡包"},
        @{@"icon": @"face.smiling", @"title": @"表情"},
        @{@"icon": @"gear", @"title": @"设置"}
    ];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UserInfoTableViewCell class] forCellReuseIdentifier:@"UserInfoTableViewCell"];
    [self.tableView registerClass:[MenuItemTableViewCell class] forCellReuseIdentifier:@"MenuItemTableViewCell"];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2; // 第一部分用于显示用户信息，第二部分用于显示菜单项
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1; // 用户信息部分只有一个单元格
    } else {
        return self.menuItems.count; // 菜单项部分的单元格数量
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserInfoTableViewCell" forIndexPath:indexPath];
        cell.avatarImageView.image = [UIImage systemImageNamed:@"person.circle"];
        
        cell.nameLabel.text = @"用户名";
        cell.wechatIDLabel.text =[NSString stringWithFormat:@"账号：%@",self.userName];
        return cell;
    } else {
        MenuItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuItemTableViewCell" forIndexPath:indexPath];
        
        NSDictionary *menuItem = self.menuItems[indexPath.row];
        cell.iconImageView.image = [UIImage systemImageNamed:menuItem[@"icon"]];
        cell.titleLabel.text = menuItem[@"title"];
        
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 80; // 用户信息部分的单元格高度
    } else {
        return 44; // 菜单项部分的单元格高度
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JCFirst *cview = [[JCFirst alloc] init];
    cview.view.backgroundColor = [UIColor orangeColor];
    cview.delegate = self;
    // 隐藏标签栏
    self.tabBarController.tabBar.hidden = YES;
    
    if(indexPath.section == 0) {
        cview.title = @"个人主页";
    } else {
        NSDictionary *menuItem = self.menuItems[indexPath.row];
        cview.title = menuItem[@"title"];
    }
    [self.navigationController pushViewController:cview animated:YES];
}

-(void)changeName:(NSString *)name {
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
    self.userName = name;
    [self.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
}

@end
