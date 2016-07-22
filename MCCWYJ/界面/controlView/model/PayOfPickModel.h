//
//  PayOfPickModel.h
//  MCCWYJ
//
//  Created by MC on 16/7/12.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayOfPickModel : NSObject


@property(nonatomic,copy)NSString * remainPrice;

@property(nonatomic,copy)NSString * subSystemIntegral;
@property(nonatomic,copy)NSString * subUserIntegral;
@property(nonatomic,copy)NSString * systemIntegral;
@property(nonatomic,copy)NSString * targetId;
@property(nonatomic,copy)NSString * totalPrice;
@property(nonatomic,copy)NSString * userIntetral;

@property(nonatomic,copy)NSString * integralOfOther;// * 不用用户积分，用支付宝和微信需支付多少钱


@end
