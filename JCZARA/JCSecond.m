//
//  JCSecond.m
//  JCZARA
//
//  Created by wjc on 2024/6/20.
//

#import "JCSecond.h"

@interface JCSecond () <UINavigationControllerDelegate,UIImagePickerControllerDelegate> 

@property (nonatomic, strong) UITextField *textfield;
@property (nonatomic, strong) UIStackView *topStackview;
@property (nonatomic, strong) UIStackView *buttomStackview;
@property (nonatomic, strong) NSMutableArray<UIButton *> *topButtons;

@end

@implementation JCSecond

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTopStackview];
    [self setUpTextfield];
    [self setUpBottomStackview];
}

-(void) setUpTopStackview{
    
    self.topButtons = [NSMutableArray array];
    
    self.topStackview = [[UIStackView alloc] init];
    self.topStackview.alignment = UIStackViewAlignmentLeading;
    self.topStackview.axis = UILayoutConstraintAxisHorizontal;
    self.topStackview.distribution = UIStackViewDistributionFillEqually;
    self.topStackview.spacing = 10;
    self.topStackview.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    NSArray *text = @[@"女士", @"男士", @"儿童", @"HOME"];
    for (NSString* str in text) {
        UIButton *btn = [[UIButton alloc] init];
        btn.translatesAutoresizingMaskIntoConstraints = YES;
        [btn setTitle:str forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:10];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.topButtons addObject:btn];
        [btn addTarget:self action:@selector(topButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.topStackview addArrangedSubview:btn];
    }
    
    [self.view addSubview:self.topStackview];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.topStackview.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:15],
        [self.topStackview.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:10],
        [self.topStackview.trailingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:300],
    ]];
    
}

-(void)setUpTextfield {
    self.textfield = [[UITextField alloc] init];
    self.textfield.placeholder = @"查询商品，颜色，系列...";
    self.textfield.backgroundColor = [UIColor whiteColor];
    self.textfield.borderStyle = UITextBorderStyleRoundedRect;
    self.textfield.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.textfield];

    [NSLayoutConstraint activateConstraints:@[
        [self.textfield.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:15],
        [self.textfield.topAnchor constraintEqualToAnchor:self.topStackview.bottomAnchor constant:20],
        [self.textfield.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-15]
    ]];
}

-(void) setUpBottomStackview {
    self.buttomStackview = [[UIStackView alloc] init];
    self.buttomStackview.alignment = UIStackViewAlignmentLeading;
    self.buttomStackview.axis = UILayoutConstraintAxisHorizontal;
    self.buttomStackview.distribution = UIStackViewDistributionFillEqually;
    self.buttomStackview.spacing = 10;
    self.buttomStackview.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    NSArray *text = @[@"商店", @"扫描"];
    for (NSString* str in text) {
        UIButton *btn = [[UIButton alloc] init];
        btn.translatesAutoresizingMaskIntoConstraints = YES;
        [btn setTitle:str forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:10];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.buttomStackview addArrangedSubview:btn];
        [btn addTarget:self action:@selector(openCamera) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self.view addSubview:self.buttomStackview];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.buttomStackview.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:15],
        [self.buttomStackview.topAnchor constraintEqualToAnchor:self.textfield.bottomAnchor constant:10],
        [self.buttomStackview.trailingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:120],
    ]];
}

- (void)topButtonTapped:(UIButton *)btn {
    [self.topButtons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        UIButton *currentButton = button; // 创建局部变量并赋值给它
        
        if (btn == currentButton) {
            // 使用当前按钮的局部变量设置字体加粗
            [currentButton.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
            [currentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        } else {
            // 使用当前按钮的局部变量设置字体变小
            [currentButton.titleLabel setFont:[UIFont systemFontOfSize:10]];
            [currentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }];
}

- (void)openCamera {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self; // 设置代理对象用于处理拍摄的照片
    [self presentViewController:imagePicker animated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
