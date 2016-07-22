//
//  RechargeTableViewCell.m
//  MCCWYJ
//
//  Created by MC on 16/5/27.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "RechargeTableViewCell.h"

@implementation RechargeTableViewCell
-(void)prepareUI1{
    
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    
    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(10, (44- 20)/2, 20, 20)];
    img.image = [UIImage imageNamed:@"-icon_recharge"];
    [self.contentView addSubview:img];
    
    
    
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, 300, 44)];
    lbl.text = @"请选择充值方式";
    lbl.textColor = AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:lbl];

    
}

-(void)prepareUI2{
    
    
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }

    
    CGFloat x = 10;
    CGFloat y = 6;
    CGFloat w = 30;
    CGFloat h = w;
    _imgview = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _imgview.image = [UIImage imageNamed:@"支付宝"];
    [self.contentView addSubview:_imgview];
    
    x += w + 10;
    w = Main_Screen_Width - x - 40;
    _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, 0, w, 44)];
    _titleLbl.textColor = AppTextCOLOR;
    _titleLbl.text = @"支付宝充值";
    _titleLbl.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_titleLbl];

    _selectBtn = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width - 10 - 30, 6, 30, 30)];
    [_selectBtn setImage:[UIImage imageNamed:@"radio-btn_nor"] forState:UIControlStateNormal];
    [_selectBtn setImage:[UIImage imageNamed:@"radio-btn_selected"] forState:UIControlStateSelected];
    _selectBtn.userInteractionEnabled = NO;
    [self.contentView addSubview:_selectBtn];

    
    
    
    
    
}
-(void)prepareUI3{
    
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    UILabel * lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, 44)];
    lbl.textColor = AppTextCOLOR;
    lbl.text = @"金额";
    lbl.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:lbl];
    
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(80, 0,Main_Screen_Width - 90, 44)];
    _textField.placeholder = @"请输入充值金额,至少一元";
    _textField.font = AppFont;
    _textField.textColor = [UIColor darkTextColor];
    //    _textField.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_textField];
    
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
