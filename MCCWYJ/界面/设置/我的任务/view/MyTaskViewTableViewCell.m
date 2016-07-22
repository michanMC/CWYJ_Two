//
//  MyTaskViewTableViewCell.m
//  MCCWYJ
//
//  Created by MC on 16/6/3.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MyTaskViewTableViewCell.h"
#import "YSProgressView.h"

@implementation MyTaskViewTableViewCell

-(void)prepareUI{
    
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
   CGFloat viewH = 10 + 20 + 5 + 5 + 5+ 20 + 10;
    _ImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, (viewH - 30)/2, 30, 30)];
    
    [self.contentView addSubview:_ImgView];

    
    _TaskBtn = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width -  10 - 60, (viewH - 30)/2, 60, 30)];
    [_TaskBtn setTitle:@"去完成" forState:0];
    _TaskBtn.backgroundColor = AppCOLOR;
    [_TaskBtn setTitleColor:[UIColor whiteColor] forState:0];
    _TaskBtn.titleLabel.font = AppFont;
    ViewRadius(_TaskBtn, 3);
    [self.contentView addSubview:_TaskBtn];
    
    
    
    
    
    
    
    CGFloat x  = 10 + 30 + 10;
    CGFloat y = 10;
    CGFloat w = Main_Screen_Width - x ;
    CGFloat h = 20;
    _titelLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _titelLbl.text = @"";
    _titelLbl.textColor = AppTextCOLOR;
    _titelLbl.font = AppFont;
    [self.contentView addSubview:_titelLbl];
    y += 5 + h;
    h = 5;
    w  = Main_Screen_Width - x - 10 - 60 - 60-10;
    
  _ysView = [[YSProgressView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _ysView.progressTintColor = [UIColor groupTableViewBackgroundColor];
        _ysView.trackTintColor = AppCOLOR;
//        _ysView.progressValue = 1000;
    [self.contentView addSubview:_ysView];
     _countLbl= [[UILabel alloc]initWithFrame:CGRectMake(_ysView.mj_x + _ysView.mj_w + 5, y-10, 50, 20)];
    _countLbl.text = @"0/1";
    _countLbl.textColor = AppTextCOLOR;
    _countLbl.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_countLbl];



    y += h + 5;
    w = 100;
    h = 20;
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.textColor = AppCOLOR;
    lbl.text  = @"+10赠点";
    lbl.font = AppFont;
    [self.contentView addSubview:lbl];

    
    
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
