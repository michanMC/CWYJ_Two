//
//  ShoppingView.h
//  MCCWYJ
//
//  Created by MC on 16/6/15.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zuopinDataView.h"
#import "ShoppingQXViewController.h"
@interface ShoppingView : UIView
@property(nonatomic,strong)UIImageView * bg_imgView;
@property(nonatomic,assign)BOOL isLoda;
@property(nonatomic,assign)NSInteger indexId;
@property(nonatomic,weak)id<zuopinDataViewDeleGate>deleGate;
@property(nonatomic,assign) NSInteger pagrStr;
@property(nonatomic,strong)  NSMutableArray * dataPingLunArray;
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong) MCBuyModlel*BuyModlel;
@property (nonatomic , strong)NSDictionary * classifyDic;
@property (nonatomic,strong) MCNetworkManager *requestManager;
-(void)loadData:(BOOL)iszhuan;
-(void)loadModle:(BOOL)iszhuan;
@property (nonatomic,assign)BOOL isHot;

@property(nonatomic,weak)ShoppingQXViewController * selfViewCtl;

@end
