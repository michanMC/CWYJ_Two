//
//  ShoppingViewTableViewCell.m
//  MCCWYJ
//
//  Created by MC on 16/6/15.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "ShoppingViewTableViewCell.h"

@implementation ShoppingViewTableViewCell
-(void)prepareUIshai{
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }

    CGFloat x = 20;
    CGFloat y = 10;
    CGFloat width = Main_Screen_Width - 80 - 30;
    CGFloat height = 40;
    _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
    _titleLbl.textColor = AppTextCOLOR;
    _titleLbl.font = [UIFont systemFontOfSize:16];
    _titleLbl.text = _BuyModlel.title;//@"北马里亚纳";
    _titleLbl.numberOfLines = 0;
    [self.contentView addSubview:_titleLbl];
    
    
    
    x = 15;
    y +=height + 10;
    width = 15;
    height = 15;
    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(x, y+2, width, height)];
    
    img.image =[UIImage imageNamed:@"home_icon_map"];
    [self.contentView addSubview:img];
    
    x +=width;
    height = 20;
    width =( Main_Screen_Width - 80 - 40)/2 + 100;
    _dingweiLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
    _dingweiLbl.text = _BuyModlel.Buyjson.address;//@"广州";
    _dingweiLbl.textColor = [UIColor grayColor];
    _dingweiLbl.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_dingweiLbl];
    x = (Main_Screen_Width - 80 - 50 - 15);
    width = 15;
    height = 15;
    
    img = [[UIImageView alloc]initWithFrame:CGRectMake(x, y+2, width, height)];
    img.image =[UIImage imageNamed:@"travels_icon_time"];
    [self.contentView addSubview:img];
    
    x +=width;
    height = 20;
    width =55;//( Main_Screen_Width - 80 - 40)/2;
    _timeLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
    _timeLbl.text = [CommonUtil getStringWithLong:[_BuyModlel.createDate longLongValue] Format:@"MM-dd"];//@"09-09";
    _timeLbl.textColor = [UIColor grayColor];
    _timeLbl.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_timeLbl];
    x = 20;
    y += 10 + height;
    
    width = Main_Screen_Width- 80-30;
    height = 20;//105
    _dataLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
    _dataLbl.textColor = [UIColor grayColor];
    _dataLbl.font = [UIFont systemFontOfSize:13];
    _dataLbl.numberOfLines = 0;
    _dataLbl.text=  _BuyModlel.MCdescription;////@"王企鹅王企鹅王企鹅王企鹅王企鹅请问请问去问问企鹅我去";
    [self.contentView addSubview:_dataLbl];

  
    x = 0;
    y += height + 10  ;
    width = Main_Screen_Width - 80;
    height = 65;//160
    // 120 + 65
    
    _foorView = [[UIView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    // _foorView.backgroundColor = [UIColor yellowColor];
    
    
    [self.contentView addSubview:_foorView];
    x = 10;
    y = 20;
    width = 35;
    height = 35;
    _headerBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    [_headerBtn sd_setImageWithURL:[NSURL URLWithString:_BuyModlel.userModel.thumbnail] forState:0 placeholderImage:[UIImage imageNamed:@"home_Avatar_60"]];
    
    ViewRadius(_headerBtn, 35/2);
    _headerBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    _headerBtn.layer.borderWidth = 1.0;
    
    [_foorView addSubview:_headerBtn];
    
    x += width + 5;
    width = 130;
    _nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
    _nameLbl.textColor = [UIColor grayColor];
    // _nameLbl.backgroundColor = [UIColor yellowColor];
    _nameLbl.text = _BuyModlel.userModel.nickname ?_BuyModlel.userModel.nickname :@"游客";
    _nameLbl.adjustsFontSizeToFitWidth = YES;
    // _nameLbl.minimumFontSize= 10;
    _nameLbl.font = AppFont;
    [_foorView addSubview:_nameLbl];
    
    
    y += 7;
    
    x = Main_Screen_Width - 80 - 50-10;
    width = 50;
    height = 20;
    _collectBtn = [[MCbackButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    [_collectBtn setImage:[UIImage imageNamed:@"travels_icon_favorite_normal"] forState:UIControlStateNormal];
    [_collectBtn setImage:[UIImage imageNamed:@"travels_icon_favorite_pressed"] forState:UIControlStateSelected];
    
    _collectBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [_collectBtn setTitle:@"已收藏" forState:UIControlStateSelected];
    _collectBtn.selected = _BuyModlel.isCollect;
    [_collectBtn setTitleColor:[UIColor grayColor] forState:0];
    [_collectBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];

    [_foorView addSubview:_collectBtn];
    
    
    
    _gengimg = [[UIImageView alloc]initWithFrame:CGRectMake((Main_Screen_Width - 80 - 30) / 2, 5, 30, 5)];
    
    _gengimg.image =[UIImage imageNamed:@"travels_more_dot"];
    _gengimg.tag = 909;
    [_foorView addSubview:_gengimg];
    _gengduoBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, _foorView.frame.size.width, 20)];
    //  _gengduoBtn.backgroundColor = [UIColor redColor];
    [_foorView addSubview:_gengduoBtn];

    
    
}

-(void)prepareUI{
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    CGFloat width = Main_Screen_Width - 80;
//    self.contentView.mj_w = width;
    CGFloat x = 10;
    CGFloat y = 10;
    CGFloat w = 30;
    CGFloat h = 30;
    
    _headerBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [_headerBtn sd_setImageWithURL:[NSURL URLWithString:_BuyModlel.userModel.thumbnail] forState:0 placeholderImage:[UIImage imageNamed:@"home_Avatar_60"]];
    ViewRadius(_headerBtn, w / 2);
    [self.contentView addSubview:_headerBtn];
    
    w = 60;
    x = self.contentView.mj_w - 5 - 60;
    _palyBuyBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, 27)];
