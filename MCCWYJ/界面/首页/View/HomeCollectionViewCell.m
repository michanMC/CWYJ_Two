//
//  HomeCollectionViewCell.m
//  MCCWYJ
//
//  Created by MC on 16/5/7.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "HomeCollectionViewCell.h"

@implementation HomeCollectionViewCell

-(void)prepareMeUI{
    for (UIView* obj in self.contentView.subviews)
        [obj removeFromSuperview];
    
    self.contentView.backgroundColor = AppMCBgCOLOR;//[UIColor whiteColor];
//    return;
    //110*MCHeightScale + 85
    CGFloat selfViewH = 110*MCHeightScale + 85;
    CGFloat selfViewW = (Main_Screen_Width - 30)/2;
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(5, 2, selfViewW-5, selfViewH-2)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgView];

    UIImageView * imgview = [[UIImageView alloc]initWithFrame:CGRectMake(5, 2, selfViewW - 5, 110*MCHeightScale - 2 )];
    
    if (_BuyModlel.imageUrl.count) {
        [imgview sd_setImageWithURL:[NSURL URLWithString:_BuyModlel.imageUrl[0]] placeholderImage:[UIImage imageNamed:@"home_default-photo"]];

    }
    else
    imgview.image = [UIImage imageNamed:@"home_default-photo"];
    [self.contentView addSubview:imgview];
    imgview.contentMode = UIViewContentModeScaleAspectFill;
imgview.clipsToBounds = YES; // 裁剪边缘
    
    
    CGFloat x = 10;
    CGFloat y = 110 * MCHeightScale + 5;
    CGFloat w = selfViewW - x *2;
    CGFloat h = 40;
    
    UILabel * titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
//    titleLbl.text = @"2015年9月,我们完成一次日本两周...";
    NSString * titleStr = _BuyModlel.title;
    if (_BuyModlel.brand.length) {
        titleStr = [NSString stringWithFormat:@"【%@】%@",_BuyModlel.brand,_BuyModlel.title];
    }

    titleLbl.text = titleStr;//[NSString stringWithFormat:@"【%@】%@",_BuyModlel.brand,_BuyModlel.title];//@"2015年9月,我们完成一次日本两周...";

    titleLbl.textColor = AppTextCOLOR;
    titleLbl.font = [UIFont systemFontOfSize:15];
    titleLbl.numberOfLines = 0;
    [self.contentView addSubview:titleLbl];
    
    y +=h + 5;
    w = 30;
    h = w;
    
    
    
    
     _headerimgBtn= [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
//    [_headerimgBtn setImage:[UIImage imageNamed:@"home_Avatar_60"] forState:0];
    [_headerimgBtn sd_setImageWithURL:[NSURL URLWithString:_BuyModlel.userModel.raw] forState:0 placeholderImage:[UIImage imageNamed:@"home_Avatar_60"]];

    ViewRadius(_headerimgBtn, w/2);
    [self.contentView addSubview:_headerimgBtn];

    x += w + 10;
    w = selfViewW - x - 10;
    UILabel * nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    nameLbl.text = _BuyModlel.userModel.nickname;
    nameLbl.textColor = AppTextCOLOR;
    nameLbl.font = AppFont;
    [self.contentView addSubview:nameLbl];

    
    
    UIImageView * shouImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0.5, 30, 25)];
    
    if ([_BuyModlel.type isEqualToString:@"pick"]) {
        shouImg.image = [UIImage imageNamed:@"求"];
        
    }
    else if ([_BuyModlel.type isEqualToString:@"show"])
    {
        shouImg.image = [UIImage imageNamed:@"晒"];
        
    }
    else if ([_BuyModlel.type isEqualToString:@"sell"])
    {
        shouImg.image = [UIImage imageNamed:@"售"];
        
    }

    
