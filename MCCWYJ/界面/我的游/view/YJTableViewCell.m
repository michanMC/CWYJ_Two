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

    CGFloat vy = 0;
    if (_isfriendPlay) {
        if (model.YJoptsArray.count)
       vy = 44;
    }

    
    
    
    
    _Bg2View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 100 *MCHeightScale + 15 + 20 + 15)];

    _Bg2View.backgroundColor = AppMCBgCOLOR;//[UIColor groupTableViewBackgroundColor];
    _selectBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, (100 *MCHeightScale + 15 + 20 + 15 - 30)/2, 30, 30)];
    [_selectBtn setImage:[UIImage imageNamed:@"list_checkbox_normal"] forState:UIControlStateNormal];
    [_selectBtn setImage:[UIImage imageNamed:@"list_checkbox_checked"] forState:UIControlStateSelected];
    [_Bg2View addSubview:_selectBtn];
    [self.contentView addSubview:_Bg2View];

    _BgView = [[UIView alloc]initWithFrame:CGRectMake(0, vy, Main_Screen_Width, 100 *MCHeightScale + 15 + 20 + 15)];
    _BgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_BgView];
    
    
    CGFloat x = 10;
    CGFloat y = 10;
    CGFloat w = 100*MCHeightScale;
    CGFloat h = w;
    
     _imgView= [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, w)];
    _imgView.userInteractionEnabled = YES;

    if ([model.YJphotos count]) {
        YJphotoModel * pohos = model.YJphotos[0];
        [_imgView sd_setImageWithURL:[NSURL URLWithString:pohos.thumbnail] placeholderImage:[UIImage imageNamed:@"buy_default-photo"]];

    }
    else
    {
        _imgView.image = [UIImage imageNamed:@"buy_default-photo"];

        
    }
    [_BgView addSubview:_imgView];
