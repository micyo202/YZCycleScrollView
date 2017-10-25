/************************************************************
 Class    : YZCycleScrollView.m
 Describe : 自己扩展无线循环轮播图
 Company  : Prient
 Author   : Yanzheng 严正
 Date     : 2017-10-25
 Version  : 1.0
 Declare  : Copyright © 2017 Yanzheng. All rights reserved.
 ************************************************************/

#import "YZCycleScrollView.h"
#import "UIImageView+WebCache.h"

#define PAGE_H 20

@interface YZCycleScrollView() <UIScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray *currentImages;
@property (nonatomic, assign) int currentPage;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, weak) UIScrollView *scrollView;
@end

@implementation YZCycleScrollView

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images autoPlay:(BOOL)isAuto delay:(NSTimeInterval)timeInterval {
    if (self = [super initWithFrame:frame]) {
        _autoPlay = isAuto;
        _timeInterval = timeInterval;
        _images = images;
        _currentPage = 0;
        
        [self addScrollView];
        [self addPageControl];
        if (self.autoPlay == YES) {
            [self toPlay];
        }
    }
    return self;
}

#pragma mark - 添加焦点页面控制器
- (void)addPageControl {
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, height-PAGE_H, width, PAGE_H)];
    bgView.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.2];
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, width, PAGE_H)];
    pageControl.numberOfPages = self.images.count;
    pageControl.currentPage = 0;
    pageControl.userInteractionEnabled = NO;
    _pageControl = pageControl;
    [bgView addSubview:self.pageControl];
    [self addSubview:bgView];
}

#pragma mark 自动播放（轮播）
- (void)toPlay {
    [self performSelector:@selector(autoPlayToNextPage) withObject:nil afterDelay:_timeInterval];
}

#pragma mark 自动播放下一个页面（图片）
- (void)autoPlayToNextPage {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(autoPlayToNextPage) object:nil];
    [self.scrollView setContentOffset:CGPointMake(self.frame.size.width * 2, 0) animated:YES];
    [self performSelector:@selector(autoPlayToNextPage) withObject:nil afterDelay:_timeInterval];
}

#pragma mark 初始化当前的图片数组currentImages
- (NSMutableArray *)currentImages {
    if (_currentImages == nil) {
        _currentImages = [[NSMutableArray alloc] init];
    }
    [_currentImages removeAllObjects];
    NSInteger count = self.images.count;
    int i = (int)(_currentPage + count - 1)%count;
    [_currentImages addObject:self.images[i]];
    [_currentImages addObject:self.images[_currentPage]];
    i = (int)(_currentPage + 1)%count;
    [_currentImages addObject:self.images[i]];
    return _currentImages;
}

#pragma mark 添加滚动视图
- (void)addScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * width, 0, width, height)];
        if([self.currentImages[i] hasPrefix:@"http://"] || [self.currentImages[i] hasPrefix:@"https://"]){
            // 从远程URL获取图片
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.currentImages[i]] placeholderImage:[UIImage imageNamed:@"cycle_image_placeholder"] options:SDWebImageAllowInvalidSSLCertificates completed:nil];
        }else{
            // 获取本地图片
            imageView.image = [UIImage imageNamed:self.currentImages[i]];
        }
        [scrollView addSubview:imageView];
    }
    scrollView.scrollsToTop = NO;
    scrollView.contentSize = CGSizeMake(3*width, height);
    scrollView.contentOffset = CGPointMake(width, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapped:)];
    [scrollView addGestureRecognizer:tap];
    
    [self addSubview:scrollView];
    _scrollView = scrollView;
}

#pragma mark 刷新图片
- (void)refreshImages {
    NSArray *subViews = self.scrollView.subviews;
    for (int i = 0; i < subViews.count; i++) {
        UIImageView *imageView = (UIImageView *)subViews[i];
        if([self.currentImages[i] hasPrefix:@"http://"] || [self.currentImages[i] hasPrefix:@"https://"]){
            // 从远程URL获取图片
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.currentImages[i]] placeholderImage:[UIImage imageNamed:@"cycle_image_placeholder"] options:SDWebImageAllowInvalidSSLCertificates completed:nil];
        }else{
            // 获取本地图片
            imageView.image = [UIImage imageNamed:self.currentImages[i]];
        }
    }
    
    [self.scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
}

#pragma mark - delegate代理方法
- (void)singleTapped:(UITapGestureRecognizer *)recognizer {
    if ([self.delegate respondsToSelector:@selector(cycleScrollViewDidSelectedImage:index:)]) {
        [self.delegate cycleScrollViewDidSelectedImage:self index:_currentPage];
    }
}

#pragma mark 视图滚动方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat x = scrollView.contentOffset.x;
    CGFloat width = self.frame.size.width;
    if (x >= 2 * width) {
        _currentPage = (++_currentPage) % self.images.count;
        self.pageControl.currentPage = _currentPage;
        [self refreshImages];
    }
    if (x <= 0) {
        _currentPage = (int)(_currentPage + self.images.count - 1)%self.images.count;
        self.pageControl.currentPage = _currentPage;
        [self refreshImages];
    }
    // 滑动变换标题
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [scrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:YES];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
