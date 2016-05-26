//
//  MCMyshoppingTableViewCell.m
//  MCCWYJ
//
//  Created by MC on 16/5/15.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MCMyshoppingTableViewCell.h"

@implementation MCMyshoppingTableViewCell


-(void)prepareNotitleUI
{
    
    for (UIView* obj in self.contentView.subviews)
        [obj removeFromSuperview];
    CGFloat x = 10;
    CGFloat y = 10;
    CGFloat w = 100*MCHeightScale;
    CGFloat h = w;
    
    UIImageView * _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, w)];
    _imgView.image = [UIImage imageNamed:@"buy_default-photo"];
    _imgView.userInteractionEnabled = YES;
    [self.contentView addSubview:_imgView];
    UIImageView *_biaoshiImg = [[UIImageView alloc]initWithFrame:CGRectMake(-5, -5, 30, 25)];
    
    _biaoshiImg.image = [UIImage imageNamed:@"采"];
    [_imgView addSubview:_biaoshiImg];

    _headerimgBtn= [[UIButton alloc]initWithFrame:CGRectMake(3, _imgView.mj_h - 20, 40, 40)];
    [_headerimgBtn setBackgroundImage:[UIImage imageNamed:@"home_Avatar_60"] forState:0];
    ViewRadius(_headerimgBtn, 40/2);
    _headerimgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    _headerimgBtn.layer.borderWidth = 1;
    [_imgView addSubview:_headerimgBtn];
    UILabel * _nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(_imgView.mj_x + 3 + _headerimgBtn.mj_w+ 5, _imgView.mj_h + _imgView.mj_y + 5, _imgView.mj_w - _headerimgBtn.mj_w - 3, 20)];
    [self.contentView addSubview:_nameLbl];
    _nameLbl.textColor = [UIColor darkTextColor];
    _nameLbl.font = AppFont;
        _nameLbl.text = @"游客";

    
    
    x = _imgView.mj_x + _imgView.mj_w + 10;
    y = _imgView.mj_y;
    
    w = [MCIucencyView heightforString:@"￥233.00" andHeight:20 fontSize:18];//Main_Screen_Width - x - 10;
    h = 20;
    
    
    UILabel *_priceLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _priceLbl.text = @"￥233.00";
    _priceLbl.textColor = AppCOLOR;
    _priceLbl.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:_priceLbl];
    
    x += w + 10;
    w = Main_Screen_Width - x - 10;
    
    UILabel *_weiziLbl =[[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _weiziLbl.text = @"法国";
    _weiziLbl.textColor = [UIColor grayColor];
    _weiziLbl.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_weiziLbl];
    
    x = _imgView.mj_x + _imgView.mj_w + 10;
    y += h +5;
    w = Main_Screen_Width - x - 10;
    h = 40;
    UILabel *_titleLbl =[[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _titleLbl.text = @"【娇兰】限量宝石限量宝石限量宝石限量宝石限量宝石限量宝石";
    _titleLbl.textColor = [UIColor grayColor];
    _titleLbl.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_titleLbl];
    
    y += h +5;
    h = 25;
    w = [MCIucencyView heightforString:@"已跟单" andHeight:25 fontSize:14] + 10;//Main_Screen_Width - x - 10;
    UILabel * _gendanStatelbl =[[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _gendanStatelbl.backgroundColor = [UIColor groupTableViewBackgroundColor];
    ViewRadius(_gendanStatelbl, 3);
    _gendanStatelbl.text = @"已跟单";
    _gendanStatelbl.textAlignment = NSTextAlignmentCenter;
    _gendanStatelbl.textColor = [UIColor grayColor];
    _gendanStatelbl.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_gendanStatelbl];


    y = _imgView.mj_y + _imgView.mj_h - 5;
    
     CGFloat timeW = [MCIucencyView heightforString:@"10分钟前" andHeight:20 fontSize:14] + 20;
    
    UIButton * timeBtn =[[UIButton alloc]initWithFrame:CGRectMake(x, y, timeW, h)];
    
    [timeBtn setImage:[UIImage imageNamed:@"icon_time"] forState:0];
    [timeBtn setTitle:@"10分钟前" forState:0];
    [timeBtn setTitleColor:[UIColor grayColor] forState:0];
    timeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:timeBtn];

    //    return 100 *MCHeightScale + 15 + 20 + 15;

    y = 100 *MCHeightScale + 15 + 20 + 10 - 15 - 25;
    w = 50;
    h = 25;
    x = Main_Screen_Width - 10 - 50;
    _shoppingBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _shoppingBtn.backgroundColor = AppCOLOR;
    [_shoppingBtn setTitleColor:[UIColor whiteColor] forState:0];
    _shoppingBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_shoppingBtn setTitle:@"跟单" forState:0];
    ViewRadius(_shoppingBtn, 3);
    [self.contentView addSubview:_shoppingBtn];

    
    
    
    
    
}

