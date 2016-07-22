//
//  ShoppingViewTableViewCell.h
//  MCCWYJ
//
//  Created by MC on 16/6/15.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCBuyModlel.h"
#import "MCbackButton.h"
@interface ShoppingViewTableViewCell : UITableViewCell



@property(nonatomic,strong)UIButton*headerBtn;
@property(nonatomic,strong)UIButton*palyBuyBtn;
@property(nonatomic,strong)UIButton * dingweibtn;
@property(nonatomic,strong)MCbackButton*collectBtn;
@property(nonatomic,strong)MCBuyModlel*BuyModlel;
@property(nonatomic,strong)UIButton * jiedanrenBtn;
-(void)prepareUI;



@property(nonatomic,strong)UILabel*titleLbl;
@property(nonatomic,strong)UILabel*dingweiLbl;
@property(nonatomic,strong)UILabel*timeLbl;
@property(nonatomic,strong)UILabel*dataLbl;
@property(nonatomic,strong)UIView*foorView;
@property(nonatomic,strong)UILabel*nameLbl;
@property(nonatomic,strong)MCbackButton*shouchangBtn;
@property(nonatomic,strong)UIImageView*gengimg;
@property(nonatomic,strong)UIButton*gengduoBtn;
@property(nonatomic,assign)BOOL isgengduan;


-(void)prepareUIshai;


@end