//    shouImg.image = [UIImage imageNamed:@"求"];
    [self.contentView addSubview:shouImg];
    
    
   ViewRadius(self.contentView, 3);

}
-(void)prepareHotUI;
{
    for (UIView* obj in self.contentView.subviews)
        [obj removeFromSuperview];
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
  //  return CGSizeMake((Main_Screen_Width - 30)/2, 110*MCHeightScale + 85);

    CGFloat selfH = 110*MCHeightScale + 85;
    CGFloat selfViewW =(Main_Screen_Width - 30)/2;
    UIImageView * imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, selfViewW, 110*MCHeightScale)];
    if (_BuyModlel.imageUrl.count) {
        [imgview sd_setImageWithURL:[NSURL URLWithString:_BuyModlel.imageUrl[0]] placeholderImage:[UIImage imageNamed:@"home_default-photo"]];
        
    }
    else
        imgview.image = [UIImage imageNamed:@"home_default-photo"];
//    imgview.image = [UIImage imageNamed:@"home_default-photo"];
    [self.contentView addSubview:imgview];
    imgview.contentMode = UIViewContentModeScaleAspectFill;
    imgview.clipsToBounds = YES; // 裁剪边缘

    CGFloat x = 10;
    CGFloat y = 110 * MCHeightScale + 5;
    CGFloat w = selfViewW - x *2;
    CGFloat h = 40;
    
    UILabel * titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    NSString * titleStr = _BuyModlel.title;
    if (_BuyModlel.brand.length) {
     titleStr = [NSString stringWithFormat:@"【%@】%@",_BuyModlel.brand,_BuyModlel.title];
    }
    
    titleLbl.text = titleStr;//[NSString stringWithFormat:@"【%@】%@",_BuyModlel.brand,_BuyModlel.title];//@"2015年9月,我们完成一次日本两周...";
    titleLbl.textColor = AppTextCOLOR;
    titleLbl.font = [UIFont systemFontOfSize:15];
    titleLbl.numberOfLines = 0;
    [self.contentView addSubview:titleLbl];
    
    y +=h + 5;
    w = selfViewW  - x - 10 - 40 - 5;
    h =20;
    UILabel * jiaqianLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    jiaqianLbl.text = [NSString stringWithFormat:@"￥%@",_BuyModlel. price];//@"￥233.00";
    jiaqianLbl.textColor = AppRegTextCOLOR;
    jiaqianLbl.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:jiaqianLbl];

    x = selfViewW - 10 - 40;
    w = 40;
    _buyBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];

    NSString * ss;
    _buyBtn.titleLabel.font = AppFont;

    if (_BuyModlel.status == 0) {
        ss = @"可售";
        _buyBtn.backgroundColor = AppRegTextCOLOR;
        [_buyBtn setTitleColor:[UIColor whiteColor] forState:0];
    }
    else if (_BuyModlel.status == 1)
    {
        ss = @"售罄";
        _buyBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_buyBtn setTitleColor:[UIColor grayColor] forState:0];

    }
    else if (_BuyModlel.status == 2)
    {
        ss = @"已关闭";
        _buyBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_buyBtn setTitleColor:[UIColor grayColor] forState:0];
        _buyBtn.titleLabel.font = [UIFont systemFontOfSize:12];

    }

    [_buyBtn setTitle:ss forState:0];
    ViewRadius(_buyBtn, 5);
    
    [self.contentView addSubview:_buyBtn];

    x = 10;
    y +=h + 5;
    w = 30;
    h = w;
    
    
    
    
    _headerimgBtn= [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [_headerimgBtn sd_setImageWithURL:[NSURL URLWithString:_BuyModlel.userModel.raw] forState:0 placeholderImage:[UIImage imageNamed:@"home_Avatar_60"]];
    ViewRadius(_headerimgBtn, w/2);
    [self.contentView addSubview:_headerimgBtn];
    
    x += w + 10;
    w = selfViewW - x - 10;
    UILabel * nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
//    nameLbl.text= @"michan";
    nameLbl.text = _BuyModlel.userModel.nickname;
    nameLbl.textColor = AppTextCOLOR;
    nameLbl.font = AppFont;
    [self.contentView addSubview:nameLbl];
    
    

    
    ViewRadius(self.contentView, 3);
    
    

}
-(void)prepareYJUI{
    for (UIView* obj in self.contentView.subviews)
        [obj removeFromSuperview];
    
    
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    CGFloat selfH =150*MCHeightScale;
    CGFloat selfW = Main_Screen_Width - 20;
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, selfW, selfH)];
    imgView.image = [UIImage imageNamed:@"home_default-photo2"];
    
    if ([_model.YJphotos count]) {
        YJphotoModel * pohos = _model.YJphotos[0];
        [imgView sd_setImageWithURL:[NSURL URLWithString:pohos.thumbnail] placeholderImage:[UIImage imageNamed:@"home_default-photo2"]];
        
    }
    else
    {
        imgView.image = [UIImage imageNamed:@"home_default-photo2"];
        
        
    }
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.clipsToBounds = YES; // 裁剪边缘

    [self.contentView addSubview:imgView];
    
    
    CGFloat x = 10;
    CGFloat y = 10;
    CGFloat w = selfW - 20;
    CGFloat h = 20;
    
    UILabel * titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    titleLbl.text = _model.title;//@"日本14日自由行";
    titleLbl.textColor = [UIColor whiteColor];
    [self.contentView addSubview:titleLbl];
    
    y +=h + 5;
    h = 40;
    
    UIView * bgview = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, h)];
