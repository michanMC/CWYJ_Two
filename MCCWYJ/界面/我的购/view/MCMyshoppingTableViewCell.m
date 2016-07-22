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
    //    return 100 *MCHeightScale + 15 + 20 + 10;

    
    _bg2View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 100 *MCHeightScale + 15 + 20 + 10)];
    
    _bg2View.backgroundColor = AppMCBgCOLOR//[UIColor groupTableViewBackgroundColor];
    _selectBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, (100 *MCHeightScale + 15 + 20 + 15 - 30)/2, 30, 30)];
    [_selectBtn setImage:[UIImage imageNamed:@"list_checkbox_normal"] forState:UIControlStateNormal];
    [_selectBtn setImage:[UIImage imageNamed:@"list_checkbox_checked"] forState:UIControlStateSelected];
    [_bg2View addSubview:_selectBtn];
    [self.contentView addSubview:_bg2View];
    
    CGFloat t = 0;
    CGFloat y = 10;

    if (_BuyModlel.YJoptsArray.count) {
        
        t= 44;
         y = 44;

    }

    _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 100 *MCHeightScale + 15 + 20 + 10 + t)];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_bgView];
    
    if (_BuyModlel.YJoptsArray.count) {
        CGFloat  optsH = 44;
        NSString * optsStr = @"";

        if ([_BuyModlel.type isEqualToString:@"sell"]) {
            
        if (_BuyModlel.isOpenopts) {
            
            NSMutableArray * niacknameArray = [NSMutableArray array];
            
            for (YJoptsModel * opstmodel in _BuyModlel.YJoptsArray) {
                if ([opstmodel.isAnonymity isEqualToString:@"1"]||[opstmodel.isAnonymity isEqualToString:@"-1"]) {
                    if (opstmodel.niackname.length) {
                        [niacknameArray addObject:opstmodel.niackname];
                        
                    }
                    else{
                        [niacknameArray addObject:@"匿名好友"];
                        
                    }
                }
                else
                {
                    [niacknameArray addObject:@"匿名好友"];
                    
                    
                }
            }
            NSString * countNum = [NSString stringWithFormat:@"%ld",niacknameArray.count];
            NSString * niacknameStr = [niacknameArray componentsJoinedByString:@","];
           optsStr  = [NSString stringWithFormat:@"有%@位好友%@了该单,%@",countNum,@"购买",niacknameStr];
//            optsStr = @"抗韩中年人笑笑喜欢装X，并且经常当着几十万水友装X，那感觉怎么说呢...贼爽！然而装X一时爽，翻车火葬场！不久前笑笑在直播中就吹破了牛皮，并且这一次结果很惨。下面就跟随小编一起来回顾下吧";

              optsH = [MCIucencyView heightforString:optsStr andWidth:Main_Screen_Width - 45 fontSize:14]+10 ;
            if (optsH < 44) {
                optsH = 44;
            }
            
        }
            else
            {
                YJoptsModel * opstmodel = _BuyModlel.YJoptsArray[0];
                NSString *namestr = @"";
                if ([opstmodel.isAnonymity isEqualToString:@"1"]||[opstmodel.isAnonymity isEqualToString:@"-1"]) {
                    namestr =opstmodel.niackname;
                }
                else
                {
                   namestr = @"匿名友好";
                }
                optsStr = [NSString stringWithFormat:@"好友%@购买了该单",namestr];
                
            }
            
        }
        
        else if ([_BuyModlel.type isEqualToString:@"pick"]){
            YJoptsModel * opstmodel = _BuyModlel.YJoptsArray[0];
            NSString *namestr = @"";
            if ([opstmodel.isAnonymity isEqualToString:@"1"]||[opstmodel.isAnonymity isEqualToString:@"-1"]) {
                namestr =opstmodel.niackname;
            }
            else
            {
                namestr = @"匿名友好";
            }
            optsStr = [NSString stringWithFormat:@"%@接了该单",namestr];
            
        }
        
    
     UIView * _titleBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, optsH)];
     _titleBgView.backgroundColor = [UIColor whiteColor];
     [self.contentView  addSubview:_titleBgView];
        
     
     UIImageView *BSimgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, (optsH - 20)/2, 20, 20)];
     BSimgView.image = [UIImage imageNamed:@"icon_share"];
     [_titleBgView addSubview:BSimgView];
        
        if ([_BuyModlel.type isEqualToString:@"sell"]) {
            _optsBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, optsH)];
            [_titleBgView addSubview:_optsBtn];

        }
        

     UILabel *_shareLbl =[[UILabel alloc]initWithFrame:CGRectMake(35, 5, Main_Screen_Width - 45, optsH - 10)];
     
        _shareLbl.text = optsStr;//@"好友@michan收藏了该订单";
        _shareLbl.textColor = AppCOLOR;
        _shareLbl.font = [UIFont systemFontOfSize:14];
        [_titleBgView addSubview:_shareLbl];
        if (_BuyModlel.isOpenopts) {
            _shareLbl.numberOfLines = 0;
        }
        else
        {
            _shareLbl.numberOfLines = 1;

        }
        [_bgView addSubview:_titleBgView];
        
            t= optsH;
            y = optsH;
            
        
        _bgView .frame =CGRectMake(0, 0, Main_Screen_Width, 100 *MCHeightScale + 15 + 20 + 10 + t);
    }


    CGFloat x = 10;
    CGFloat w = 100*MCHeightScale;
    CGFloat h = w;
    
    UIImageView * _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, w)];
