//
//  MyIntegralTableViewCell.h
//  MCCWYJ
//
//  Created by MC on 16/5/27.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyIntegralTableViewCell : UITableViewCell

@property(nonatomic,strong)UIButton * mingxiBtn;
@property(nonatomic,strong)UIButton * rechargeBtn;
@property(nonatomic,strong)UIButton * withdrawBtn;
-(void)prepareUI1;
-(void)prepareUI2;



@end
