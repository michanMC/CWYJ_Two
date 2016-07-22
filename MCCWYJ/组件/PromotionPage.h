//
//  PromotionPage.h
//  ZFPromotionPage
//
//  Created by 张锋 on 16/6/23.
//  Copyright © 2016年 张锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PromotionPageDelegate <NSObject>

@optional
- (void)promotionPageHasFinishLaunch;

@end

@interface PromotionPage : UIView

/** 广告加载完成回调 */
@property (nonatomic, copy) void (^finishBlock) (void);
- (void)hidePromotionPage;

/** 代理方法：*/
@property (nonatomic, assign) id<PromotionPageDelegate> delegate;

/**
 *  初始化方法
 *
 *  @param logoImage    公司或者APP logo的图片
 *  @param promotionURL 推广URL地址
 *
 *  @return promotionPage实例
 */
+ (instancetype)promotionPageWithLoginImage:(UIImage *)logoImage promotionURL:(NSURL *)promotionURL;

@end
