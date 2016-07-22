//
//  MyIntegralTableViewCell.h
//  MCCWYJ
//
//  Created by MC on 16/5/27.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyIntegralModel.h"
#import "IntegralQXModel.h"


@interface MyIntegralTableViewCell : UITableViewCell

@property(nonatomic,strong)UIButton * mingxiBtn;
@property(nonatomic,strong)UIButton * rechargeBtn;
@property(nonatomic,strong)UIButton * withdrawBtn;
@property(nonatomic,strong)IntegralQXModel * QXModel;
-(void)prepareUI1:(MyIntegralModel*)model;
-(void)prepareUI2;



@end
