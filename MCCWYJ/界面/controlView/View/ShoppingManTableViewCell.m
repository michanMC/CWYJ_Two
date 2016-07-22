//
//  ShoppingManTableViewCell.m
//  MCCWYJ
//
//  Created by MC on 16/6/24.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "ShoppingManTableViewCell.h"





@implementation ShoppingManTableViewCell

-(void)prepareUI1{
    
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    CGFloat x = 10;
    CGFloat y  = 10;
    CGFloat w = 40;
    CGFloat h = w;
    
    UIButton * headBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
//    [headBtn setImage:[UIImage imageNamed:@"home_Avatar_60"] forState:0];
    
    [headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:_ShoppingModel.buyerImg] forState:0 placeholderImage:[UIImage imageNamed:@"home_Avatar_60"]];
    
    
    ViewRadius(headBtn, w/2);
    [self.contentView addSubview:headBtn];
    
    x += w + 10;
    h = 20;
    w = Main_Screen_Width/2 - x;
    
    UILabel * nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    nameLbl.text = _ShoppingModel.buyerName;
    nameLbl.textColor = AppTextCOLOR;
    nameLbl.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:nameLbl];

    y += h + 5;
    w = 70;
    UILabel * lbl =  [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.textColor = AppTextCOLOR;
    lbl.text = @"购买数量:";
    lbl.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:lbl];

    x += w ;
    w = Main_Screen_Width / 2 - x;
    UILabel * countLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    countLbl.textColor = AppCOLOR;
    countLbl.text = _ShoppingModel.count;
    countLbl.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:countLbl];
    
    y = nameLbl.mj_y;
    x = Main_Screen_Width/2 ;
    w = Main_Screen_Width / 2 -10;
    h = 20;
    lbl =  [[UILabel alloc]initWithFrame:CGRectMake(x - 30, y, w+30, h)];
    lbl.textColor = [UIColor grayColor];
