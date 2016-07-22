//
//  MCBuyModlel.h
//  MCCWYJ
//
//  Created by MC on 16/6/15.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "homeYJModel.h"

@interface MCBuyjson : NSObject
@property(nonatomic,copy)NSString * address;
@property(nonatomic,copy)NSString * brand;
@property(nonatomic,copy)NSString * color;
@property(nonatomic,copy)NSString * coordinates;
@property(nonatomic,copy)NSString * count;
@property(nonatomic,copy)NSString * decals;
@property(nonatomic,copy)NSString * model;
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * price;
@property(nonatomic,copy)NSString * shapeType;


@end


@interface MCBuyModlel : NSObject
@property(nonatomic,copy)NSString * pickerName;
@property(nonatomic,copy)NSString * pickDate;
@property(nonatomic,copy)NSString * pickerImg;
@property(nonatomic,copy)NSString * pickerId;


@property(nonatomic,copy)NSString * chPickAddress;
@property(nonatomic,copy)NSString * enPickAddress;
@property(nonatomic,copy)NSString * pickAddresId;


@property(nonatomic,copy)NSString * courierCompany;
@property(nonatomic,copy)NSString * courierNumber;
//@property(nonatomic,copy)NSString * color;

@property(nonatomic,assign)NSInteger  integral;
@property(nonatomic,copy)NSString * color;
@property(nonatomic,copy)NSString * buyCount;

@property(nonatomic,copy)NSString * userId;
@property(nonatomic,assign)NSInteger  status;
@property(nonatomic,copy)NSString * havePermission;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * brand;
@property(nonatomic,copy)NSString * count;
@property(nonatomic,copy)NSString * lastCount;

@property(nonatomic,assign)BOOL  isCollect;
@property(nonatomic,copy)NSString * name;
@property(nonatomic,strong)NSArray * operateOps;
@property(nonatomic,strong)NSMutableArray *YJoptsArray;
@property(nonatomic,strong)YJoptsModel * optsModel;
@property(nonatomic,assign)BOOL isOpenopts;
@property(nonatomic,copy)NSString * isPrecise;
@property(nonatomic,strong)NSArray * imageUrl;
@property(nonatomic,copy)NSString * type;
@property(nonatomic,copy)NSString * id;
@property(nonatomic,strong)NSDictionary * user;
@property(nonatomic,copy)NSString * priceFloat;
@property(nonatomic,copy)NSString * model;
@property(nonatomic,copy)NSString * isFriend;
@property(nonatomic,copy)NSString * isRecommend;
@property(nonatomic,copy)NSString * createDate;
@property(nonatomic,copy)NSString * json;
@property(nonatomic,copy)NSString * price;
@property(nonatomic,copy)NSString * djPrice;

@property(nonatomic,copy)NSString * deliveryAddress;
@property(nonatomic,copy)NSString * address;
@property(nonatomic,copy)NSString * addressId;

@property(nonatomic,copy)NSString * MCdescription;
@property(nonatomic,strong)YJUserModel * userModel;
@property(nonatomic,strong)YJphotoModel * photoModel;
@property(nonatomic,strong)MCBuyjson * Buyjson;

@property(nonatomic,copy)NSString * spotName;
@property(nonatomic,copy)NSString * chAddress;

@property(nonatomic,strong)NSMutableArray*YJphotos;

@property(nonatomic,assign)BOOL  isSele;;

@property(nonatomic,copy)NSString * buyId;
@property(nonatomic,copy)NSString * mobile;
@property(nonatomic,copy)NSString * nickname;
@property(nonatomic,copy)NSString * orderId;
@property(nonatomic,copy)NSString * orderNumber;
@property(nonatomic,copy)NSString * payDate;
@property(nonatomic,copy)NSString * deliveryName;
@property(nonatomic,copy)NSString * Buystatus;
@property(nonatomic,assign)NSInteger  userIntegral;
@property(nonatomic,copy)NSString*  systemIntegral;
@property(nonatomic,copy)NSString*  MCuserIntegral;


@end