//    bgview.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:bgview];
    
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, 3, 20)];
    lineView.backgroundColor = AppCOLOR;
    ViewRadius(lineView, 1.5);
    [bgview addSubview:lineView];
    w = selfW - x;
    h = 20;

    UILabel * timeLbl = [[UILabel alloc]initWithFrame:CGRectMake(3 + 5, 0, w, h)];
    timeLbl.textColor = [UIColor whiteColor];
    timeLbl.font = AppFont;
    NSString * timeStr = [CommonUtil getStringWithLong:_model.createDate Format:@"yyyy-MM-dd"];
    timeLbl.text = timeStr?timeStr:@"未知";
    [bgview addSubview:timeLbl];
    
    UILabel * dingweiLbl = [[UILabel alloc]initWithFrame:CGRectMake(3 + 5, 20, w, h)];
    dingweiLbl.textColor = [UIColor whiteColor];
    dingweiLbl.font = AppFont;
    dingweiLbl.text = _model.spotName;//@"富良野";
    [bgview addSubview:dingweiLbl];


    
    
    x = 10;
    w = 30;
    h = w;
    y = selfH - 10 - w;
    _headerimgBtn= [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
//    [_headerimgBtn setImage:[UIImage imageNamed:@"home_Avatar_60"] forState:0];
    //头像
    if(_model.userModel.raw)
    {
        [_headerimgBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:_model.userModel.raw] forState:0 placeholderImage:[UIImage imageNamed:@"home_Avatar_60"]];
        
    }
    else
    {
        [_headerimgBtn setBackgroundImage:[UIImage imageNamed:@"home_Avatar_60"] forState:0];
    }
    

    
    ViewRadius(_headerimgBtn, w/2);
    [self.contentView addSubview:_headerimgBtn];
    x += w + 10;
    w = selfW - x - 10;
    UILabel * nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    //姓名
    if (_model.userModel.nickname) {
        nameLbl.text = _model.userModel.nickname;
    }
    else
    {
        nameLbl.text = @"游客";
    }
    nameLbl.textColor = [UIColor whiteColor];
    nameLbl.font = AppFont;
    [self.contentView addSubview:nameLbl];

  CGFloat nameLblW =  [MCIucencyView heightforString:nameLbl.text andHeight:30 fontSize:14];
    
    
    x = nameLblW + nameLbl.mj_x + 20;
    
    
    NSString * commentCoun= @"0";
    
    
    CGFloat countBtnW =  [MCIucencyView heightforString:_model.commentCount ? _model.commentCount:commentCoun  andHeight:30 fontSize:14];
    w = countBtnW + 30 + 10;
    UIButton *_countBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [_countBtn setImage:[UIImage imageNamed:@"home_icon_number"] forState:0];
    [_countBtn setTitle:_model.commentCount ? _model.commentCount:commentCoun forState:0];
    [_countBtn setTitleColor:[UIColor whiteColor] forState:0];
    _countBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_countBtn];

    
    
    

    ViewRadius(self.contentView, 3);
  
}




@end
