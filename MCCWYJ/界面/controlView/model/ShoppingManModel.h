//
//  ShoppingManModel.h
//  MCCWYJ
//
//  Created by MC on 16/7/15.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingManModel : NSObject


@property(nonatomic,copy)NSString * address;
@property(nonatomic,copy)NSString * buyerAccount;
@property(nonatomic,copy)NSString * buyerImg;//购买者头像
@property(nonatomic,copy)NSString * buyerName;
@property(nonatomic,copy)NSString * count;
@property(nonatomic,copy)NSString * courierCompany;//快递公司
@property(nonatomic,copy)NSString * courierNumber;//快递单号
@property(nonatomic,copy)NSString * deliveryerName;//收件人名称
@property(nonatomic,copy)NSString * imageUrls;
@property(nonatomic,copy)NSString * mobile;
@property(nonatomic,copy)NSString * orderNumber;
@property(nonatomic,copy)NSString * orderTime;
@property(nonatomic,copy)NSString * price;
@property(nonatomic,copy)NSString * refundMessage;//退款信息
@property(nonatomic,copy)NSString * refundPrice;//退款总额
@property(nonatomic,copy)NSString * status;
//订单状态 未发货：0,已发货：1,已完成：2,已关闭：3,退款成功：4，退款中：5

@property(nonatomic,strong)YJphotoModel * photoModel;
@property(nonatomic,strong)NSMutableArray*YJphotos;


@end
