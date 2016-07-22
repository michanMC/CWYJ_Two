//
//  MyTaskViewTableViewCell.h
//  MCCWYJ
//
//  Created by MC on 16/6/3.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSProgressView.h"
@interface MyTaskViewTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView*ImgView;
@property(nonatomic,strong)UILabel*titelLbl;
@property(nonatomic,strong)UIButton*TaskBtn;
@property(nonatomic,strong)UILabel * countLbl;
@property(nonatomic,strong)YSProgressView* ysView;

-(void)prepareUI;


@end
