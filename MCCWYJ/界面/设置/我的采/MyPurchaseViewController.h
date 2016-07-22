//
//  MyPurchaseViewController.h
//  MCCWYJ
//
//  Created by MC on 16/6/3.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "BaseViewController.h"
#import "ShoppingQXViewController.h"
#import "MCMyshoppingTableViewCell.h"
@interface MyPurchaseViewController : BaseViewController
@property(nonatomic,weak)MyPurchaseViewController * delegate;
-(void)finishEdit;
-(void)NOEdit:(BOOL)isNOEdit;

@end
