//
//  RefundXQModel.h
//  MCCWYJ
//
//  Created by MC on 16/7/15.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MCBuyModlel.h"

@interface RefundXQModel : NSObject

@property(nonatomic,strong)NSDictionary *buy;
@property(nonatomic,strong)MCBuyModlel *BuyModlel;
@property(nonatomic,strong)NSMutableArray *imgArray;
@property(nonatomic,copy)NSString*reason;
@property(nonatomic,copy)NSString*orderNumber;
@property(nonatomic,copy)NSString*sellerName;
@property(nonatomic,copy)NSString*id;
@property(nonatomic,copy)NSString*count;

@property(nonatomic,strong)NSArray*imageUrl;
@property(nonatomic,copy)NSString*price;
@property(nonatomic,copy)NSString*MCdescription;
@property(nonatomic,copy)NSString*status;



@end
