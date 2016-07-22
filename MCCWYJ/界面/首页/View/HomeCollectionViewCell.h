//
//  HomeCollectionViewCell.h
//  MCCWYJ
//
//  Created by MC on 16/5/7.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "homeYJModel.h"
#import "MCBuyModlel.h"
@interface HomeCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UIButton * headerimgBtn;
@property(nonatomic,strong)UIButton * buyBtn;

@property(nonatomic,strong) homeYJModel *model;

-(void)prepareMeUI;

@property(nonatomic,strong) MCBuyModlel *BuyModlel;

-(void)prepareHotUI;

-(void)prepareYJUI;


@end
