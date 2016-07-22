//
//  ShoppingFillTableViewCell.m
//  MCCWYJ
//
//  Created by MC on 16/6/22.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "ShoppingFillTableViewCell.h"

@implementation ShoppingFillTableViewCell
-(void)prepareUI1{
    for (UIView *view in self.contentView.subviews)
        [view removeFromSuperview];
    CGFloat x = Main_Screen_Width/2 +40;
    CGFloat y = 10;
    CGFloat w = Main_Screen_Width - x - 10;
    CGFloat h = 30;

    UIImageView * view = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
//    view.backgroundColor = [UIColor whiteColor];
//    ViewRadius(view, 30/2);
//    view.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
//    view.layer.borderWidth = 1;
    view.image = [UIImage imageNamed:@"数量增减1"];
    view.userInteractionEnabled = YES;
    [self.contentView addSubview:view];
    
    w = view.mj_w / 3;
    x = 0;
    y = 0;
    h = 30;
    _minBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [_minBtn setTitle:@"" forState:0];
    [_minBtn setTitleColor:RGBCOLOR(127, 125, 147) forState:0];
    //    _minBtn.backgroundColor = [UIColor yellowColor];
    [view addSubview:_minBtn];
    
    
    x +=w;
    _countfield = [[UITextField alloc]initWithFrame:CGRectMake(x, y+1, w, h - 2)];
    _countfield.font = AppFont;
    _countfield.textColor = AppCOLOR;
    _countfield.backgroundColor = [UIColor whiteColor];
    _countfield.text = @"1";
    _countfield.textAlignment = NSTextAlignmentCenter;
//    _countfield.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
//    _countfield.layer.borderWidth = 1;
    
    _countfield.keyboardType  = UIKeyboardTypeNumberPad;
    [view addSubview:_countfield];
    x +=w;
    _addBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [_addBtn setTitle:@"" forState:0];
    [_addBtn setTitleColor:RGBCOLOR(127, 125, 147) forState:0];
    //    _addBtn.backgroundColor = [UIColor yellowColor];
    [view addSubview:_addBtn];
    

    x = view.mj_x;
    y = view.mj_y + view.mj_h;
    w  = view.mj_w;
    h = 20;
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.textColor = AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:13];
    lbl.text = [NSString stringWithFormat:@"剩余数量:%@", _BuyModlel.lastCount];
    lbl.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:lbl];
    
   // 10+30 + 20;
    
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, 60)];
    lbl.textColor = AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:14];
    lbl.text = @"购买数量";
    [self.contentView addSubview:lbl];
    
}
-(void)prepareUI2{
    for (UIView *view in self.contentView.subviews)
        [view removeFromSuperview];

    CGFloat x = 10;
    CGFloat y = 0;
    CGFloat w = 200;
    CGFloat h = 44;
    

    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.textColor = AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:16];
    lbl.text = @"所需支付金额";
    [self.contentView addSubview:lbl];
    
    // 10+30 + 20;
    x = Main_Screen_Width - 10 - 200;
    w = 200;
    h = 44;
    y = 0;
    _priceLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    
    _priceLbl.textColor = RGBCOLOR(207, 0, 51);
    _priceLbl.font = [UIFont systemFontOfSize:16];
    _priceLbl.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_priceLbl];
    
    
}
-(void)prepareUI3{
    for (UIView *view in self.contentView.subviews)
        [view removeFromSuperview];
 
    
    CGFloat x = 10;
    CGFloat y = 0;
    CGFloat w = 100;
    CGFloat h = 44;
    
    
    _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _titleLbl.textColor = AppTextCOLOR;
    _titleLbl.font = [UIFont systemFontOfSize:14];
    _titleLbl.text = @"收货地址";
    [self.contentView addSubview:_titleLbl];
    
    x +=w;
    w = Main_Screen_Width - 30 - x;
    _addLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _addLbl.textColor = AppTextCOLOR;
    _addLbl.font = [UIFont systemFontOfSize:15];
    _addLbl.textAlignment = NSTextAlignmentRight;
//    _addLbl.text = @"请选择地址";
    [self.contentView addSubview:_addLbl];

    
    
    
}
-(void)prepareUI4{
    for (UIView *view in self.contentView.subviews)
        [view removeFromSuperview];
    CGFloat x = 10;
    CGFloat  y = 10;
    CGFloat w = 22;
    CGFloat h = 22;
    _seleBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [_seleBtn setImage:[UIImage imageNamed:@"list_checkbox_normal"] forState:UIControlStateNormal];
    [_seleBtn setImage:[UIImage imageNamed:@"list_checkbox_checked"] forState:UIControlStateSelected];
    [self.contentView addSubview:_seleBtn];
    
    x += w + 10;
    w = Main_Screen_Width - x - 10;
    y = 0;
    h = 44;
    _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _titleLbl.textColor = AppTextCOLOR;
    _titleLbl.font = [UIFont systemFontOfSize:15];
    _titleLbl.text = @"因为信，所以买";
    [self.contentView addSubview:_titleLbl];

    

}
-(void)prepareUI5{
    for (UIView *view in self.contentView.subviews)
        [view removeFromSuperview];

    CGFloat x = 10;
    CGFloat  y = 0;
    CGFloat w = 200;
    CGFloat h = 44;
    _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _titleLbl.textColor = AppTextCOLOR;
    _titleLbl.font = [UIFont systemFontOfSize:15];
    _titleLbl.text = @"是否匿名";
    [self.contentView addSubview:_titleLbl];
    
    w = 22;
    x =Main_Screen_Width - 10 -w;
      y = 10;
     h = 22;
    _seleBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [_seleBtn setImage:[UIImage imageNamed:@"list_checkbox_normal"] forState:UIControlStateNormal];
    [_seleBtn setImage:[UIImage imageNamed:@"list_checkbox_checked"] forState:UIControlStateSelected];
    [self.contentView addSubview:_seleBtn];

    

    
}
-(void)prepareUI6{
    
    for (UIView *view in self.contentView.subviews)
        [view removeFromSuperview];
    
    CGFloat x = 10;
    CGFloat  y = 10;
    NSString * ss = [NSString stringWithFormat:@"赠点:%.2f赠点",[_sytemIntegral floatValue]];
    CGFloat w = [MCIucencyView heightforString:ss andHeight:20 fontSize:16];
    CGFloat h = 20;
    _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _titleLbl.textColor = AppTextCOLOR;
    _titleLbl.font = [UIFont systemFontOfSize:16];
    _titleLbl.text = ss;//@"是否匿名";
    [self.contentView addSubview:_titleLbl];
    x += w + 10;
    w = 60;
    h = 20;
    
    _IntegralBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [_IntegralBtn setTitle:@"赚赠点" forState:0];
    [_IntegralBtn setTitleColor:RGBCOLOR(207, 0, 51) forState:0];
    _IntegralBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_IntegralBtn];

    y+=h + 5;
    x = 10;
    w = Main_Screen_Width;
    h = 20;
    
    UILabel* lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    
    lbl.textColor = [UIColor grayColor];
    lbl.font = [UIFont systemFontOfSize:13];
    lbl.text = @"使用赠送积分不能超过总额的10%";
    [self.contentView addSubview:lbl];

    w = Main_Screen_Width - 10 -22 - 10;
    x = 0;
    y = 0;
    h = 5 + 20 + 5 + 20 + 5 + 5;
    _sytemminLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _sytemminLbl.textColor = AppTextCOLOR;
    _sytemminLbl.font = [UIFont systemFontOfSize:14];
    _sytemminLbl.text = @"已抵用66元";
    _sytemminLbl.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_sytemminLbl];
    w = 30;
    x =Main_Screen_Width - 10 -w;
    y = (h - w)/2;
    h = 30;
    _seleBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [_seleBtn setImage:[UIImage imageNamed:@"list_checkbox_normal"] forState:UIControlStateNormal];
    [_seleBtn setImage:[UIImage imageNamed:@"list_checkbox_checked"] forState:UIControlStateSelected];
    _seleBtn.selected = YES;
    [self.contentView addSubview:_seleBtn];

}
-(void)prepareUI7{
    
    for (UIView *view in self.contentView.subviews)
        [view removeFromSuperview];
    
    CGFloat x = 10;
    CGFloat  y = 0;
    NSString * ss = [NSString stringWithFormat:@"采点:￥%.2f采点",[_rechargeIntegral floatValue]];
    CGFloat w = [MCIucencyView heightforString:ss andHeight:50 fontSize:16];
    CGFloat h = 50;
    _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _titleLbl.textColor = AppTextCOLOR;
    _titleLbl.font = [UIFont systemFontOfSize:15];
    _titleLbl.text = ss;//@"是否匿名";
    [self.contentView addSubview:_titleLbl];

    
    w = Main_Screen_Width - 10 -22 - 10;
    x = 0;
    y = 0;
    h = 50;
    _rechargeminLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _rechargeminLbl.textColor = AppTextCOLOR;
    _rechargeminLbl.font = [UIFont systemFontOfSize:14];
    _rechargeminLbl.text = @"已抵用66元";
    _rechargeminLbl.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_rechargeminLbl];

    w = 30;
    x =Main_Screen_Width - 10 -w;
    y = (h - w)/2;
    h = 30;
    _seleBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [_seleBtn setImage:[UIImage imageNamed:@"list_checkbox_normal"] forState:UIControlStateNormal];
    [_seleBtn setImage:[UIImage imageNamed:@"list_checkbox_checked"] forState:UIControlStateSelected];
    [self.contentView addSubview:_seleBtn];

    
}
-(void)prepareUI8{
    
    for (UIView *view in self.contentView.subviews)
        [view removeFromSuperview];
    
    CGFloat x = 0;
    CGFloat  y = 0;
    CGFloat w = Main_Screen_Width - 10;
    CGFloat h = 44;
    _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _titleLbl.textColor = AppTextCOLOR;
    _titleLbl.textAlignment = NSTextAlignmentRight;
    _titleLbl.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_titleLbl];
    
}
-(void)prepareUI9{
    for (UIView *view in self.contentView.subviews)
        [view removeFromSuperview];
    
    CGFloat x = 10;
    CGFloat  y = 10;
    CGFloat w = 40;
    CGFloat h = w;
    _imgview = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [self.contentView addSubview:_imgview];
    x +=w + 10;
    y = 0;
    w = 100;
    h = 60;
    _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _titleLbl.textColor = AppTextCOLOR;
    _titleLbl.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_titleLbl];

    
    w = 22;
    x =Main_Screen_Width - 10 -w;
    y = (60 - w)/2;
    h = 22;
    _seleBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [_seleBtn setImage:[UIImage imageNamed:@"list_checkbox_normal"] forState:UIControlStateNormal];
    [_seleBtn setImage:[UIImage imageNamed:@"list_checkbox_checked"] forState:UIControlStateSelected];
    _seleBtn.userInteractionEnabled = NO;
    [self.contentView addSubview:_seleBtn];
 
    
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
