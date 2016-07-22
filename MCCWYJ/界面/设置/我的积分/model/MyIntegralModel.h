//
//  MyIntegralModel.h
//  MCCWYJ
//
//  Created by MC on 16/6/12.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyIntegralModel : NSObject
@property (nonatomic,copy)NSString * systemIntegral;
@property (nonatomic,copy)NSString * uid;
@property (nonatomic,copy)NSString * rechargeIntegral;

@property (nonatomic,copy)NSString * account;
@property (nonatomic,copy)NSString * name;
@property (nonatomic,assign)NSInteger  status;
@property (nonatomic,assign)NSInteger  type;
@property (nonatomic,copy)NSString * id;

@property (nonatomic,assign)BOOL  selebtn;

@end