//    [_palyBuyBtn setTitle:@"可售" forState:0];
    _palyBuyBtn.titleLabel.font = AppFont;
    [_palyBuyBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    _palyBuyBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
    ViewRadius(_palyBuyBtn, 3);
    NSString * sss =@"";
    if (_BuyModlel.status  == 0) {
        sss = @"可售";
    }
    else if (_BuyModlel.status  == 1){
        sss = @"售罄";
        
    }
    else if (_BuyModlel.status  == 2){
        sss = @"已关闭";
        
        
        
    }
    else if (_BuyModlel.status  == 3){
        sss = @"没接单";
        
    }
    else if (_BuyModlel.status  == 4){
        sss = @"已接单";
        
        
    }
    else if (_BuyModlel.status  == 5){
        sss = @"完成接单";
        
    }
    else if (_BuyModlel.status  == 6){
        sss = @"关闭订单";
        
        
    }
    else if (_BuyModlel.status  == 7){
        sss = @"未支付";
        
    }
    
       [_palyBuyBtn setTitle:sss forState:0];

    
    
    [self.contentView addSubview:_palyBuyBtn];

  UIImageView *  _biaozhiimg = [[UIImageView alloc]init];
    
    _biaozhiimg.image = [UIImage imageNamed:@"Lv1"];
    if (_BuyModlel.userModel.grade == 1) {
        _biaozhiimg.image = [UIImage imageNamed:@"Lv1"];
        
    }
    if (_BuyModlel.userModel.grade == 2) {
        _biaozhiimg.image = [UIImage imageNamed:@"Lv2"];
        
    }
    if (_BuyModlel.userModel.grade == 3) {
        _biaozhiimg.image = [UIImage imageNamed:@"Lv3"];
        
    }
    if (_BuyModlel.userModel.grade == 4) {
        _biaozhiimg.image = [UIImage imageNamed:@"Lv4"];
        
    }
    if (_BuyModlel.userModel.grade == 5) {
        _biaozhiimg.image = [UIImage imageNamed:@"Lv5"];
        
    }
    //30, 17

    x = _headerBtn.mj_x + _headerBtn.mj_h + 5;
    y = _headerBtn.mj_y;
    h = 30;
  CGFloat lw =  [MCIucencyView heightforString:_BuyModlel.userModel.nickname ? _BuyModlel.userModel.nickname : @"游客"  andHeight:30 fontSize:15];
    if (lw + 30 + 10 > self.contentView.mj_w - x - 65 ) {
        lw = self.contentView.mj_w - x - 65 - 40;
        
    }
    
    UILabel * nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, lw, h)];
    nameLbl.text = _BuyModlel.userModel.nickname ?_BuyModlel.userModel.nickname :@"游客";
    nameLbl.textColor = AppTextCOLOR;
    nameLbl.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:nameLbl];
    [self.contentView addSubview:_biaozhiimg];

    x += lw + 5;
    _biaozhiimg.frame = CGRectMake(x, y +(h - 17)/2, 30, 17);
    
    [self.contentView addSubview:_biaozhiimg];
    

    y = nameLbl.mj_y + 30 ;
    x = nameLbl.mj_x;
    
    CGFloat dingweiW = [MCIucencyView heightforString:_BuyModlel.chAddress ?_BuyModlel.chAddress :@"未知" andHeight:20 fontSize:14] + 20;
    
    _dingweibtn = [[UIButton alloc]init];
    [_dingweibtn setTitleColor:[UIColor grayColor] forState:0];
