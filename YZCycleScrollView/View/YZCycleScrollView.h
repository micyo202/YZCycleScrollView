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
- (void)cycleScrollViewDidSelectedImage:(YZCycleScrollView *)cycleScrollView index:(int)index;
@end

@interface YZCycleScrollView : UIView
@property (nonatomic, weak) id<YZCycleScrollViewDelegate> delegate;
@property (nonatomic, assign) BOOL autoPlay;
@property (nonatomic, assign) NSTimeInterval timeInterval;
@property (nonatomic, strong) NSArray *images;

// 初始化创建轮播视图
- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images autoPlay:(BOOL)isAuto delay:(NSTimeInterval)timeInterval;

@end
