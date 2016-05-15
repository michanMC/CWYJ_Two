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
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    //110*MCHeightScale + 85
    CGFloat selfViewH = 110*MCHeightScale + 85;
    CGFloat selfViewW = (Main_Screen_Width - 30)/2;
    UIImageView * imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, selfViewW, 110*MCHeightScale)];
    imgview.image = [UIImage imageNamed:@"home_default-photo"];
    [self.contentView addSubview:imgview];
    
    CGFloat x = 10;
    CGFloat y = 110 * MCHeightScale + 5;
    CGFloat w = selfViewW - x *2;
    CGFloat h = 40;
    
    UILabel * titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    titleLbl.text = @"2015年9月,我们完成一次日本两周...";
    titleLbl.textColor = AppTextCOLOR;
    titleLbl.font = [UIFont systemFontOfSize:16];
    titleLbl.numberOfLines = 0;
    [self.contentView addSubview:titleLbl];
    
    y +=h + 5;
    w = 30;
    h = w;
    
    
    
    
     _headerimgBtn= [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [_headerimgBtn setImage:[UIImage imageNamed:@"home_Avatar_60"] forState:0];
    ViewRadius(_headerimgBtn, w/2);
    [self.contentView addSubview:_headerimgBtn];

    x += w + 10;
    w = selfViewW - x - 10;
    UILabel * nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    nameLbl.text= @"michan";
    nameLbl.textColor = AppTextCOLOR;
    nameLbl.font = AppFont;
    [self.contentView addSubview:nameLbl];

    
    
    UIImageView * shouImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 25)];
    shouImg.image = [UIImage imageNamed:@"售"];
    [imgview addSubview:shouImg];
    
    
  //  ViewRadius(self.contentView, 3);

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
    imgview.image = [UIImage imageNamed:@"home_default-photo"];
    [self.contentView addSubview:imgview];
    
    CGFloat x = 10;
    CGFloat y = 110 * MCHeightScale + 5;
    CGFloat w = selfViewW - x *2;
    CGFloat h = 40;
    
    UILabel * titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    titleLbl.text = @"2015年9月,我们完成一次日本两周...";
    titleLbl.textColor = AppTextCOLOR;
    titleLbl.font = [UIFont systemFontOfSize:16];
    titleLbl.numberOfLines = 0;
    [self.contentView addSubview:titleLbl];
    
    y +=h + 5;
    w = selfViewW  - x - 10 - 40 - 5;
    h =20;
    UILabel * jiaqianLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    jiaqianLbl.text = @"￥233.00";
    jiaqianLbl.textColor = AppRegTextCOLOR;
    jiaqianLbl.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:jiaqianLbl];

    x = selfViewW - 10 - 40;
    w = 40;
    _buyBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _buyBtn.backgroundColor = AppRegTextCOLOR;
    [_buyBtn setTitleColor:[UIColor whiteColor] forState:0];
    [_buyBtn setTitle:@"可售" forState:0];
    ViewRadius(_buyBtn, 5);
    _buyBtn.titleLabel.font = AppFont;
    
    [self.contentView addSubview:_buyBtn];

    x = 10;
    y +=h + 5;
    w = 30;
    h = w;
    
    
    
    
    _headerimgBtn= [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [_headerimgBtn setImage:[UIImage imageNamed:@"home_Avatar_60"] forState:0];
    ViewRadius(_headerimgBtn, w/2);
    [self.contentView addSubview:_headerimgBtn];
    
    x += w + 10;
    w = selfViewW - x - 10;
    UILabel * nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    nameLbl.text= @"michan";
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
    [self.contentView addSubview:imgView];
    
    
    CGFloat x = 10;
    CGFloat y = 10;
    CGFloat w = selfW - 20;
    CGFloat h = 20;
    
    UILabel * titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    titleLbl.text = @"日本14日自由行";
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
    timeLbl.text = @"2016-10-12";
    [bgview addSubview:timeLbl];
    
    UILabel * dingweiLbl = [[UILabel alloc]initWithFrame:CGRectMake(3 + 5, 20, w, h)];
    dingweiLbl.textColor = [UIColor whiteColor];
    dingweiLbl.font = AppFont;
    dingweiLbl.text = @"富良野";
    [bgview addSubview:dingweiLbl];


    
    
    x = 10;
    w = 30;
    h = w;
    y = selfH - 10 - w;
    _headerimgBtn= [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [_headerimgBtn setImage:[UIImage imageNamed:@"home_Avatar_60"] forState:0];
    ViewRadius(_headerimgBtn, w/2);
    [self.contentView addSubview:_headerimgBtn];
    x += w + 10;
    w = selfW - x - 10;
    UILabel * nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    nameLbl.text= @"michan";
    nameLbl.textColor = AppTextCOLOR;
    nameLbl.font = AppFont;
    [self.contentView addSubview:nameLbl];

  CGFloat nameLblW =  [MCIucencyView heightforString:nameLbl.text andHeight:30 fontSize:14];
    
    
    x = nameLblW + nameLbl.mj_x + 20;
    CGFloat countBtnW =  [MCIucencyView heightforString:@"230" andHeight:30 fontSize:14];
    w = countBtnW + 30 + 10;
    UIButton *_countBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [_countBtn setImage:[UIImage imageNamed:@"icon_map"] forState:0];
    [_countBtn setTitle:@"230" forState:0];
    [_countBtn setTitleColor:[UIColor whiteColor] forState:0];
    _countBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_countBtn];

    
    
    

    ViewRadius(self.contentView, 3);
  
}




@end
