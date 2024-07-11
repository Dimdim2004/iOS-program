#import "JCFourth.h"

@interface JCFourth ()<UIScrollViewDelegate>

@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSMutableArray *imageViews;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation JCFourth

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titles = @[@"女士", @"男士", @"儿童", @"HOME", @"香水"];
    self.currentIndex = 0;
    self.imageViews = [NSMutableArray array];
    
    [self setUpSegmentedControl];
    [self setUpScrollView];
    [self setUpLine];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.view bringSubviewToFront:self.segmentedControl];
    [self configureImages];
}

- (void)setUpLine {
    self.lineView = [[UIView alloc] initWithFrame:CGRectZero];
    self.lineView.backgroundColor = [UIColor blackColor];
    self.lineView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.lineView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.lineView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.lineView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.lineView.topAnchor constraintEqualToAnchor:self.segmentedControl.bottomAnchor],
        [self.lineView.heightAnchor constraintEqualToConstant:1]
    ]];
}

- (void)setUpSegmentedControl {
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:self.titles];
    self.segmentedControl.translatesAutoresizingMaskIntoConstraints = NO;
    self.segmentedControl.selectedSegmentIndex = 0;
    [self.segmentedControl addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segmentedControl];
    
    
    // 设置背景图像为透明图像
    UIImage *transparentImage = [[UIImage alloc] init];
    [self.segmentedControl setBackgroundImage:transparentImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.segmentedControl setBackgroundImage:transparentImage forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.segmentedControl.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.segmentedControl.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.segmentedControl.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:100],
        [self.segmentedControl.heightAnchor constraintEqualToConstant:40]
    ]];
    
    
}

- (void)setUpScrollView {
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.scrollView.topAnchor constraintEqualToAnchor:self.segmentedControl.topAnchor],
        [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-75]
    ]];
}
- (void)configureImages {
    
    for (int i = 0; i < self.titles.count + 2; i++) {
        NSString *imageName;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.scrollView.frame.size.width * i, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
        if (i == 0) {
            imageName = @"香水1.jpg";
        } else if (i == self.titles.count + 1) {
            imageName = @"女士1.jpg";
        } else {
            imageName = [NSString stringWithFormat:@"%@1.jpg", self.titles[i - 1]];
        }
        UIImage *image = [UIImage imageNamed:imageName];
        if (image) {
            imageView.image = image;
        } else {
            NSLog(@"Image not found: %@", imageName);
        }
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES; // 确保裁剪内容
        [self.scrollView addSubview:imageView];
        [self.imageViews addObject:imageView];
    }
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * (self.titles.count + 2), self.scrollView.frame.size.height);
    
    CGPoint contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    [self.scrollView setContentOffset:contentOffset animated:NO];
}

- (void)segmentChanged:(UISegmentedControl *)sender {
    NSInteger index = sender.selectedSegmentIndex;
    [self.scrollView setContentOffset:CGPointMake(self.view.frame.size.width * (index + 1), 0) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat pageWidth = scrollView.frame.size.width;
    
    int index = (int)(offsetX / pageWidth + 0.5) % ((int)self.imageViews.count + 2);
    if (index == 0) {
        self.segmentedControl.selectedSegmentIndex = 4;
    } else if (index == 6) {
        self.segmentedControl.selectedSegmentIndex = 0;
    } else {
        self.segmentedControl.selectedSegmentIndex = index - 1;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat pageWidth = scrollView.frame.size.width;
    
    if (offsetX >= pageWidth * 6) {
        // 滚动到假的最后一页，瞬间跳到实际第一页
        [self.scrollView setContentOffset:CGPointMake(pageWidth, 0) animated:NO];
    } else if (offsetX <= 0) {
        // 滚动到假的第一页，瞬间跳到实际最后一页
        [self.scrollView setContentOffset:CGPointMake(pageWidth * 5, 0) animated:NO];
    }
    

}

@end