//    _imgView.contentMode = UIViewContentModeScaleAspectFill;
//    _imgView.clipsToBounds = YES; // 裁剪边缘

    
    
    
    UIImageView *_biaoshiImg = [[UIImageView alloc]initWithFrame:CGRectMake(-5, -5, 30, 25)];
    
    _biaoshiImg.image = [UIImage imageNamed:@"游"];
    [_imgView addSubview:_biaoshiImg];
    
    if (_tixing) {
        
    
    _BadgeView  = [[JSBadgeView alloc] initWithParentView:_imgView alignment:JSBadgeViewAlignmentTopRight];
    NSMutableArray *travelRemindArray =  [MCIucencyView travelRemindArray];
    NSInteger count = 0;
    
    for (NSString * indexid in travelRemindArray) {
        
        if ([indexid isEqualToString:model.id]) {
            count++;
        }
    }
    if (count> 0) {
        
        _BadgeView.badgeText = [NSString stringWithFormat:@"%zd",count];
    }
    else
    {
        [_BadgeView removeFromSuperview];
    }

    }
    
    
    _headerimgBtn= [[UIButton alloc]initWithFrame:CGRectMake(_imgView.mj_x + 3,_imgView.mj_y + _imgView.mj_h - 20, 40, 40)];
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
    [_BgView addSubview:_headerimgBtn];

    
    
    UILabel * _nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(_imgView.mj_x + 3 + _headerimgBtn.mj_w+ 5, _imgView.mj_h + _imgView.mj_y + 5, _imgView.mj_w - _headerimgBtn.mj_w - 3, 20)];
    [_BgView addSubview:_nameLbl];
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

    
    
    
    BOOL isjing = [model.isAuslese boolValue];
    
   NSString * ausleseCount = [MCUserDefaults objectForKey:@"ausleseCount"];
    if( [model.collectCount integerValue]>= [ausleseCount integerValue]){
        
        isjing = YES;
        
    }
    else
        isjing = NO;

    
    
    x  = _imgView.mj_x + _imgView.mj_w + 10;

    if (!isjing) {
 
    }
    else
    {
        UIImageView * jingimg = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, 20, 20)];
        jingimg.image = [UIImage imageNamed:@"精"];
        [_BgView addSubview:jingimg];
        
        
        
         x  = _imgView.mj_x + _imgView.mj_w + 10 + 20 + 5;
    }
    
    
    w = Main_Screen_Width - x - 7 - 30  - 30;
    y = _imgView.mj_y;
    h = 20;
    UILabel * titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    titleLbl.textColor = [UIColor darkTextColor];
    titleLbl.text = model.title?model.title:@"西太平洋的新海角";//@"西太平洋的新海角";
    [_BgView addSubview:titleLbl];
    
    
    x = Main_Screen_Width - 7 - 30;
    w = 30;
    h = 30;
    y -= 5;
    UIButton * _caiBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    if ([model.isRecommend isEqualToString:@"1"]) {
        [_caiBtn setImage:[UIImage imageNamed:@"荐"] forState:0];

    }
    else{

        [_caiBtn setImage:[UIImage imageNamed:@"踩"] forState:0];
    }

    [_BgView addSubview:_caiBtn];
    
    
    
    x -=w;
    UIButton * _shiBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w+5, h)];
    
    if (model.classify  ==0) {
        [_shiBtn setImage:[UIImage imageNamed:@"食"] forState:0];
        
    }
    else if (model.classify  ==1)
        [_shiBtn setImage:[UIImage imageNamed:@"住"] forState:0];
    else if (model.classify  ==2)
        [_shiBtn setImage:[UIImage imageNamed:@"景"] forState:0];
    else if (model.classify  ==3)
            [_shiBtn setImage:[UIImage imageNamed:@"特产"] forState:0];
   else
       [_shiBtn setImage:[UIImage imageNamed:@"食"] forState:0];

    
    [_BgView addSubview:_shiBtn];

    
    
    
    

    x = _imgView.mj_x + _imgView.mj_w + 10;
    y = titleLbl.mj_y + titleLbl.mj_h + 5;
    w = Main_Screen_Width - 10 - x;
    h = 40;
    
    UILabel *_subtitleLbl =[[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _subtitleLbl.textColor = [UIColor grayColor];
    _subtitleLbl.text = model.content?model.content:@"北马里亚娜依稀太平洋的新";//@"北马里亚娜依稀太平洋的新";
    _subtitleLbl.font = [UIFont systemFontOfSize:13];
    _subtitleLbl.numberOfLines = 0;
    [_BgView addSubview:_subtitleLbl];
    
    
    
    CGFloat dingweiW = [MCIucencyView heightforString:model.spotName ?model.spotName :@"未知" andHeight:20 fontSize:14] + 20;
    if(dingweiW > 120*MCWidthScale)
        dingweiW = 120*MCWidthScale;
    
    y = _imgView.mj_y + _imgView.mj_h - 20 - 5;
    w = dingweiW;
    h = 20;
    
   _dingweibtn =  [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    
    [_dingweibtn setImage:[UIImage imageNamed:@"icon_map"] forState:0];
    [_dingweibtn setTitle:model.spotName ?model.spotName :@"未知" forState:0];
    [_dingweibtn setTitleColor:[UIColor grayColor] forState:0];
    _dingweibtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_BgView addSubview:_dingweibtn];
    
    
    
    x += w + 5;
    w = 33;
    h = 18;
    UIImageView * dengjiimg = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    NSString * grade =@"";// [NSString stringWithFormat:@"Lv_%ld",(long)model.userModel.grade];
    
    if ([model.currentGrade isEqualToString:@"lv0"]) {
       grade = @"Lv_0";
    }
    else if ([model.currentGrade isEqualToString:@"lv1"])
    {
        grade = @"Lv_1";

        
    }
    else if ([model.currentGrade isEqualToString:@"lv2"])
    {
        grade = @"Lv_2";

        
    }
    else if ([model.currentGrade isEqualToString:@"lv3"])
        
    {
        grade = @"Lv_3";

        
    }
    else if ([model.currentGrade isEqualToString:@"lv4"])
    {
        grade = @"Lv_4";

        
    }
    else if ([model.currentGrade isEqualToString:@"lv5"])
    {
        grade = @"Lv_5";
        
    }
    else if ([model.currentGrade isEqualToString:@"lv6"])
    {
        grade = @"Lv_6";
        
    }
    else
    {
        grade = @"";
        
    }
    dengjiimg.image = [UIImage imageNamed:grade];
    [_BgView addSubview:dengjiimg];
    
    
    x += w + 5;
    w = 10;
    UIImageView * shengimg = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    
    if (model.trend ==1) {
        shengimg.image = [UIImage imageNamed:@"red_arrow"];
        [_BgView addSubview:shengimg];

        
    }
    else if (model.trend ==0){
        
        shengimg.image = [UIImage imageNamed:@"green_arrow"];
        [_BgView addSubview:shengimg];

    }
    else if (model.trend ==2){
        
//        shengimg.image = [UIImage imageNamed:@"green_arrow"];
    }


    

    
    
    x = Main_Screen_Width - 10 - 25;
    w = 25;
    
    UIImageView * pinglunimg = [[UIImageView alloc]initWithFrame:CGRectMake(x, y-2.5, w, 25)];
    pinglunimg.image = [UIImage imageNamed:@"icon_message1"];
    [_BgView addSubview:pinglunimg];

    
    
    x = _subtitleLbl.mj_x;
    y = _imgView.mj_h + 10+10;
    CGFloat timeW = [MCIucencyView heightforString:[CommonUtil daysAgoAgainst:model.createDate]? [CommonUtil daysAgoAgainst:model.createDate] :@"未知" andHeight:20 fontSize:14] + 20;
    h = 20;
    
    UIButton * timeBtn =[[UIButton alloc]initWithFrame:CGRectMake(x, y, timeW, h)];
    
    [timeBtn setImage:[UIImage imageNamed:@"icon_time"] forState:0];
    
    [timeBtn setTitle:[CommonUtil daysAgoAgainst:model.createDate]? [CommonUtil daysAgoAgainst:model.createDate] :@"未知" forState:0];
    
    
    [timeBtn setTitleColor:[UIColor grayColor] forState:0];
    timeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_BgView addSubview:timeBtn];
    
    
    x = Main_Screen_Width - 10 - 100;
    w = 100;
    UILabel *_julilbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _julilbl.text = [NSString stringWithFormat:@"%.2fKm",[model.distance floatValue]/1000];//@"90cm";
    
    _julilbl.textColor = [UIColor grayColor];
    _julilbl.font = AppFont;
    _julilbl.textAlignment = NSTextAlignmentRight;
    [_BgView addSubview:_julilbl];

    
    
    UIImageView * fujinimg = [[UIImageView alloc]initWithFrame:CGRectMake(10 + 3, _imgView.mj_h + 10+15, 40, 17)];
    fujinimg.image = [UIImage imageNamed:@"label_nearby"];
   NSString *nearby = [MCUserDefaults objectForKey:@"nearby"];
    
    if ([model.distance floatValue]/1000 <= [nearby integerValue]) {
        [_BgView addSubview:fujinimg];

    }

    
    if (_isfriendPlay&&model.YJoptsArray.count) {

        UIView * _titleBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 44)];
        _titleBgView.backgroundColor = [UIColor whiteColor];
        [self.contentView  addSubview:_titleBgView];
        
        UIImageView *BSimgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, (44 - 20)/2, 20, 20)];
        BSimgView.image = [UIImage imageNamed:@"icon_share"];
        [_titleBgView addSubview:BSimgView];
        
        UILabel *_shareLbl =[[UILabel alloc]initWithFrame:CGRectMake(35, 0, Main_Screen_Width - 45, 44)];
        YJoptsModel * opmodel  =  model.YJoptsArray[0];
        NSString * ss = [NSString stringWithFormat:@"好友@%@评论该游记",opmodel.niackname];
        _shareLbl.text = ss;//@"好友@michan收藏了该订单";
        _shareLbl.textColor = AppCOLOR;
        _shareLbl.font = [UIFont systemFontOfSize:14];
        [_titleBgView addSubview:_shareLbl];
        
    }
    
    
    
    
    
    
    
    
    
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
