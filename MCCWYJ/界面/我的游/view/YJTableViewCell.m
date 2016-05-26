//
//  YJTableViewCell.m
//  MCCWYJ
//
//  Created by MC on 16/5/14.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "YJTableViewCell.h"

@implementation YJTableViewCell



-(void)prepareUI:(homeYJModel*)model{

    for (UIView* obj in self.contentView.subviews)
        [obj removeFromSuperview];
    
    CGFloat x = 10;
    CGFloat y = 10;
    CGFloat w = 100*MCHeightScale;
    CGFloat h = w;
    
    UIImageView * _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, w)];
    if ([model.YJphotos count]) {
        YJphotoModel * pohos = model.YJphotos[0];
        [_imgView sd_setImageWithURL:[NSURL URLWithString:pohos.thumbnail] placeholderImage:[UIImage imageNamed:@"buy_default-photo"]];

    }
    else
    {
        _imgView.image = [UIImage imageNamed:@"buy_default-photo"];

        
    }
    [self.contentView addSubview:_imgView];
    
    
    UIImageView *_biaoshiImg = [[UIImageView alloc]initWithFrame:CGRectMake(-5, -5, 30, 25)];
    
    _biaoshiImg.image = [UIImage imageNamed:@"游"];
    [_imgView addSubview:_biaoshiImg];
    
    
    _headerimgBtn= [[UIButton alloc]initWithFrame:CGRectMake(3, _imgView.mj_h - 20, 40, 40)];
//    [_headerimgBtn setImage:[UIImage imageNamed:@"home_Avatar_60"] forState:0];
    
    //头像
    if(model.userModel.thumbnail)
    {
        [_headerimgBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.userModel.thumbnail] forState:0 placeholderImage:[UIImage imageNamed:@"home_Avatar_60"]];
        
    }
    else
    {
        [_headerimgBtn setBackgroundImage:[UIImage imageNamed:@"home_Avatar_60"] forState:0];
    }