//    _imgView.image = [UIImage imageNamed:@"buy_default-photo"];
    NSLog(@"=====%@",_BuyModlel.imageUrl);

    if (_BuyModlel.imageUrl.count) {
        NSLog(@"=====%@",_BuyModlel.imageUrl[0]);
        [_imgView sd_setImageWithURL:[NSURL URLWithString:_BuyModlel.imageUrl[0]] placeholderImage:[UIImage imageNamed:@"buy_default-photo"]];
        
    }
    else
        _imgView.image = [UIImage imageNamed:@"buy_default-photo"];

    _imgView.userInteractionEnabled = YES;
    [_bgView addSubview:_imgView];
    
//    _imgView.contentMode = UIViewContentModeScaleAspectFill;
//    _imgView.clipsToBounds = YES; // 裁剪边缘

    
    
    
    UIImageView *_biaoshiImg = [[UIImageView alloc]initWithFrame:CGRectMake(-5, -5, 30, 25)];
    
    if ([_BuyModlel.type isEqualToString:@"pick"]) {
        _biaoshiImg.image = [UIImage imageNamed:@"求"];

    }
    else if ([_BuyModlel.type isEqualToString:@"show"])
    {
        _biaoshiImg.image = [UIImage imageNamed:@"晒"];

    }
    else if ([_BuyModlel.type isEqualToString:@"sell"])
    {
        _biaoshiImg.image = [UIImage imageNamed:@"售"];
 
    }

    [_imgView addSubview:_biaoshiImg];
    if (_tixing) {
        
    
    _BadgeView  = [[JSBadgeView alloc] initWithParentView:_imgView alignment:JSBadgeViewAlignmentTopRight];
    NSMutableArray *travelRemindArray =  [MCIucencyView pickRemindArray];
    
        if ([_BuyModlel.type isEqualToString:@"pick"]) {
travelRemindArray =  [MCIucencyView pickRemindArray];
            
            
        }
        else if ([_BuyModlel.type isEqualToString:@"show"])
        {
travelRemindArray =  [MCIucencyView showRemindArray];
        }
        else if ([_BuyModlel.type isEqualToString:@"sell"])
        {
            travelRemindArray =  [MCIucencyView sellRemindArray];
 
        }

        
    NSInteger count = 0;
    
    for (NSString * indexid in travelRemindArray) {
        
        if ([indexid isEqualToString:_BuyModlel.id]) {
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


    _headerimgBtn= [[UIButton alloc]initWithFrame:CGRectMake(3, _imgView.mj_h - 20, 40, 40)];
//    [_headerimgBtn setBackgroundImage:[UIImage imageNamed:@"home_Avatar_60"] forState:0];
    
    [_headerimgBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:_BuyModlel.userModel.thumbnail] forState:0 placeholderImage:[UIImage imageNamed:@"home_Avatar_60"]];

    ViewRadius(_headerimgBtn, 40/2);
    _headerimgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    _headerimgBtn.layer.borderWidth = 1;
    [_imgView addSubview:_headerimgBtn];
    UILabel * _nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(_imgView.mj_x + 3 + _headerimgBtn.mj_w+ 5, _imgView.mj_h + _imgView.mj_y + 5, _imgView.mj_w - _headerimgBtn.mj_w - 3, 20)];
    [_bgView addSubview:_nameLbl];
    _nameLbl.textColor = [UIColor darkTextColor];
    _nameLbl.font = AppFont;
//        _nameLbl.text = @"游客";
    _nameLbl.text = _BuyModlel.userModel.nickname;

    
    
    x = _imgView.mj_x + _imgView.mj_w + 10;
    y = _imgView.mj_y;
    
    w = [MCIucencyView heightforString:_BuyModlel. price?_BuyModlel. price :@"￥1" andHeight:20 fontSize:18] + 20;//Main_Screen_Width - x - 10;
    h = 20;
    
    
    if ([_BuyModlel.type isEqualToString:@"show"])
    {
        w = Main_Screen_Width - x - 7;
        y = _imgView.mj_y;
        h = 20;
        UILabel * titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
        titleLbl.textColor = [UIColor darkTextColor];
        titleLbl.text = _BuyModlel.title?_BuyModlel.title:@"西太平洋的新海角";//@"西太平洋的新海角";
        [_bgView addSubview:titleLbl];

        x = _imgView.mj_x + _imgView.mj_w + 10;
        y = titleLbl.mj_y + titleLbl.mj_h + 5;
        w = Main_Screen_Width - 10 - x;
        h = 40;
        
        UILabel *_subtitleLbl =[[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
        _subtitleLbl.textColor = [UIColor grayColor];
        _subtitleLbl.text = _BuyModlel.MCdescription?_BuyModlel.MCdescription:@"北马里亚娜依稀太平洋的新";//@"北马里亚娜依稀太平洋的新";
        _subtitleLbl.font = [UIFont systemFontOfSize:13];
        _subtitleLbl.numberOfLines = 0;
        [_bgView addSubview:_subtitleLbl];
        
        
        CGFloat dingweiW = [MCIucencyView heightforString:_BuyModlel.Buyjson.address ?_BuyModlel.Buyjson.address :@"未知" andHeight:20 fontSize:14] + 20;
        if(dingweiW > 120*MCWidthScale)
            dingweiW = 120*MCWidthScale;
        
        y = _imgView.mj_y + _imgView.mj_h - 20 - 5;
        w = dingweiW;
        h = 20;
        
      UIButton*  _dingweibtn =  [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
        
        [_dingweibtn setImage:[UIImage imageNamed:@"icon_map"] forState:0];
        [_dingweibtn setTitle:_BuyModlel.Buyjson.address ?_BuyModlel.Buyjson.address :@"未知" forState:0];
        [_dingweibtn setTitleColor:[UIColor grayColor] forState:0];
        _dingweibtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_bgView addSubview:_dingweibtn];
        


    }
    else
    {
    
    
    UILabel *_priceLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
//    _priceLbl.text = @"￥233.00";
    _priceLbl.text = [NSString stringWithFormat:@"￥%@",_BuyModlel. price?_BuyModlel. price:@""];//@"￥233.00";

    _priceLbl.textColor = AppCOLOR;
    _priceLbl.font = [UIFont systemFontOfSize:18];
    [_bgView addSubview:_priceLbl];
    
    
    
    
    x += w + 10;
    w = Main_Screen_Width - x - 10;
    
    UILabel *_weiziLbl =[[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _weiziLbl.text = _BuyModlel.chAddress;//@"法国";
    _weiziLbl.textColor = [UIColor grayColor];
    _weiziLbl.font = [UIFont systemFontOfSize:16];
    [_bgView addSubview:_weiziLbl];
    
    x = _imgView.mj_x + _imgView.mj_w + 10;
    y += h +5;
    w = Main_Screen_Width - x - 10;
    h = 40;
    UILabel *_titleLbl =[[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
//    _titleLbl.text = @"【娇兰】限量宝石限量宝石限量宝石限量宝石限量宝石限量宝石";
        NSString * titleStr = _BuyModlel.title?_BuyModlel.title:@"";
        if (_BuyModlel.brand.length) {
            titleStr = [NSString stringWithFormat:@"【%@】%@",_BuyModlel.brand,_BuyModlel.title];
        }
        
        _titleLbl.text = titleStr;//[NSString stringWithFormat:@"【%@】%@",_BuyModlel.brand,_BuyModlel.title];//@"2015年9月,我们完成一次日本两周...";

    _titleLbl.textColor = [UIColor grayColor];
    _titleLbl.font = [UIFont systemFontOfSize:14];
    [_bgView addSubview:_titleLbl];
    }
    
    
    
    
    y += h +5;
    h = 25;
    NSString * sss =@"未知";// _BuyModlel.integral?_BuyModlel.integral:;
    NSString * sss2 = @"";
    if (_BuyModlel.status  == 0) {
        sss = @"可售";
        if ([_BuyModlel.type isEqualToString:@"sell"])
        {
        if ([[MCUserDefaults objectForKey:@"id"] integerValue] ==[_BuyModlel.userId integerValue]) {
//            sss2 = @"关闭订单";
            sss2 = @"";

        }
        else
        sss2 = @"购买";
        }
        
    }
    else if (_BuyModlel.status  == 1){
        sss = @"售罄";
        if ([_BuyModlel.type isEqualToString:@"sell"])
        {
        if ([[MCUserDefaults objectForKey:@"id"] integerValue] == [_BuyModlel.userId integerValue]) {
            sss2 = @"再次发布";
        }
        else
        sss2 = @"制作求";
        }

    }
    else if (_BuyModlel.status  == 2){
        sss = @"已关闭";
        
        
        if ([_BuyModlel.type isEqualToString:@"sell"])
        {
            if ([[MCUserDefaults objectForKey:@"id"] integerValue] ==[_BuyModlel.userId integerValue]) {
                sss2 = @"再次发布";
            }
            else
                sss2 = @"制作求";
   
            
        }
        else if ([_BuyModlel.type isEqualToString:@"pick"]){//求
            
            sss2 = @"再来";

            
        }
        
    }
    
    
    else if (_BuyModlel.status  == 3){
        sss = @"没接单";
        if ([[MCUserDefaults objectForKey:@"id"] integerValue] ==[_BuyModlel.userId integerValue]) {
            sss2 = @"关闭订单";
        }else

        sss2 = @"接单";
        
    }
    else if (_BuyModlel.status  == 4){
        sss = @"已接单";
        
        if ([[MCUserDefaults objectForKey:@"id"] integerValue] ==[_BuyModlel.userId integerValue]) {
            sss2 = @"完成订单";
        }
        else
            sss2 = @"放弃订单";

        
    }
    else if (_BuyModlel.status  == 5){
        sss = @"完成接单";
        sss2 = @"再来";

    }
    else if (_BuyModlel.status  == 6){
        sss = @"关闭订单";
        sss2 = @"再来";

        
    }
    else if (_BuyModlel.status  == 7){
        sss = @"未支付";
        sss2 = @"未支付";
//
//        if ([[MCUserDefaults objectForKey:@"id"] integerValue] ==[_BuyModlel.userId integerValue]) {
//            sss2 = @"没支付";
//        }
//        else
//        sss2 = @"";

    }

    
    w = [MCIucencyView heightforString:sss andHeight:25 fontSize:14] + 10;//Main_Screen_Width - x - 10;
    UILabel * _gendanStatelbl =[[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _gendanStatelbl.backgroundColor = [UIColor groupTableViewBackgroundColor];
    ViewRadius(_gendanStatelbl, 3);
    _gendanStatelbl.text = sss;
    _gendanStatelbl.textAlignment = NSTextAlignmentCenter;
    _gendanStatelbl.textColor = [UIColor grayColor];
    _gendanStatelbl.font = [UIFont systemFontOfSize:14];
    
    if ([_BuyModlel.type isEqualToString:@"sell"]||[_BuyModlel.type isEqualToString:@"pick"]) {
        
        _gendanStatelbl.hidden = NO;
    }
    else
    {
        _gendanStatelbl.hidden = YES;

    }
    [_bgView addSubview:_gendanStatelbl];


    y = _imgView.mj_y + _imgView.mj_h - 5;
    
    sss = [CommonUtil daysAgoAgainst:[_BuyModlel.createDate longLongValue]];
    
     CGFloat timeW = [MCIucencyView heightforString:sss andHeight:20 fontSize:14] + 20;
    
    UIButton * timeBtn =[[UIButton alloc]initWithFrame:CGRectMake(x, y, timeW, h)];
    
    [timeBtn setImage:[UIImage imageNamed:@"icon_time"] forState:0];
    [timeBtn setTitle:sss forState:0];
    [timeBtn setTitleColor:[UIColor grayColor] forState:0];
    timeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_bgView addSubview:timeBtn];

    //    return 100 *MCHeightScale + 15 + 20 + 15;

    y = 100 *MCHeightScale + 15 + 20 + 10 - 15 - 25;
//    w = 50;
    w = [MCIucencyView heightforString:sss2 andHeight:25 fontSize:14] + 15;//Main_Screen_Width - x - 10;

    h = 25;
    x = Main_Screen_Width - 10 - w;
    _shoppingBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _shoppingBtn.backgroundColor = AppRegTextCOLOR;
    [_shoppingBtn setTitleColor:[UIColor whiteColor] forState:0];
    _shoppingBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [_shoppingBtn setTitle:sss2 forState:0];
    if (!sss2.length) {
        _shoppingBtn.hidden = YES;
    }
    else
    {
        _shoppingBtn.hidden = NO;

    }
    ViewRadius(_shoppingBtn, 3);
    [_bgView addSubview:_shoppingBtn];

    
    
    
    
    
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

-(void)preparebuyUI{
    
    for (UIView* obj in self.contentView.subviews)
        [obj removeFromSuperview];
    //    return 100 *MCHeightScale + 15 + 20 + 10;
    
    
    _bg2View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 200)];
    
    _bg2View.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _selectBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, (200 - 30)/2, 30, 30)];
    [_selectBtn setImage:[UIImage imageNamed:@"list_checkbox_normal"] forState:UIControlStateNormal];
    [_selectBtn setImage:[UIImage imageNamed:@"list_checkbox_checked"] forState:UIControlStateSelected];
    [_bg2View addSubview:_selectBtn];
    [self.contentView addSubview:_bg2View];
    
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 200)];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_bgView];
 
   
    
    CGFloat x = 10;
    CGFloat y = 10;
    CGFloat w = Main_Screen_Width - 2*x;
    CGFloat h = 20;
    
    
    UILabel * nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    nameLbl.text = [NSString stringWithFormat:@"卖家:%@",_BuyModlel.nickname];
    nameLbl.textColor = AppTextCOLOR;
    nameLbl.font = [UIFont systemFontOfSize:16];
    [_bgView addSubview:nameLbl];
    
    y += h + 10;
    UILabel * orderLbl=[[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    orderLbl.text =[NSString stringWithFormat:@"订单号:%@",_BuyModlel.orderNumber];// @":2321321332112";//_BuyModlel.userModel.nickname;
    orderLbl.textColor = [UIColor grayColor];
    orderLbl.font = [UIFont systemFontOfSize:14];
    [_bgView addSubview:orderLbl];

    h = y + h  + 10;
    y = 0;
    w = 100;
    x = Main_Screen_Width - w - 10;
    UILabel * _typeLbl =[[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    NSString * ss = @"不明状态";
    if ([_BuyModlel.Buystatus isEqualToString:@"-1"]) {
        ss = @"待付款";
    }
    else if ([_BuyModlel.Buystatus isEqualToString:@"0"]) {
        ss = @"待发货";
    }
    else if ([_BuyModlel.Buystatus isEqualToString:@"1"]) {
        ss = @"已发货";
    }
    else if ([_BuyModlel.Buystatus isEqualToString:@"2"]) {
        ss = @"已完成";
    }
    else if ([_BuyModlel.Buystatus isEqualToString:@"3"]) {
        ss = @"已关闭";
    }
    else if ([_BuyModlel.Buystatus isEqualToString:@"4"]) {
        ss = @"退款成功";
    }
    else if ([_BuyModlel.Buystatus isEqualToString:@"5"]) {
        ss = @"退款中";
    }
    _typeLbl.text = ss;//_BuyModlel.userModel.nickname;
    _typeLbl.textColor = AppCOLOR;
    _typeLbl.font = [UIFont systemFontOfSize:16];
    _typeLbl.textAlignment = NSTextAlignmentRight;
    [_bgView addSubview:_typeLbl];
    
    y = h;
    w = Main_Screen_Width;
    h = 80;
    x = 0;
    UIView * bgView3 = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    bgView3.backgroundColor = AppMCBgCOLOR;//[UIColor groupTableViewBackgroundColor];
    [_bgView addSubview:bgView3];

    x = 10;
    y = 10;
    
    w = 60;
    h = w;
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
//    imgView.image = [UIImage imageNamed:@"buy_default-photo"];
    if (_BuyModlel.imageUrl.count) {
        NSLog(@"=====%@",_BuyModlel.imageUrl[0]);
        [imgView sd_setImageWithURL:[NSURL URLWithString:_BuyModlel.imageUrl[0]] placeholderImage:[UIImage imageNamed:@"buy_default-photo"]];
        
    }
    else
        imgView.image = [UIImage imageNamed:@"buy_default-photo"];
    

    [bgView3 addSubview:imgView];
    
    x += w + 5;
    w = Main_Screen_Width - x - 110;
    h = 40;
    UILabel * titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    titleLbl.text = [NSString stringWithFormat:@"【%@】%@",_BuyModlel.brand,_BuyModlel.name ];//@"【娇兰】限量帮限量帮限量帮限量帮限量帮限量帮限量帮限量帮限量帮限量帮";//_BuyModlel.userModel.nickname;
    titleLbl.numberOfLines = 0;
    titleLbl.textColor = AppTextCOLOR;
    titleLbl.font = [UIFont systemFontOfSize:14];
    [bgView3 addSubview:titleLbl];
    
    
    x = Main_Screen_Width - 10 - 100;
    w = 100;
    h = 20;
    UILabel * priceLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    ss = [NSString stringWithFormat:@"￥%.2f",[_BuyModlel.djPrice floatValue] ];

    priceLbl.text = ss;//[NSString stringWithFormat:@"￥%@",_BuyModlel.djPrice];//@"￥300.00";//_BuyModlel.userModel.nickname;
    priceLbl.textColor = AppTextCOLOR;
    priceLbl.textAlignment = NSTextAlignmentRight;
    priceLbl.font = [UIFont systemFontOfSize:16];
    [bgView3 addSubview:priceLbl];
    y += h + 5;
    UILabel * countLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    countLbl.text = [NSString stringWithFormat:@"x%@",_BuyModlel.count ];//@"x4";//_BuyModlel.userModel.nickname;
    countLbl.textColor = [UIColor grayColor];
    countLbl.textAlignment = NSTextAlignmentRight;
    countLbl.font = [UIFont systemFontOfSize:14];
    [bgView3 addSubview:countLbl];
    
    
    y = bgView3.mj_y + bgView3.mj_h;
    
    x = 10;
    w = 50;
    h = 50;
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.text = @"实付款:";
    lbl.textColor = AppTextCOLOR;
    lbl.font = AppFont;
    [_bgView addSubview:lbl];
    
    x += w + 5;
    w = Main_Screen_Width - x ;
    ss = [NSString stringWithFormat:@"￥%.2f",[_BuyModlel.price floatValue] ];
    UILabel * zongpriceLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    zongpriceLbl.text = ss;//、、@"￥300.00";
    zongpriceLbl.textColor = AppTextCOLOR;
    zongpriceLbl.font = [UIFont systemFontOfSize:17];
    [_bgView addSubview:zongpriceLbl];

    //150+50;
    y += 10;
    w = [MCIucencyView heightforString:@"申请退款" andHeight:30 fontSize:14] + 10;
    x = Main_Screen_Width - w - 10;
    h = 30;
    _typeBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    
    x -= (w + 10);

//    AppBgCOLOR
//    AppRegTextCOLOR
    [_typeBtn setTitleColor:RGBCOLOR(207, 0, 51) forState:0];
    [_typeBtn setTitle:@"申请退款" forState:0];
    _typeBtn.titleLabel.font = AppFont;
    ViewRadius(_typeBtn, 3);
    _typeBtn.layer.borderColor = RGBCOLOR(207, 0, 51).CGColor;
    _typeBtn.layer.borderWidth = 1;
    [_typeBtn addTarget:self action:@selector(actiontypeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:_typeBtn];

    _type2Btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
//    [_type2Btn setTitleColor:RGBCOLOR(207, 0, 51) forState:0];
    [_type2Btn setTitle:@"确认收货" forState:0];
    _type2Btn.titleLabel.font = AppFont;
    ViewRadius(_type2Btn, 3);
    
    
    _type2Btn.layer.borderColor = [UIColor grayColor].CGColor;
    [_type2Btn setTitleColor:[UIColor grayColor] forState:0];
    
//    _type2Btn.layer.borderColor = RGBCOLOR(207, 0, 51).CGColor;
    _type2Btn.layer.borderWidth = 1;
    [_type2Btn addTarget:self action:@selector(actiontypeBtn:) forControlEvents:UIControlEventTouchUpInside];

    [_bgView addSubview:_type2Btn];

    
    
    _type2Btn.hidden = YES;

    _typeBtn.hidden = NO;

    if ([_BuyModlel.Buystatus isEqualToString:@"-1"]) {
//        _typeBtn.hidden = YES;
        _type2Btn.hidden = NO;

        [_typeBtn setTitle:@"付款" forState:0];
        [_type2Btn setTitle:@"取消订单" forState:0];
        _type2Btn.layer.borderColor = [UIColor grayColor].CGColor;
        [_type2Btn setTitleColor:[UIColor grayColor] forState:0];

        
    }
    else
    {
        if ([_BuyModlel.Buystatus isEqualToString:@"0"]||[_BuyModlel.Buystatus isEqualToString:@"1"]) {
            _typeBtn.hidden = NO;
            
            
            if ([_BuyModlel.Buystatus isEqualToString:@"1"]) {
                _type2Btn.hidden = NO;
                [_type2Btn setTitle:@"确认收货" forState:0];

            }

        }
        else if ([_BuyModlel.Buystatus isEqualToString:@"2"]){
            _typeBtn.hidden = NO;
            [_typeBtn setTitle:@"晒单" forState:0];
            
        }
        else if ([_BuyModlel.Buystatus isEqualToString:@"5"]){
            _typeBtn.hidden = NO;
            [_typeBtn setTitle:@"退款详情" forState:0];
            _type2Btn.hidden = NO;

            [_type2Btn setTitle:@"取消退款" forState:0];

            
        }
        else if ([_BuyModlel.Buystatus isEqualToString:@"4"]||[_BuyModlel.Buystatus isEqualToString:@"6"]){
            _typeBtn.hidden = NO;
            [_typeBtn setTitle:@"退款详情" forState:0];
            
        }

        
        
    }

    if (_typeBtn.hidden) {
        _type2Btn.frame = _typeBtn.frame;
    }
    else
    {
        _type2Btn.frame = CGRectMake(x, y, w, h);
    }
    
    
    
}
-(void)actiontypeBtn:(UIButton*)btn{
    
    if (_degate) {
        [_degate seleTitle:btn.titleLabel.text BuyModlel:_BuyModlel];
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
