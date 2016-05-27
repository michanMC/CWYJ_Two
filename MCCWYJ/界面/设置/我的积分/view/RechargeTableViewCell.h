//
//  RechargeTableViewCell.h
//  MCCWYJ
//
//  Created by MC on 16/5/27.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RechargeTableViewCell : UITableViewCell

-(void)prepareUI1;

@property(nonatomic,strong)UIImageView * imgview;
@property(nonatomic,strong)UILabel * titleLbl;
@property(nonatomic,strong)UIButton * selectBtn;
-(void)prepareUI2;

@property(nonatomic,strong)UITextField * textField;
-(void)prepareUI3;


@end
