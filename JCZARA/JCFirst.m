//
//  JCFirst.m
//  JCZARA
//
//  Created by wjc on 2024/6/20.
//

#import "JCFirst.h"
#import "changeNameDelegate.h"
@interface JCFirst ()

@end

@implementation JCFirst



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 添加一个按钮到视图
    self.modifyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.modifyButton setTitle:@"修改信息" forState:UIControlStateNormal];
    [self.modifyButton addTarget:self action:@selector(showModifyOptions) forControlEvents:UIControlEventTouchUpInside];
    self.modifyButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.modifyButton];
    
    // 设置按钮约束
    [NSLayoutConstraint activateConstraints:@[
        [self.modifyButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.modifyButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [self.modifyButton.widthAnchor constraintEqualToConstant:150],
        [self.modifyButton.heightAnchor constraintEqualToConstant:40]
    ]];
}

- (void)showModifyOptions {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"修改信息" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    // 修改名字选项
    UIAlertAction *changeNameAction = [UIAlertAction actionWithTitle:@"修改名字" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showNameChangeDialog];
    }];
    [alertController addAction:changeNameAction];
    
    // 修改图像选项
    UIAlertAction *changeImageAction = [UIAlertAction actionWithTitle:@"修改图像" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showImageChangeDialog];
    }];
    [alertController addAction:changeImageAction];
    
    // 取消选项
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    
    // 弹出控件
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showNameChangeDialog {
    UIAlertController *nameAlert = [UIAlertController alertControllerWithTitle:@"修改名字" message:@"请输入新的名字：" preferredStyle:UIAlertControllerStyleAlert];
    
    [nameAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"新的名字";
    }];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = nameAlert.textFields.firstObject;
        NSString *newName = textField.text;
        [self.delegate changeName:newName];
    }];
    [nameAlert addAction:confirmAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [nameAlert addAction:cancelAction];
    
    [self presentViewController:nameAlert animated:YES completion:nil];
}

- (void)showImageChangeDialog {
    UIAlertController *imageAlert = [UIAlertController alertControllerWithTitle:@"修改图像" message:@"选择新的图像来源：" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 打开相机进行图像选择
        NSLog(@"打开相机");
    }];
    [imageAlert addAction:cameraAction];
    
    UIAlertAction *photoLibraryAction = [UIAlertAction actionWithTitle:@"照片库" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 打开照片库进行图像选择
        NSLog(@"打开照片库");
    }];
    [imageAlert addAction:photoLibraryAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [imageAlert addAction:cancelAction];
    
    // iPad 上需要设置 popoverPresentationController
    imageAlert.popoverPresentationController.sourceView = self.modifyButton;
    imageAlert.popoverPresentationController.sourceRect = self.modifyButton.bounds;
    
    [self presentViewController:imageAlert animated:YES completion:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = NO;
}
@end
