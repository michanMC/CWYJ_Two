//
//  MyIntegralTableViewCell.m
//  MCCWYJ
//
//  Created by MC on 16/5/27.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MyIntegralTableViewCell.h"

@implementation MyIntegralTableViewCell

-(void)prepareUI1:(MyIntegralModel*)model{

    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    CGFloat x = 10;
    CGFloat y = 10;
    CGFloat w = 50;
    CGFloat h = w;
    UIImageView * imgview = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    imgview.image = [UIImage imageNamed:@"icon_money"];
    [self.contentView addSubview:imgview];
    
    
    x += w + 10;
    y += 15;
    w = 40;
    h = 20;
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.text = @"采点";
    lbl.textColor = AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:lbl];
    
    
    x += w + 5;
    w = Main_Screen_Width - x - 80;
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.text = model.rechargeIntegral? model.rechargeIntegral :@"0";//@"100000";
    lbl.textColor = AppCOLOR;
    lbl.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:lbl];
    
    
    x = 10 + 50 + 10;
    y += h + 10;
    w = 20;
    h = 20;
    imgview =[[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    imgview.image = [UIImage imageNamed:@"icon_money2"];
    [self.contentView addSubview:imgview];
    
    x += w + 5;
    w = 30;
    h = 20;
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.text = @"赠点";
    lbl.textColor = AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:lbl];
    
    x += w + 5;
    w = Main_Screen_Width - x - 80;
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    NSString * str = model.systemIntegral ?  model.systemIntegral :@"0";
    lbl.text = [NSString stringWithFormat:@"￥%@",str];
    lbl.textColor = [UIColor darkTextColor];
    lbl.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:lbl];
    
    y+=h + 10;
    UIView * lienView = [[UIView alloc]initWithFrame:CGRectMake(0, y, Main_Screen_Width, 0.5)];
    lienView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:lienView];

    y = (y - 30)/2;
    x = Main_Screen_Width - 10 - 70;
    w = 70;
    _mingxiBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, 30)];
    [_mingxiBtn setTitle:@"更多明细" forState:0];
    [_mingxiBtn setTitleColor:[UIColor whiteColor] forState:0];
    _mingxiBtn.titleLabel.font = AppFont;
    _mingxiBtn.backgroundColor = AppCOLOR;
    ViewRadius(_mingxiBtn, 5);
    [self.contentView addSubview:_mingxiBtn];

    
    y = lienView.mj_y + 0.5;
    
    w = (Main_Screen_Width - 0.5)/2;
    h = 40;
    x = 0;
    _rechargeBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [_rechargeBtn setTitleColor:RGBCOLOR(127, 125, 147) forState:0];
    [_rechargeBtn setTitle:@"充值" forState:0];
    [_rechargeBtn setImage:[UIImage imageNamed:@"-icon_recharge"] forState:0];
    _rechargeBtn.titleLabel.font = AppFont;
    [self.contentView addSubview:_rechargeBtn];

    x += w;
    w = 0.5;
    h = 40;
    lienView = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lienView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:lienView];
    
    x +=w;
    w = (Main_Screen_Width - 0.5)/2;
    _withdrawBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [_withdrawBtn setTitleColor:RGBCOLOR(127, 125, 147) forState:0];
    _withdrawBtn.titleLabel.font = AppFont;

    [_withdrawBtn setTitle:@"提现" forState:0];
    [_withdrawBtn setImage:[UIImage imageNamed:@"-icon_cash"] forState:0];
    
    [self.contentView addSubview:_withdrawBtn];

    y +=h;
    
}
-(void)prepareUI2{
    
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    CGFloat x = 10;
    CGFloat y = 10;
    CGFloat w = Main_Screen_Width - 20;
    CGFloat h = 20;

    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.textColor = [UIColor darkTextColor];
    NSString * ss;
    if ([_QXModel.integralType isEqualToString:@"0"]) {
        ss = @"采点";
    }
    else
    {
        ss = @"赠点";
 
    }
    lbl.text = ss;//@"采点";
    [self.contentView addSubview:lbl];
    
    
    y +=h + 8;
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.textColor = [UIColor grayColor];
    if ([_QXModel.tradeType isEqualToString:@"0"]) {
        ss = @"充值";
    }
    else if([_QXModel.tradeType isEqualToString:@"1"]){
        ss = @"做任务";

    }
    else if([_QXModel.tradeType isEqualToString:@"2"]){
        ss = @"出售商品";
        
    }
    else if([_QXModel.tradeType isEqualToString:@"3"]){
        ss = @"代购单退款";
        
    }
    else if([_QXModel.tradeType isEqualToString:@"4"]){
        ss = @"完成代购";
        
    }
    else if([_QXModel.tradeType isEqualToString:@"5"]){
        ss = @"购买商品退款";
        
    }
    else if([_QXModel.tradeType isEqualToString:@"6"]){
        ss = @"发布代购单";
        
    }
    else if([_QXModel.tradeType isEqualToString:@"10"]){
        ss = @"提现";
        
    }
    else if([_QXModel.tradeType isEqualToString:@"12"]){
        ss = @"购买商品";
        
    }


    lbl.text = ss;//@"充值";
    lbl.font = AppFont;
    [self.contentView addSubview:lbl];
    
    y += h + 10;
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.textColor = [UIColor grayColor];
    //
    
    ss = [CommonUtil getStringWithLong:[_QXModel.modifyDate longLongValue] Format:@"yyyy-MM-dd HH:mm"];
    lbl.text = ss;//@"2015-09-09 13:22";
    lbl.font = AppFont;
    [self.contentView addSubview:lbl];
    y += h + 8;
    
    NSLog(@"%f",y);
    y = (y - 20)/2;
    w = Main_Screen_Width - 10;
    h = 20;
    x = 0;
    
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.textAlignment = NSTextAlignmentRight;
    lbl.textColor = AppCOLOR;//[UIColor grayColor];
    if ([_QXModel.tradeType isEqualToString:@"3"]||[_QXModel.tradeType isEqualToString:@"5"]||[_QXModel.tradeType isEqualToString:@"10"]||[_QXModel.tradeType isEqualToString:@"12"]) {
        ss = @"-";
        
        
    }
    else
    {
        ss = @"+";
    }
    ss = [NSString stringWithFormat:@"%@%@",ss,_QXModel.integral];
    lbl.text = ss;//@"+18888.00";
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