//    lbl.backgroundColor = [UIColor yellowColor];
    lbl.text = [NSString stringWithFormat:@"订单号:%@",_ShoppingModel.orderNumber ];//@"订单号:12345324324332";
    lbl.adjustsFontSizeToFitWidth = YES;
    lbl.font = [UIFont systemFontOfSize:14];
    lbl.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:lbl];
    
    y += h + 5;
    
    lbl =  [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.textColor = [UIColor grayColor];
    lbl.text =[CommonUtil getStringWithLong:[_ShoppingModel.orderTime longLongValue] Format:@"yyyy-MM-dd HH:mm:ss"];// @"2015-09-09 12:12:12";
    lbl.adjustsFontSizeToFitWidth = YES;

    lbl.font = [UIFont systemFontOfSize:14];
    lbl.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:lbl];

    
    
    
}
-(void)prepareUI2{
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
   // 5 + 20 + 5 + 40 + 10
    CGFloat viewh = 80;
    CGFloat x = 10;
    CGFloat w = 35;
    CGFloat y  = (viewh - w)/2;
    CGFloat h = w;
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    imgView.image = [ UIImage imageNamed:@"icon_map1"];
    [self.contentView addSubview:imgView];
    
    x += w + 10;
    y = 5;
    h = 20;
    w = Main_Screen_Width/2 - x;
    
    UILabel * nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    nameLbl.text = _ShoppingModel.deliveryerName;
    nameLbl.font = [UIFont systemFontOfSize:16];
    nameLbl.textColor = AppTextCOLOR;
    [self.contentView addSubview:nameLbl];
    

    y = nameLbl.mj_y;
    x = Main_Screen_Width/2;
    w = Main_Screen_Width / 2 - 10;
    h = 20;
  UILabel*  phoneLbl =  [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    phoneLbl.textColor = AppTextCOLOR;
    phoneLbl.text = _ShoppingModel.mobile;//@"13420065848";
    phoneLbl.font = [UIFont systemFontOfSize:16];
    phoneLbl.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:phoneLbl];
    
    y += h + 5;
    x = nameLbl.mj_x;
    w = Main_Screen_Width - 10 - x;
    h = 40;
    UILabel*lbl =  [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.textColor = AppTextCOLOR;
    lbl.text = _ShoppingModel.address;//@"订单号:12345324324332订单号:12345324324332订单号:12345324324332订单号:12345324324332";
    lbl.font = [UIFont systemFontOfSize:15];
    lbl.numberOfLines = 0;
    [self.contentView addSubview:lbl];

}
-(void)prepareUI3{
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    // 5 + 20 + 5 + 40 + 10
    CGFloat x = 10;
    CGFloat w = 60;
    CGFloat y  =0;
    CGFloat h = 50;
  
    UILabel*lbl =  [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.textColor = AppTextCOLOR;
    lbl.text = @"实付款:";
    lbl.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:lbl];
    x += w + 5;
    w = Main_Screen_Width / 2- x;
    lbl =  [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.textColor = AppCOLOR;
    lbl.text =[NSString stringWithFormat:@"￥%@",_ShoppingModel.price];// @"￥276.00";
    lbl.font = [UIFont systemFontOfSize:17];
    [self.contentView addSubview:lbl];
    
    
    w = 64;
    y = 10;
    h = 50 - 20;
    x = Main_Screen_Width - 10 - w;
    _typeBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    
    _typeBtn.titleLabel.font = AppFont;
    [_typeBtn setTitleColor:RGBCOLOR(232, 48, 17) forState:0];
    _typeBtn.layer.borderWidth = 1;
    _typeBtn.layer.borderColor = RGBCOLOR(232, 48, 17).CGColor;
    ViewRadius(_typeBtn, 3);
    [self.contentView addSubview:_typeBtn];

    w = 80;
    x -=(w + 10);
    
    _type2Btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _type2Btn.titleLabel.font = AppFont;

//    [_type2Btn setTitle:@"拒绝退款" forState:0];
    [_type2Btn setTitleColor:[UIColor grayColor] forState:0];
    _type2Btn.layer.borderWidth = 1;
    _type2Btn.layer.borderColor = [UIColor grayColor].CGColor;
    ViewRadius(_type2Btn, 3);
    [self.contentView addSubview:_type2Btn];
    
    // 订单状态 未发货：0,     已发货：1,    已完成：2,    已关闭：3,退款成功：4，退款中：5

    if ([_ShoppingModel.status isEqualToString:@"0"]) {
        [_typeBtn setTitle:@"发货" forState:0];
        _type2Btn.hidden = YES;
        
    }
    else if ([_ShoppingModel.status isEqualToString:@"1"]){
        
        [_typeBtn setTitle:@"已发货" forState:0];
        _typeBtn.userInteractionEnabled = NO;
        _typeBtn.layer.borderWidth = 0;
        _typeBtn.layer.borderColor = [UIColor clearColor].CGColor;

        _type2Btn.hidden = YES;

        
    }
    else if ([_ShoppingModel.status isEqualToString:@"2"]){
        [_typeBtn setTitle:@"已完成" forState:0];
        _typeBtn.userInteractionEnabled = NO;
        _typeBtn.layer.borderWidth = 0;
        _typeBtn.layer.borderColor = [UIColor clearColor].CGColor;
        
        _type2Btn.hidden = YES;


    }
     else if ([_ShoppingModel.status isEqualToString:@"3"]){
         [_typeBtn setTitle:@"已关闭" forState:0];
         _typeBtn.userInteractionEnabled = NO;
         _typeBtn.layer.borderWidth = 0;
         _typeBtn.layer.borderColor = [UIColor clearColor].CGColor;
         
         _type2Btn.hidden = YES;

         
     }
     else if ([_ShoppingModel.status isEqualToString:@"4"]){
         [_typeBtn setTitle:@"已退款" forState:0];
         _typeBtn.userInteractionEnabled = NO;
         _typeBtn.layer.borderWidth = 0;
         _typeBtn.layer.borderColor = [UIColor clearColor].CGColor;
         
         _type2Btn.hidden = YES;
         
         
         
     }

     else if ([_ShoppingModel.status isEqualToString:@"5"]){
         _type2Btn.hidden = NO;

         [_typeBtn setTitle:@"同意退款" forState:0];

         [_type2Btn setTitle:@"拒绝退款" forState:0];
         
     }

}
-(void)prepareUI4{
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }

    CGFloat viewh = 80;
    CGFloat x = 10;
    CGFloat w = 35;
    CGFloat y  = (viewh - w)/2;
    CGFloat h = w;
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    imgView.image = [ UIImage imageNamed:@"icon_Logistical"];
    [self.contentView addSubview:imgView];
    
    x += w + 10;
    y = 5;
    w = Main_Screen_Width - x;
    h = 20;
    
    UILabel*lbl =  [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.textColor = AppTextCOLOR;
    lbl.text = @"物流信息";
    lbl.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:lbl];
    y+=h + 5;
    lbl =  [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.textColor = AppTextCOLOR;
    lbl.text =[NSString stringWithFormat:@"快递公司:%@",_ShoppingModel.courierCompany];// @"快递公司:顺丰快递";
    lbl.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:lbl];

    y+=h + 5;
    lbl =  [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.textColor = AppTextCOLOR;
    lbl.text =[NSString stringWithFormat:@"快递单号:%@",_ShoppingModel.courierNumber];// @"快递单号:3321321312312312";
    lbl.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:lbl];

    

    
}
-(void)prepareUI5{
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    CGFloat viewh = 80;
    CGFloat x = 10;
    CGFloat w = 35;
    CGFloat y  = (viewh - w)/2;
    CGFloat h = w;
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    imgView.image = [ UIImage imageNamed:@"icon_refund"];
    [self.contentView addSubview:imgView];
    
    x += w + 10;
    y = 5;
    w = Main_Screen_Width - x - 10;
    h = 20;
    
    UILabel*lbl =  [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.textColor = AppTextCOLOR;
    lbl.text = @"退款信息";
    lbl.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:lbl];
    y+=h + 5;
    NSString * ss = _ShoppingModel.refundMessage;//@"退款说明: 今天收到货了，发现收到的商品与描述不符，希望卖家能同意退款，谢谢啦";
    h = [MCIucencyView heightforString:ss andWidth:w fontSize:14];
    if (h < 20) {
        h = 20;
    }
    lbl =  [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.numberOfLines = 0;
    lbl.textColor = AppTextCOLOR;
    lbl.text =ss;
    lbl.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:lbl];
    
    y+=h + 5;
    h = 20;
    lbl =  [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.textColor = AppTextCOLOR;
    lbl.text =[NSString stringWithFormat:@"退款金额:%@",_ShoppingModel.refundPrice];// @"退款金额:￥3321";
    lbl.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:lbl];
    
    y += h + 10;
    
    CGFloat iy  = (y - 35)/2;
    imgView.frame = CGRectMake(imgView.mj_x, iy, 35, 35);

    
    w = [MCIucencyView heightforString:@"上传图片:" andHeight:20 fontSize:14];
    lbl =  [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.textColor = AppTextCOLOR;
    lbl.text = @"上传图片:";
    lbl.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:lbl];

    x += w + 5;
    w = (Main_Screen_Width -x - 5 * 3)/3;
    h = w;

    for (NSInteger i = 0; i < _ShoppingModel.YJphotos.count; i ++) {
        _imgBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
        YJphotoModel * model = _ShoppingModel.YJphotos[i];
        NSLog(@"model.raw  ==== %@",model.raw);
//        [_imgBtn setImage:[UIImage imageNamed:@"city-card_default-photo"] forState:0];
//        [_imgBtn setBackgroundImage:[UIImage imageNamed:@"city-card_default-photo"] forState:0];
        [_imgBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.raw] forState:0 placeholderImage:[UIImage imageNamed:@"city-card_default-photo"]];
        [self.contentView addSubview:_imgBtn];
        _imgBtn.tag = i + 555;
        [_imgBtn addTarget:self action:@selector(actionImgBtn:) forControlEvents:UIControlEventTouchUpInside];
        x += w + 5;
        
    }

    y += h + 10;
    
    iy  = (y - 35)/2;
    imgView.frame = CGRectMake(imgView.mj_x, iy, 35, 35);

  
    
    
}
-(void)actionImgBtn:(UIButton*)btn{
    
    if (_delegate) {
        NSInteger index = btn.tag - 555;
        [_delegate seleImgModel:_ShoppingModel Index:index];
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