//    _headerimgBtn
    ViewRadius(_headerimgBtn, 40/2);
    _headerimgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    _headerimgBtn.layer.borderWidth = 1;
    [_imgView addSubview:_headerimgBtn];

    
    
    UILabel * _nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(_imgView.mj_x + 3 + _headerimgBtn.mj_w+ 5, _imgView.mj_h + _imgView.mj_y + 5, _imgView.mj_w - _headerimgBtn.mj_w - 3, 20)];
    [self.contentView addSubview:_nameLbl];
    _nameLbl.textColor = [UIColor darkTextColor];
    _nameLbl.font = AppFont;
    //姓名
    if (model.userModel.nickname) {
        _nameLbl.text = model.userModel.nickname;
    }
    else
    {
        _nameLbl.text = @"游客";
    }

    
    
    
    BOOL isjing = YES;
    x  = _imgView.mj_x + _imgView.mj_w + 10;

    if (!isjing) {
 
    }
    else
    {
        UIImageView * jingimg = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, 20, 20)];
        jingimg.image = [UIImage imageNamed:@"精"];
        [self.contentView addSubview:jingimg];
        
        
        
         x  = _imgView.mj_x + _imgView.mj_w + 10 + 20 + 5;
    }
    
    
    w = Main_Screen_Width - x - 7 - 30  - 30;
    y = _imgView.mj_y;
    h = 20;
    UILabel * titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    titleLbl.textColor = [UIColor darkTextColor];
    titleLbl.text = model.title;//@"西太平洋的新海角";
    [self.contentView addSubview:titleLbl];
    
    
    x = Main_Screen_Width - 7 - 30;
    w = 30;
    h = 30;
    y -= 5;
    UIButton * _caiBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [_caiBtn setImage:[UIImage imageNamed:@"踩"] forState:0];
    [self.contentView addSubview:_caiBtn];
    
    x -=w;
    UIButton * _shiBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w+3, h)];
    [_shiBtn setImage:[UIImage imageNamed:@"食"] forState:0];
    [self.contentView addSubview:_shiBtn];

    
    
    
    

    x = _imgView.mj_x + _imgView.mj_w + 10;
    y = titleLbl.mj_y + titleLbl.mj_h + 5;
    w = Main_Screen_Width - 10 - x;
    h = 40;
    
    UILabel *_subtitleLbl =[[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _subtitleLbl.textColor = [UIColor grayColor];
    _subtitleLbl.text = model.content;;//@"北马里亚娜依稀太平洋的新";
    _subtitleLbl.font = [UIFont systemFontOfSize:13];
    _subtitleLbl.numberOfLines = 0;
    [self.contentView addSubview:_subtitleLbl];
    
    
    
    CGFloat dingweiW = [MCIucencyView heightforString:model.spotName ?model.spotName :@"未知" andHeight:20 fontSize:14] + 20;
    if(dingweiW > 130*MCWidthScale)
        dingweiW = 130*MCWidthScale;
    
    y = _imgView.mj_y + _imgView.mj_h - 20 - 5;
    w = dingweiW;
    h = 20;
    
   _dingweibtn =  [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    
    [_dingweibtn setImage:[UIImage imageNamed:@"icon_map"] forState:0];
    [_dingweibtn setTitle:model.spotName ?model.spotName :@"未知" forState:0];
    [_dingweibtn setTitleColor:[UIColor grayColor] forState:0];
    _dingweibtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_dingweibtn];
    
    
    
    x += w + 5;
    w = 33;
    h = 18;
    UIImageView * dengjiimg = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    dengjiimg.image = [UIImage imageNamed:@"Lv_1"];
    [self.contentView addSubview:dengjiimg];
    
    
    x += w + 5;
    w = 10;
    UIImageView * shengimg = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    shengimg.image = [UIImage imageNamed:@"red_arrow"];
    [self.contentView addSubview:shengimg];

    
    
    x = Main_Screen_Width - 10 - 25;
    w = 25;
    
    UIImageView * pinglunimg = [[UIImageView alloc]initWithFrame:CGRectMake(x, y-2.5, w, 25)];
    pinglunimg.image = [UIImage imageNamed:@"icon_message1"];
    [self.contentView addSubview:pinglunimg];

    
    
    x = _subtitleLbl.mj_x;
    y = _imgView.mj_h + 10+10;
    CGFloat timeW = [MCIucencyView heightforString:[CommonUtil daysAgoAgainst:model.createDate]? [CommonUtil daysAgoAgainst:model.createDate] :@"未知" andHeight:20 fontSize:14] + 20;
    h = 20;
    
    UIButton * timeBtn =[[UIButton alloc]initWithFrame:CGRectMake(x, y, timeW, h)];
    
    [timeBtn setImage:[UIImage imageNamed:@"icon_time"] forState:0];
    [timeBtn setTitle:[CommonUtil daysAgoAgainst:model.createDate]? [CommonUtil daysAgoAgainst:model.createDate] :@"未知" forState:0];
    [timeBtn setTitleColor:[UIColor grayColor] forState:0];
    timeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:timeBtn];
    
    
    x = Main_Screen_Width - 10 - 100;
    w = 100;
    UILabel *_julilbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _julilbl.text = [NSString stringWithFormat:@"%.2fKm",[model.distance floatValue]/1000];//@"90cm";
    _julilbl.textColor = [UIColor grayColor];
    _julilbl.font = AppFont;
    _julilbl.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_julilbl];

    
    
    
    
    UIImageView * fujinimg = [[UIImageView alloc]initWithFrame:CGRectMake(10 + 3, _imgView.mj_h + 10+15, 40, 17)];
    fujinimg.image = [UIImage imageNamed:@"label_nearby"];
    [self.contentView addSubview:fujinimg];

    
//    UILabel * fujinlbl = [[UILabel alloc]initWithFrame:CGRectMake(10 + 3, _imgView.mj_h + 10+15, 40, 17)];
//    fujinlbl.text = @"附近";
//    fujinlbl.font = [UIFont systemFontOfSize:12];
//    fujinlbl.backgroundColor = [UIColor whiteColor];
//    fujinlbl.textAlignment = NSTextAlignmentCenter;
//    fujinlbl.textColor = [UIColor orangeColor];
//    fujinlbl.layer.borderColor = [UIColor orangeColor].CGColor;
//    fujinlbl.layer.borderWidth = 1;
//    ViewRadius(fujinlbl, 17/2);
//    [self.contentView addSubview:fujinlbl];

    
    
    
    
    
    
    
    
    
    
    
    
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
