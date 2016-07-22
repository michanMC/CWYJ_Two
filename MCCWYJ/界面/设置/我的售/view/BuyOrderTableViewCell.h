//
//  BuyOrderTableViewCell.h
//  MCCWYJ
//
//  Created by MC on 16/6/21.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCBuyModlel.h"
@interface BuyOrderTableViewCell : UITableViewCell
@property(nonatomic,strong)MCBuyModlel *BuyModlel;


-(void)prepareUI1;
-(void)prepareUIadder;
-(void)prepareUIwuliu;

-(void)prepareUI2;
-(void)prepareUIbuy;

-(void)prepareUI3;
-(void)prepareUI4;

@end
