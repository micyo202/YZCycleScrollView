//
//  ViewController.m
//  YZCycleScrollView
//
//  Created by Apple on 2017/10/25.
//  Copyright © 2017年 yan. All rights reserved.
//

#import "ViewController.h"
#import "YZCycleScrollView.h"

@interface ViewController () <YZCycleScrollViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 加载网络图片
    NSArray *images = @[@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=624026161,316177573&fm=27&gp=0.jpg", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1508935179522&di=0b13b5528b6cd4c28093e373a9162b69&imgtype=0&src=http%3A%2F%2Fpic22.nipic.com%2F20120711%2F9782298_190753257000_2.jpg", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1508935202373&di=d9198e986b6e61f6294114718cca679a&imgtype=0&src=http%3A%2F%2Fpic2.ooopic.com%2F10%2F60%2F11%2F96b1OOOPIC8f.jpg", @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3846820649,3284377375&fm=27&gp=0.jpg"];
    YZCycleScrollView *cycleScrollView = [[YZCycleScrollView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height/6, self.view.bounds.size.width, self.view.bounds.size.height/4) images:images autoPlay:YES delay:3.0f];
    cycleScrollView.delegate = self;
    [self.view addSubview:cycleScrollView];
    
    // 加载本地图片
    NSArray *images1 = @[@"cyle_image_1", @"cyle_image_2", @"cyle_image_3", @"cyle_image_4"];
    YZCycleScrollView *cycleScrollView1 = [[YZCycleScrollView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height/2, self.view.bounds.size.width, self.view.bounds.size.height/4) images:images1 autoPlay:YES delay:3.0f];
    cycleScrollView1.delegate = self;
    [self.view addSubview:cycleScrollView1];
    
}

- (void)cycleScrollViewDidSelectedImage:(YZCycleScrollView *)cycleScrollView index:(int)index {
    NSLog(@"点击了第%d张焦点图", index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
