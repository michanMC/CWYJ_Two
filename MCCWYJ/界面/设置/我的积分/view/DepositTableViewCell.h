//
//  DepositTableViewCell.h
//  MCCWYJ
//
//  Created by MC on 16/5/27.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DepositTableViewCell : UITableViewCell
@property(nonatomic,strong)UIButton * selectBtn;
@property(nonatomic,strong)UILabel * titleLbl;

-(void)prepareUI;



@property(nonatomic,strong)UILabel * subtitleLbl;

-(void)prepareUI1;


@property(nonatomic,strong)UITextField * textField;
-(void)prepareUI2;





@property(nonatomic,strong)UIImageView * imgview;

-(void)prepareUI3;

-(void)prepareUI4;



@property(nonatomic,strong)UIView * bgView;
-(void)prepareUI5;



@end
