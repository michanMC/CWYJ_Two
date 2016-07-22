//
//  BuyOrderTableViewCell.m
//  MCCWYJ
//
//  Created by MC on 16/6/21.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "BuyOrderTableViewCell.h"

@implementation BuyOrderTableViewCell
-(void)prepareUI1{
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    CGFloat x = 10;
    CGFloat y = 0;
    CGFloat w = Main_Screen_Width - x;
    CGFloat h = 44;
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.text = [NSString stringWithFormat:@"订单号:%@",_BuyModlel.orderNumber];
    lbl.textColor = [UIColor grayColor];
    lbl.font = AppFont;
    [self.contentView addSubview:lbl];
    
    w = 100;
    x = Main_Screen_Width - 10 - w;
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

    lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.text = ss;
    lbl.textColor = AppCOLOR;
    lbl.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:lbl];
    
    
}
-(void)prepareUIadder{
   // 10+15+10+40+10
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    CGFloat x = 10;
    CGFloat y = (85-30)/2;
    CGFloat w = 30;
    CGFloat h = 30;
    UIImageView * imgview = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    imgview.image = [UIImage imageNamed:@"icon_map1"];
    [self.contentView addSubview:imgview];
    
    x += w + 10;
    y = 10;
    h = 15;
    w = 150;
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.textColor = AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:16];
    lbl.text = _BuyModlel.deliveryName;
    [self.contentView addSubview:lbl];

    w = Main_Screen_Width/2-10;
    x = Main_Screen_Width - 10 - w;
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.textColor = AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:14];
    lbl.textAlignment = NSTextAlignmentRight;
    lbl.text = _BuyModlel.mobile;
    [self.contentView addSubview:lbl];

    y += h + 10;
    x = 10 + 30 + 10;
    w =  Main_Screen_Width - 10 - x;
    h = 40;
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.textColor = [UIColor grayColor];
    lbl.font = [UIFont systemFontOfSize:14];
    lbl.numberOfLines = 0;
    lbl.text = _BuyModlel.address;
    [self.contentView addSubview:lbl];
}
-(void)prepareUIwuliu{
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    CGFloat x = 10;
    CGFloat y = (85-30)/2;
    CGFloat w = 30;
    CGFloat h = 30;
    UIImageView * imgview = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    imgview.image = [UIImage imageNamed:@"icon_Logistical"];
    [self.contentView addSubview:imgview];
    
    x += w + 10;
    y = 10;
    h = 15;
    w = 150;
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.textColor = AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:16];
    lbl.text = @"物流信息";
    [self.contentView addSubview:lbl];

    y += h + 10;
    w = Main_Screen_Width - 10 - x;
    h = 15;
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.textColor = AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:14];
    lbl.text = [NSString stringWithFormat:@"快递公司: %@",_BuyModlel.courierCompany];
//    lbl.text = @"快递公司:";
    [self.contentView addSubview:lbl];
    y+= h + 10;
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.textColor = AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:14];
    lbl.text = [NSString stringWithFormat:@"快递单号: %@",_BuyModlel.orderNumber];

//    lbl.text = @"快递单号:";
    [self.contentView addSubview:lbl];

 
}
-(void)prepareUI2{
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    CGFloat x = 10;
    CGFloat y = 0;
    CGFloat w = Main_Screen_Width - x;
    CGFloat h = 44;
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.text = [NSString stringWithFormat:@"卖家:%@",_BuyModlel.nickname];
    
    lbl.textColor = [UIColor grayColor];
    lbl.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:lbl];
  
    
    
}
-(void)prepareUIbuy{
    
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
  CGFloat y = 0;
  CGFloat  w = Main_Screen_Width;
   CGFloat h = 80;
  CGFloat  x = 0;

    UIView * bgView3 = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    bgView3.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:bgView3];
    
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
    priceLbl.text = [NSString stringWithFormat:@"￥%@",_BuyModlel.price];//@"￥300.00";//_BuyModlel.userModel.nickname;
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

    
}
-(void)prepareUI3{
    
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    CGFloat y = 10;
    CGFloat w = 200;
    CGFloat h = 20;
    CGFloat x = 10;
    CGFloat x1 = 10;
    CGFloat x2 = Main_Screen_Width - 10 - 200;

    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.textColor = AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:14];
    lbl.text = @"商品总额";
    [self.contentView addSubview:lbl];
    
    
    x = Main_Screen_Width - 10 - 200;
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.textColor = AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:16];
    lbl.textAlignment = NSTextAlignmentRight;
    NSString*  ss = [NSString stringWithFormat:@"￥%.2f",[_BuyModlel.price floatValue] * [_BuyModlel.count integerValue]];
    lbl.text = ss;
    [self.contentView addSubview:lbl];

    y +=h + 10;
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(x1, y, w, h)];
    lbl.textColor = AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:14];
    lbl.text = @"赠点";
    [self.contentView addSubview:lbl];

    
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(x2, y, w, h)];
    lbl.textColor = AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:16];
    lbl.textAlignment = NSTextAlignmentRight;
    ss = [NSString stringWithFormat:@"-￥%.2f",[_BuyModlel.systemIntegral floatValue] ];
    lbl.text =ss;// @"-￥0.00";
    [self.contentView addSubview:lbl];
    
    y +=h + 10;
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(x1, y, w, h)];
    lbl.textColor = AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:14];
    lbl.text = @"采点";
    [self.contentView addSubview:lbl];
    
    
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(x2, y, w, h)];
    lbl.textColor = AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:16];
    lbl.textAlignment = NSTextAlignmentRight;
    ss = [NSString stringWithFormat:@"-￥%.2f",[_BuyModlel.MCuserIntegral floatValue] ];
    lbl.text = ss;//@"-￥0.00";
    [self.contentView addSubview:lbl];


    
    
}
-(void)prepareUI4{
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    CGFloat y = 10;
    CGFloat w = Main_Screen_Width - 10;
    CGFloat h = 20;
    CGFloat x = 0;

  NSString*  ss = [NSString stringWithFormat:@"实付款:￥%.2f",[_BuyModlel.price floatValue] * [_BuyModlel.count integerValue]];

    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.text = ss;
    lbl.textColor = AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:16];
    lbl.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:lbl];

    y +=h + 10;
    
   ss = [NSString stringWithFormat:@"下单时间:%@",[CommonUtil getStringWithLong:[_BuyModlel.payDate longLongValue] Format:@"yyyy-MM-dd HH:mm:ss"]];
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.text = ss;
    lbl.textAlignment = NSTextAlignmentRight;

    lbl.textColor = AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:14];
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
