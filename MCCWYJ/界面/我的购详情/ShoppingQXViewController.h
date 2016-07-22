//
//  ShoppingQXViewController.h
//  MCCWYJ
//
//  Created by MC on 16/6/15.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "BaseViewController.h"
#import "JSBadgeView.h"

@interface ShoppingQXViewController : BaseViewController


@property(nonatomic,strong)UIImage *bgimg;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,strong)MCBuyModlel *BuyModlel;
-(void)modeltype:(MCBuyModlel*)model;
-(void)refreshSubmodel;

@property(nonatomic,assign)BOOL isback;//返回是否处理
@property (nonatomic,assign)BOOL isHot;

@end