//    _dingweibtn.backgroundColor = [UIColor yellowColor];
    [_dingweibtn setTitle:_BuyModlel.chAddress ?_BuyModlel.chAddress :@"未知" forState:0];
    [_dingweibtn setImage:[UIImage imageNamed:@"icon_map"] forState:0];
    
    [self.contentView addSubview:_dingweibtn];

    
    
  NSString* ss=  [CommonUtil getStringWithLong:[_BuyModlel.createDate longLongValue] Format:@"MM-dd"];
    CGFloat timeW = [MCIucencyView heightforString:ss ?ss :@"未知" andHeight:20 fontSize:14] + 20;
    
    
    x = self.contentView.mj_w - timeW - 5;
    
    
    
    
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, timeW, 20)];
    [btn setImage:[UIImage imageNamed:@"travels_icon_time"] forState:0];
    [btn setTitle:ss forState:0];
    btn.titleLabel.font = AppFont;
    [btn setTitleColor:[UIColor grayColor] forState:0];
    
    [self.contentView addSubview:btn];

    CGFloat dw = self.contentView.mj_w -  nameLbl.mj_x -
    timeW - 10;
    
    if (dingweiW >  dw) {
        dingweiW = dw;
    }
    
    _dingweibtn.titleLabel.font = AppFont;
    _dingweibtn.frame = CGRectMake(nameLbl.mj_x - 8, y, dingweiW, 20);
    
    
    
    
    x = _headerBtn.mj_x;
    y +=10 + h;
    w = self.contentView.mj_w - 2 * x;
    h = 20;
    
    
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.textColor = AppTextCOLOR;
    lbl.font = AppFont;
    lbl.text =[NSString stringWithFormat:@"品牌: %@", _BuyModlel.brand];
    
    [self.contentView addSubview:lbl];
    
    if (_BuyModlel.brand.length) {
        lbl.hidden = NO;
        y += h + 5;

    }
    else
    {
        lbl.hidden = YES;
        
    }

    lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.textColor = AppTextCOLOR;
    lbl.font = AppFont;
    lbl.text =[NSString stringWithFormat:@"型号: %@", _BuyModlel.model];

    [self.contentView addSubview:lbl];
    if (_BuyModlel.model.length) {
        lbl.hidden = NO;
        y += h + 5;

    }
    else
    {
        lbl.hidden = YES;
        
    }

    
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.textColor = AppTextCOLOR;
    lbl.font = AppFont;
    lbl.text =[NSString stringWithFormat:@"物品名称: %@", _BuyModlel.name];
    [self.contentView addSubview:lbl];

    y += h + 5;
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.textColor = AppTextCOLOR;
    lbl.font = AppFont;
    lbl.text =[NSString stringWithFormat:@"颜色: %@", _BuyModlel.color];

    [self.contentView addSubview:lbl];
    if (_BuyModlel.color.length) {
        lbl.hidden = NO;
        y += h + 5;

    }
    else
    {
        lbl.hidden = YES;
        
    }

    lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.textColor = AppTextCOLOR;
    lbl.font = AppFont;
    lbl.text =[NSString stringWithFormat:@"单价: ￥%@", _BuyModlel.price];
    [self.contentView addSubview:lbl];

    y += h + 5;
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.textColor = AppTextCOLOR;//、[UIColor orangeColor];
    lbl.font = AppFont;
    lbl.text =[NSString stringWithFormat:@"剩余数量: %@", _BuyModlel.lastCount];
    [self.contentView addSubview:lbl];
    
    
    y += h + 5;
    NSString * ss222 = [NSString stringWithFormat:@"描述: %@",_BuyModlel.MCdescription];
    
    h = [MCIucencyView heightforString:ss222 andWidth:w fontSize:14];
    if (h < 20) {
        h = 20;
    }
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.textColor = AppTextCOLOR;//、[UIColor orangeColor];
    lbl.font = AppFont;
    lbl.text =ss222;//[NSString stringWithFormat:@"数量: %@", _BuyModlel.count];
    lbl.numberOfLines = 0;
    if (_BuyModlel.MCdescription.length) {
        lbl.hidden = NO;
    }
    else
    {
        lbl.hidden = YES;
        
    }

    [self.contentView addSubview:lbl];
    
    
    
    
    

    if ([_BuyModlel.type isEqualToString:@"pick"]||_BuyModlel.pickDate.length) {
        if (_BuyModlel.MCdescription.length) {
            y +=h + 5;
        }
        lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
        lbl.textColor = AppTextCOLOR;//、[UIColor orangeColor];
        lbl.font = AppFont;
        
        lbl.text =[NSString stringWithFormat:@"浮动比率: %@\%\%", _BuyModlel.priceFloat];
        [self.contentView addSubview:lbl];
        if (_BuyModlel.pickDate.length) {
            
        y +=h + 15;
        lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
        lbl.textColor = AppTextCOLOR;//、[UIColor orangeColor];
        lbl.font = AppFont;
        lbl.text =@"接单人:";//[NSString stringWithFormat:@"接单人: %@", _BuyModlel.count];
        [self.contentView addSubview:lbl];
        
        
        
        y -= 5;
        h += 10;
        
        CGFloat nameW = [MCIucencyView heightforString:_BuyModlel.pickerName ? _BuyModlel.pickerName :@"123" andHeight:h fontSize:14];
        
        
        _jiedanrenBtn = [[UIButton alloc]initWithFrame:CGRectMake(x + 50, y, h, h)];
        ViewRadius(_jiedanrenBtn, 30/2);
        [_jiedanrenBtn sd_setImageWithURL:[NSURL URLWithString:_BuyModlel.pickerImg] forState:0 placeholderImage:[UIImage imageNamed:@"home_Avatar_44"]];
        
        _jiedanrenBtn.titleLabel.font = AppFont;
        [_jiedanrenBtn setTitleColor:RGBCOLOR(127, 125, 147) forState:0];
        [self.contentView addSubview:_jiedanrenBtn];
        lbl = [[UILabel alloc]initWithFrame:CGRectMake(_jiedanrenBtn.mj_x + _jiedanrenBtn.mj_w + 5, y, nameW, h)];
        lbl.textColor = AppTextCOLOR;//、[UIColor orangeColor];
        lbl.font = AppFont;
        lbl.text = _BuyModlel.pickerName;
        [self.contentView addSubview:lbl];

        
    
        
        y += h + 5;
        lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
        lbl.textColor = AppTextCOLOR;//、[UIColor orangeColor];
        lbl.font = AppFont;
        NSString * timeStr = @"";
        if (_BuyModlel.pickDate) {
          timeStr =   [CommonUtil getStringWithLong:[_BuyModlel.pickDate longLongValue] Format:@"yyyy-MM-dd HH:mm"];
        }
        lbl.text =[NSString stringWithFormat:@"接单时间: %@",timeStr];
        [self.contentView addSubview:lbl];
        
        }
    }
    
    
    
    

    CGFloat shouW = [MCIucencyView heightforString:@"已收藏" andHeight:20 fontSize:14] +15;

    y += h + 10;
    x = self.contentView.mj_w - 5 - shouW;
    
    
    h = 20;
    _collectBtn = [[MCbackButton alloc]initWithFrame:CGRectMake(x, y, shouW,h )];
    
    _collectBtn.titleLabel.font = AppFont;
    [_collectBtn setTitle:@"收藏" forState:0];
    
    [_collectBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [_collectBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];

    [_collectBtn setImage:[UIImage imageNamed:@"travels_icon_favorite_normal"] forState:UIControlStateNormal];
    [_collectBtn setImage:[UIImage imageNamed:@"travels_icon_favorite_pressed"] forState:UIControlStateSelected];

    [_collectBtn setTitle:@"已收藏" forState:UIControlStateSelected];
//    _collectBtn.backgroundColor = AppCOLOR;
    _collectBtn.selected = _BuyModlel.isCollect;
    [self.contentView addSubview:_collectBtn];
    NSLog(@" =====%f",y + h );
    
    
}
-(void)setIsgengduan:(BOOL)isgengduan
{
    CGFloat h = [MCIucencyView heightforString:_BuyModlel.MCdescription andWidth:Main_Screen_Width - 80 - 30 fontSize:13];
    if (isgengduan) {
        
        _dataLbl.frame = CGRectMake(20, 85, Main_Screen_Width - 30 - 80, h);
        
        _foorView.frame = CGRectMake(0, _dataLbl.frame.origin.y + h, Main_Screen_Width - 80, 55);
        
        
    }

    //gengimg.hidden = isgengduan;
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
