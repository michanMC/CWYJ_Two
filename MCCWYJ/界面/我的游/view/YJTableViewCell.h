//
//  YJTableViewCell.h
//  MCCWYJ
//
//  Created by MC on 16/5/14.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "homeYJModel.h"
#import "JSBadgeView.h"
@interface YJTableViewCell : UITableViewCell

@property(nonatomic,assign)BOOL  isfriendPlay;


-(void)prepareUI:(homeYJModel*)model;


@property(nonatomic,strong)UIView *BgView;
@property(nonatomic,strong)UIView *Bg2View;
@property(nonatomic,strong)UIButton *selectBtn;
@property(nonatomic,strong)UIButton * headerimgBtn;
@property(nonatomic,strong)UIButton * dingweibtn;
@property(nonatomic,strong)UIImageView * imgView;

@property(nonatomic,strong)JSBadgeView *BadgeView;
@property(nonatomic,assign)BOOL  tixing;

@end
