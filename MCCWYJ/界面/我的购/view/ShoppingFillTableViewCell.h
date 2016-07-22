//
//  ShoppingFillTableViewCell.h
//  MCCWYJ
//
//  Created by MC on 16/6/22.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingFillTableViewCell : UITableViewCell
@property(nonatomic,strong)MCBuyModlel*BuyModlel;

@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,strong)UIButton *minBtn;
@property(nonatomic,strong)UITextField *countfield;
-(void)prepareUI1;
@property(nonatomic,strong)UILabel * priceLbl;

@property(nonatomic,copy)NSString * countStr;

-(void)prepareUI2;

@property(nonatomic,strong)UILabel *addLbl;

-(void)prepareUI3;

@property(nonatomic,strong)UILabel *titleLbl;

@property(nonatomic,strong)UIButton *seleBtn;
-(void)prepareUI4;
-(void)prepareUI5;


@property(nonatomic,copy)NSString * rechargeIntegral;
@property(nonatomic,copy)NSString * sytemIntegral;
@property(nonatomic,strong)UILabel *sytemminLbl;
@property(nonatomic,strong)UILabel *rechargeminLbl;

@property(nonatomic,strong)UIButton *IntegralBtn;

-(void)prepareUI6;
-(void)prepareUI7;
-(void)prepareUI8;

@property(nonatomic,strong)UIImageView *imgview;

-(void)prepareUI9;



@end
