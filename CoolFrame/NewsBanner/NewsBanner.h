//
//  NewsBanner.h
//  CoolFrame
//
//  Created by shenjie on 2017/9/14.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NewsBanner : NSObject<UIScrollViewDelegate>

@property (strong, nonatomic) UIView *newsView;

//存储待显示产品的数组
@property (strong, nonatomic) NSMutableArray *productsArray;

//左右滑动
@property (strong, nonatomic) UIScrollView *scrollView;

//页面控制
@property (strong, nonatomic) UIPageControl *pageControl;

//当前页索引标记
@property (assign, nonatomic) int currentIndex;

@property (strong, nonatomic) UIImageView *imgVLeft;
@property (strong, nonatomic) UIImageView *imgVCenter;
@property (strong, nonatomic) UIImageView *imgVRight;

+ (NewsBanner *)getInstance;

//创建一个 NewsBanner
- (void)createNewsBanner:(NSMutableArray *)products  frame:(CGRect)rect;

- (void)setNewsBannerFrame:(CGRect)rect;

- (void)setNewsBannerInfo:(NSMutableArray *)products;

- (UIView *)getNewsBanner;
@end
