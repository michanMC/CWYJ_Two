//
//  RefundXQTableViewCell.m
//  MCCWYJ
//
//  Created by MC on 16/7/15.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "RefundXQTableViewCell.h"

@implementation RefundXQTableViewCell
-(void)preparebuyUI{
    
    for (UIView* obj in self.contentView.subviews)
        [obj removeFromSuperview];
    //    return 100 *MCHeightScale + 15 + 20 + 10;
    
    CGFloat x = 10;
    CGFloat y = 10;
    CGFloat w = Main_Screen_Width - 2*x;
    CGFloat h = 20;
    
    
    UILabel * nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    nameLbl.text = [NSString stringWithFormat:@"卖家:%@",_XQModel.sellerName];
    nameLbl.textColor = AppTextCOLOR;
    nameLbl.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:nameLbl];
    
    y += h + 10;
    UILabel * orderLbl=[[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    orderLbl.text =[NSString stringWithFormat:@"订单号:%@",_XQModel.orderNumber];// @":2321321332112";//_BuyModlel.userModel.nickname;
    orderLbl.textColor = [UIColor grayColor];
    orderLbl.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:orderLbl];
    
    h = y + h  + 10;
    y = 0;
    w = 200;
    x = Main_Screen_Width - w - 10;
    UILabel * _typeLbl =[[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    NSString * ss = @"不明状态";
//    0 不同意退款
//    1 同意退款
//    2 买家取消退款
//    3 退款中
    if ([_XQModel.status isEqualToString:@"0"]) {
        ss = @"不同意退款";
    }
    else if ([_XQModel.status isEqualToString:@"1"]) {
        ss = @"同意退款";
    }
    else if ([_XQModel.status isEqualToString:@"2"]) {
        ss = @"买家取消退款";
    }
    else if ([_XQModel.status isEqualToString:@"3"]) {
        ss = @"退款中";
    }
//    else if ([_XQModel.status isEqualToString:@"3"]) {
//        ss = @"已关闭";
//    }
//    else if ([_XQModel.status isEqualToString:@"3"]) {
//        ss = @"退款成功";
//    }
//    else if ([_XQModel.status isEqualToString:@"4"]) {
//        ss = @"退款中";
//    }
    _typeLbl.text = ss;//_BuyModlel.userModel.nickname;
    _typeLbl.textColor = AppCOLOR;
    _typeLbl.font = [UIFont systemFontOfSize:16];
    _typeLbl.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_typeLbl];
    
    y = h;
    w = Main_Screen_Width;
    h = 80;
    x = 0;
    UIView * bgView3 = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    bgView3.backgroundColor = AppMCBgCOLOR;//[UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:bgView3];
    
    x = 10;
    y = 10;
    
    w = 60;
    h = w;
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    //    imgView.image = [UIImage imageNamed:@"buy_default-photo"];
    if (_XQModel.BuyModlel.imageUrl.count) {
        NSLog(@"=====%@",_XQModel.BuyModlel.imageUrl[0]);
        [imgView sd_setImageWithURL:[NSURL URLWithString:_XQModel.BuyModlel.imageUrl[0]] placeholderImage:[UIImage imageNamed:@"buy_default-photo"]];
        
    }
    else
        imgView.image = [UIImage imageNamed:@"buy_default-photo"];
    
    
    [bgView3 addSubview:imgView];
    
    x += w + 5;
    w = Main_Screen_Width - x - 110;
    h = 40;
    UILabel * titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    titleLbl.text = [NSString stringWithFormat:@"【%@】%@",_XQModel.BuyModlel.brand,_XQModel.BuyModlel.name ];//@"【娇兰】限量帮限量帮限量帮限量帮限量帮限量帮限量帮限量帮限量帮限量帮";//_BuyModlel.userModel.nickname;
    titleLbl.numberOfLines = 0;
    titleLbl.textColor = AppTextCOLOR;
    titleLbl.font = [UIFont systemFontOfSize:14];
    [bgView3 addSubview:titleLbl];
    
    
    x = Main_Screen_Width - 10 - 100;
    w = 100;
    h = 20;
    UILabel * priceLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    priceLbl.text = [NSString stringWithFormat:@"￥%@",_XQModel.price];//@"￥300.00";//_BuyModlel.userModel.nickname;
    priceLbl.textColor = AppTextCOLOR;
    priceLbl.textAlignment = NSTextAlignmentRight;
    priceLbl.font = [UIFont systemFontOfSize:16];
    [bgView3 addSubview:priceLbl];
    y += h + 5;
    UILabel * countLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    countLbl.text = [NSString stringWithFormat:@"x%@",_XQModel.count ];//@"x4";//_BuyModlel.userModel.nickname;
    countLbl.textColor = [UIColor grayColor];
    countLbl.textAlignment = NSTextAlignmentRight;
    countLbl.font = [UIFont systemFontOfSize:14];
    [bgView3 addSubview:countLbl];
    
    
    y = bgView3.mj_y + bgView3.mj_h;
    NSLog(@"y============%f",y);
    return;
    
    
    
}
-(void)preparebuyUI2{
    
    for (UIView* obj in self.contentView.subviews)
        [obj removeFromSuperview];

    CGFloat x = 10;
    CGFloat y = 0;
    CGFloat w = 70;
    CGFloat h = 44;
    _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _titleLbl.textColor = AppTextCOLOR;
    _titleLbl.font = [UIFont systemFontOfSize:16];
    
    [self.contentView addSubview:_titleLbl];
    
    x += w + 5;
    w = Main_Screen_Width - x  - 10;
    _titlesubLbl= [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _titlesubLbl.textColor = AppTextCOLOR;
    _titlesubLbl.font = [UIFont systemFontOfSize:15];
    _titlesubLbl.numberOfLines = 0;
    [self.contentView addSubview:_titlesubLbl];
    
    CGFloat w2 =Main_Screen_Width -( 10 + 70 + 5 + 10);
    CGFloat h2 = (w - 30)/3;
//    return h + 20;
    _imgBgView = [[UIView alloc]initWithFrame:CGRectMake(x, 0, w2, h2 + 20)];
    _imgBgView.hidden = YES;
    [self.contentView addSubview:_imgBgView];

   CGFloat x1 = 0;
   
    
    for (NSInteger i = 0; i < _XQModel.imgArray.count; i ++) {
     UIButton*   _imgBtn = [[UIButton alloc]initWithFrame:CGRectMake(x1, 10, h2, h2)];
        YJphotoModel * model = _XQModel.imgArray[i];
        NSLog(@"model.raw  ==== %@",model.raw);

        [_imgBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.raw] forState:0 placeholderImage:[UIImage imageNamed:@"city-card_default-photo"]];
        [_imgBgView addSubview:_imgBtn];
        _imgBtn.tag = 555+i;
        [_imgBtn addTarget:self action:@selector(actionimgBtn:) forControlEvents:UIControlEventTouchUpInside];
        x1 += h2 + 10;
        
    }
    
}
-(void)actionimgBtn:(UIButton*)btn{
    
    NSInteger index = btn.tag - 555;
    if (_delegate) {
        [_delegate showimgindex:index];
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