-(void)prepareHastitleUI{
    
    for (UIView* obj in self.contentView.subviews)
        [obj removeFromSuperview];

    UIView * _titleBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 44)];
    _titleBgView.backgroundColor = [UIColor whiteColor];
    [self.contentView  addSubview:_titleBgView];
    
    UIImageView *BSimgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, (44 - 20)/2, 20, 20)];
    BSimgView.image = [UIImage imageNamed:@"icon_share"];
    [_titleBgView addSubview:BSimgView];
    
    UILabel *_shareLbl =[[UILabel alloc]initWithFrame:CGRectMake(35, 0, Main_Screen_Width - 45, 44)];
    _shareLbl.text = @"好友@michan收藏了该订单";
    _shareLbl.textColor = AppCOLOR;
    _shareLbl.font = [UIFont systemFontOfSize:14];
    [_titleBgView addSubview:_shareLbl];

    
    
    CGFloat x = 10;
    CGFloat y = 44 + 10;
    CGFloat w = 100*MCHeightScale;
    CGFloat h = w;
    
    UIImageView * _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, w)];
    _imgView.image = [UIImage imageNamed:@"buy_default-photo"];
    [self.contentView addSubview:_imgView];
    UIImageView *_biaoshiImg = [[UIImageView alloc]initWithFrame:CGRectMake(-5, -5, 30, 25)];
    
    _biaoshiImg.image = [UIImage imageNamed:@"售"];
    [_imgView addSubview:_biaoshiImg];
    
    _headerimgBtn= [[UIButton alloc]initWithFrame:CGRectMake(3, _imgView.mj_h - 20, 40, 40)];
    [_headerimgBtn setBackgroundImage:[UIImage imageNamed:@"home_Avatar_60"] forState:0];
    ViewRadius(_headerimgBtn, 40/2);
    _headerimgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    _headerimgBtn.layer.borderWidth = 1;
    [_imgView addSubview:_headerimgBtn];
    UILabel * _nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(_imgView.mj_x + 3 + _headerimgBtn.mj_w+ 5, _imgView.mj_h + _imgView.mj_y + 5, _imgView.mj_w - _headerimgBtn.mj_w - 3, 20)];
    [self.contentView addSubview:_nameLbl];
    _nameLbl.textColor = [UIColor darkTextColor];
    _nameLbl.font = AppFont;
    _nameLbl.text = @"游客";
    
    
    
    x = _imgView.mj_x + _imgView.mj_w + 10;
    y = _imgView.mj_y;
    
    w = [MCIucencyView heightforString:@"￥233.00" andHeight:20 fontSize:18];//Main_Screen_Width - x - 10;
    h = 20;
    
    
    UILabel *_priceLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _priceLbl.text = @"￥233.00";
    _priceLbl.textColor = AppCOLOR;
    _priceLbl.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:_priceLbl];
    
    x += w + 10;
    w = Main_Screen_Width - x - 10;
    
    UILabel *_weiziLbl =[[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _weiziLbl.text = @"法国";
    _weiziLbl.textColor = [UIColor grayColor];
    _weiziLbl.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_weiziLbl];
    
    x = _imgView.mj_x + _imgView.mj_w + 10;
    y += h +5;
    w = Main_Screen_Width - x - 10;
    h = 40;
    UILabel *_titleLbl =[[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _titleLbl.text = @"【娇兰】限量宝石限量宝石限量宝石限量宝石限量宝石限量宝石";
    _titleLbl.textColor = [UIColor grayColor];
    _titleLbl.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_titleLbl];
    
    y += h +5;
    h = 25;
    w = [MCIucencyView heightforString:@"已跟单" andHeight:25 fontSize:14] + 10;//Main_Screen_Width - x - 10;
    UILabel * _gendanStatelbl =[[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _gendanStatelbl.backgroundColor = [UIColor groupTableViewBackgroundColor];
    ViewRadius(_gendanStatelbl, 3);
    _gendanStatelbl.text = @"可售";
    _gendanStatelbl.textAlignment = NSTextAlignmentCenter;
    _gendanStatelbl.textColor = [UIColor grayColor];
    _gendanStatelbl.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_gendanStatelbl];
    
    
    y = _imgView.mj_y + _imgView.mj_h - 5;
    
    CGFloat timeW = [MCIucencyView heightforString:@"10分钟前" andHeight:20 fontSize:14] + 20;
    
    UIButton * timeBtn =[[UIButton alloc]initWithFrame:CGRectMake(x, y, timeW, h)];
    
    [timeBtn setImage:[UIImage imageNamed:@"icon_time"] forState:0];
    [timeBtn setTitle:@"10分钟前" forState:0];
    [timeBtn setTitleColor:[UIColor grayColor] forState:0];
    timeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:timeBtn];
    
    //    return 100 *MCHeightScale + 15 + 20 + 15;
    
    y = 100 *MCHeightScale + 15 + 20 + 10 +44   - 15 - 25;
    w = 50;
    h = 25;
    x = Main_Screen_Width - 10 - 50;
    _shoppingBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _shoppingBtn.backgroundColor = AppCOLOR;
    [_shoppingBtn setTitleColor:[UIColor whiteColor] forState:0];
    _shoppingBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_shoppingBtn setTitle:@"购买" forState:0];
    ViewRadius(_shoppingBtn, 3);
    [self.contentView addSubview:_shoppingBtn];
    
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
