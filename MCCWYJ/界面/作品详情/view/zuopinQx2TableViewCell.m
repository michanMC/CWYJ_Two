//
//  zuopinQx2TableViewCell.m
//  CWYouJi
//
//  Created by MC on 15/11/7.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "zuopinQx2TableViewCell.h"

@implementation zuopinQx2TableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
    }
    return self;
}

-(void)prepareUI:(NSString*)pinglunCuntStr{
    
    for (UIView * obj in self.contentView.subviews) {
        [obj removeFromSuperview];
    }
    CGFloat selfView_W = Main_Screen_Width - 80;
  CGFloat w =[MCIucencyView heightforString:pinglunCuntStr andHeight:44 fontSize:14] +5;
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(selfView_W - w - 5, 0, w, 44)];
    lbl.text = pinglunCuntStr;//[NSString stringWithFormat:@"%@",pinglunCuntStr];
    lbl.textColor = AppTextCOLOR;
    lbl.font = AppFont;
    [self.contentView addSubview:lbl];
    
    CGFloat x = lbl.mj_x - 30 -5;
    _showBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, 7, 30, 30)];
    [_showBtn setImage:[UIImage imageNamed:@"travels_icon_more"] forState:0];
    [self.contentView addSubview:_showBtn];

    w = 131;

    x = _showBtn.mj_x - 5 - w;
    _BgView = [[UIView alloc]initWithFrame:CGRectMake(x, 7, w, 30)];
    _BgView.backgroundColor = [UIColor lightGrayColor];
    ViewRadius(_BgView, 5);
    [self.contentView addSubview:_BgView];
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(65, 5, 1, 20)];
    lineView.backgroundColor = [UIColor grayColor];
    [_BgView addSubview:lineView];
    
    _jubaoBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 65, 30)];
    [_jubaoBtn setImage:[UIImage imageNamed:@"ic_icon_report"] forState:0];
    [_jubaoBtn setTitleColor:[UIColor whiteColor] forState:0];
    [_jubaoBtn setTitle:@"举报" forState:0];
    _jubaoBtn.titleLabel.font = AppFont;
    [_BgView addSubview:_jubaoBtn];

    
    _pinglunBtn = [[UIButton alloc]initWithFrame:CGRectMake(66, 0, 65, 30)];
    [_pinglunBtn setImage:[UIImage imageNamed:@"ic_icon_comment"] forState:0];
    [_pinglunBtn setTitleColor:[UIColor whiteColor] forState:0];
    [_pinglunBtn setTitle:@"评论" forState:0];
    _pinglunBtn.titleLabel.font = AppFont;
    [_BgView addSubview:_pinglunBtn];

    

    
}

- (void)awakeFromNib {
    // Initialization code
//    ViewRadius(_BgView, 5);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
