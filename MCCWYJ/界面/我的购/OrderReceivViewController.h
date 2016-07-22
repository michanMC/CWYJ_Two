//
//  OrderReceivViewController.h
//  MCCWYJ
//
//  Created by MC on 16/6/24.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "BaseViewController.h"
#import "MCBuyModlel.h"
#import "ShoppingQXViewController.h"
@interface OrderReceivViewController : BaseViewController

@property(nonatomic,strong)MCBuyModlel*BuyModlel;

@property(nonatomic,weak)ShoppingQXViewController *delegate;
@end
