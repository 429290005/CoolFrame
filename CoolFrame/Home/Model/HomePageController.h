//
//  HomePageController.h
//  CoolFrame
//
//  Created by silicon on 2017/9/9.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomePageController : NSObject

+ (HomePageController *)getInstance;

- (NSMutableArray *)getHomePageData;

- (NSMutableArray *)getPackageData;

@end
