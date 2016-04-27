//
//  MyTools.h
//  OwnPeople
//
//  Created by fenguo on 14-11-22.
//  Copyright (c) 2014年 fenguo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyTools : NSObject

/**
 *  本应用是否第一次打开
 *
 *  @return
 */
+ (BOOL)appIsFirstOpen;

/**
 *  此方法调用后上面的方法返回no
 */
+ (void)appHasOpened;


/*!
 * @brief 把字典转换成模型，模型类名为className
 * @param dict 字典对象
 * @param className 类名
 * @return 返回数据模型对象
 */
+ (id)modelWithDict:(NSDictionary *)dict className:(NSString *)className;


/**
 *  是否正确的手机号码
 *
 *  @return
 */
+ (BOOL)isPhoneNumber:(NSString*)number;

/**
 *  是否为正确的价格格式
 *
 *  @param price
 *
 *  @return
 */
+ (BOOL)isPrice:(NSString*)price;

/**
 *  保存登录后的信息
 *
 *  @param seesionId 登录后的seesionId
 *  @param expire    seesionId的过期时间
 */
+ (void)saveLoginSeesionId:(NSString *)seesionId AndExpire:(NSString *)expire;

/**
 *  获取登录seesionId
 *
 *  @return
 */
+ (NSString *)getTheSeesionId;

/**
 *  保存授权过的新浪账号
 *
 *  @param accountName 新浪返回的uid
 */
+ (void)saveSinaAccount:(NSString *)accountUid;

/**
 *  该新浪账号是否已授权过
 *
 *  @param accountUid 新浪返回的uid
 *
 *  @return
 */
+ (BOOL)sinaAccountHasSave:(NSString *)accountUid;

/**
 *  保存授权过的QQ账号
 *
 *  @param accountUid QQ返回的uid
 */
+ (void)saveQQAccount:(NSString *)accountUid;

/**
 *  该QQ账号是否已授权过
 *
 *  @param accountUid QQ返回的uid
 *
 *  @return
 */
+ (BOOL)qqAccountHasSave:(NSString *)accountUid;

@end
