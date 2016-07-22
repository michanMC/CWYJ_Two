//
//  PaymentViewController.h
//  MCCWYJ
//
//  Created by MC on 16/6/22.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "BaseViewController.h"

@interface PaymentViewController : BaseViewController
@property(nonatomic,strong)MCBuyModlel*BuyModlel;
@property(nonatomic,strong)NSMutableDictionary *datadic;
@property(nonatomic,copy)NSString * buyIdStr;
@property(nonatomic,copy)NSString * typeIndex;//0,售卖单支付，1，代购单支付；
@property(nonatomic,assign)BOOL isBackRoot;//yes是不返回root
@end
