/************************************************************
 Class    : YZCycleScrollView.h
 Describe : 自己扩展无线循环轮播图
 Company  : Prient
 Author   : Yanzheng 严正
 Date     : 2017-10-25
 Version  : 1.0
 Declare  : Copyright © 2017 Yanzheng. All rights reserved.
 ************************************************************/

#import <UIKit/UIKit.h>
@class YZCycleScrollView;

// 设置cycleScrollView点击的代理方法
@protocol YZCycleScrollViewDelegate <NSObject>

@optional
// 点击轮播图的代理方法
- (void)cycleScrollViewDidSelectedImage:(YZCycleScrollView *)cycleScrollView index:(int)index;
@end

@interface YZCycleScrollView : UIView

@property (nonatomic, weak) id<YZCycleScrollViewDelegate> delegate;// 代理

@property (nonatomic, strong) NSArray *titles;// 标题
@property (nonatomic, strong) NSArray *images;// 图片
@property (nonatomic, strong) NSArray *urls;// 链接地址

@property (nonatomic, assign) BOOL autoPlay;// 自动播放
@property (nonatomic, assign) NSTimeInterval timeInterval;// 间隔播放时间

// 初始化创建轮播视图
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles images:(NSArray *)images urls:(NSArray *)urls autoPlay:(BOOL)isAuto delay:(NSTimeInterval)timeInterval;

@end
