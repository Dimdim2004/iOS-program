#import "MainViewController.h"

@interface MainViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSArray *imageNames;
@property (nonatomic, assign) NSInteger currentCategoryIndex;
@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) UIView *topBarView;
@property NSTimer *timer;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.categories = @[@"女士", @"男士", @"儿童", @"家居", @"香水"];
    self.currentCategoryIndex = 0;
    
    // 设置背景色
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 创建顶部的ZARA标志和分类标签
    [self setupTopBar];
    
    // 创建轮播图
    [self setupScrollView];
    
    // 创建分页控件
    [self setupPageControl];
    
    // 初始加载图片
    [self loadLocalImagesForCategory:self.categories[self.currentCategoryIndex]];
}

- (void)setupTopBar {
    self.topBarView = [[UIView alloc] initWithFrame:CGRectZero];
    self.topBarView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.topBarView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.text = @"ZARA";
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:60];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.topBarView addSubview:titleLabel];
    
    // 创建分类标签
    UIStackView *categoryStackView = [[UIStackView alloc] initWithFrame:CGRectZero];
    categoryStackView.axis = UILayoutConstraintAxisHorizontal;
    categoryStackView.alignment = UIStackViewAlignmentCenter;
    categoryStackView.distribution = UIStackViewDistributionFillEqually;
    categoryStackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    for (int i = 0; i < self.categories.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:self.categories[i] forState:UIControlStateNormal];
        button.tag = i;
        [button addTarget:self action:@selector(categoryButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        button.tintColor = [UIColor blackColor];
        [categoryStackView addArrangedSubview:button];
    }
    
    [self.topBarView addSubview:categoryStackView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.topBarView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:-30],
        [self.topBarView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.topBarView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.topBarView.heightAnchor constraintEqualToConstant:150],
        
        [titleLabel.topAnchor constraintEqualToAnchor:self.topBarView.topAnchor],
        [titleLabel.leadingAnchor constraintEqualToAnchor:self.topBarView.leadingAnchor],
        [titleLabel.trailingAnchor constraintEqualToAnchor:self.topBarView.trailingAnchor],
        [titleLabel.heightAnchor constraintEqualToConstant:100],
        
        [categoryStackView.topAnchor constraintEqualToAnchor:titleLabel.bottomAnchor],
        [categoryStackView.leadingAnchor constraintEqualToAnchor:self.topBarView.leadingAnchor],
        [categoryStackView.trailingAnchor constraintEqualToAnchor:self.topBarView.trailingAnchor]
    ]];
}

- (void)setupScrollView {
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - 200)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.scrollView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.scrollView.topAnchor constraintEqualToAnchor:self.topBarView.bottomAnchor constant:-10],
        [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:20]  // 调整底部约束以适应底部选项卡栏
            ]];
    
}

- (void)setupPageControl {
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
    self.pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.pageControl];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.pageControl.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-10],
        [self.pageControl.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor]
    ]];
}

- (void)loadLocalImagesForCategory:(NSString *)category {
    NSMutableArray *imageNames = [NSMutableArray array];
    NSString *imageName;
    for (int i = 0; i <= 6; i++) {
        if (i == 0) {
            imageName = [NSString stringWithFormat:@"%@%d.jpg", category, 5];
        } else if (i == 6) {
            imageName = [NSString stringWithFormat:@"%@%d.jpg", category, 1];
        } else {
            imageName = [NSString stringWithFormat:@"%@%d.jpg", category, i];
        }
        [imageNames addObject:imageName];
    }
    self.imageNames = [imageNames copy];
    
    [self updateScrollView];
    // Adjust the content offset to the first page
    CGPoint contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    [self.scrollView setContentOffset:contentOffset animated:NO];
}

- (void)updateScrollView {
    // 清空之前的子视图
    for (UIView *subview in self.scrollView.subviews) {
        [subview removeFromSuperview];
    }
    
    CGFloat width = self.scrollView.frame.size.width;
    CGFloat height = self.scrollView.frame.size.height;
    for (int i = 0; i < self.imageNames.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * width, 0, width, height)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.image = [UIImage imageNamed:self.imageNames[i]];
        [self.scrollView addSubview:imageView];
    }
    
    self.scrollView.contentSize = CGSizeMake(width * self.imageNames.count, height);
    self.pageControl.numberOfPages = self.imageNames.count - 2;
    self.pageControl.currentPage = 0;
}

- (void)categoryButtonTapped:(UIButton *)sender {
    self.currentCategoryIndex = sender.tag;
    NSString *selectedCategory = self.categories[self.currentCategoryIndex];
    [self loadLocalImagesForCategory:selectedCategory];
}

#pragma mark - UIScrollView Delegate Methods

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
    int page = (int)(scrollView.contentOffset.x / pageWidth + 0.5) % (int)self.imageNames.count;
    if (page == 0) {
        self.pageControl.currentPage = 4;
    } else if (page == 6) {
        self.pageControl.currentPage = 0;
    } else {
        self.pageControl.currentPage = page - 1;
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if ([_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
    }
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (![_timer isValid]) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    }
}
- (void)nextPage {
    NSInteger page = self.pageControl.currentPage;
    page++;
    CGFloat offsetX = (page + 1) * self.scrollView.frame.size.width; // 偏移量加1，因为第1页是假的
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}
@end
