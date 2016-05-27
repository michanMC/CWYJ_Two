//
//  DepositTableViewCell.m
//  MCCWYJ
//
//  Created by MC on 16/5/27.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "DepositTableViewCell.h"

@implementation DepositTableViewCell

-(void)prepareUI{
    
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    CGFloat x = 10;
    CGFloat y = 0;
    CGFloat w = Main_Screen_Width - 10 - 10 - 30 - 10;
    CGFloat h = 44;
    _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _titleLbl.text = @"张三(134****22222)";
    _titleLbl.textColor = AppTextCOLOR;
    _titleLbl.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_titleLbl];
    
     x = Main_Screen_Width - 10 - 30;
    y = (h - 30)/2;
    h = 30;
    w = 30;
    _selectBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [_selectBtn setImage:[UIImage imageNamed:@"radio-btn_nor"] forState:UIControlStateNormal];
    [_selectBtn setImage:[UIImage imageNamed:@"radio-btn_selected"] forState:UIControlStateSelected];
    [self.contentView addSubview:_selectBtn];

    
    
    
    
}
-(void)prepareUI1{
    
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
  
    CGFloat x = 10;
    CGFloat y = 0;
    CGFloat w = 100;
    CGFloat h = 44;
    _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _titleLbl.text = @"提现到";
    _titleLbl.textColor = AppTextCOLOR;
    _titleLbl.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_titleLbl];
    
    x +=w;
    w = Main_Screen_Width - 10 - x;
    
    _subtitleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _subtitleLbl.text = @"支付宝(12321321312321)";
    _subtitleLbl.textColor = [UIColor darkTextColor];
    _subtitleLbl.textAlignment = NSTextAlignmentRight;

    _subtitleLbl.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_subtitleLbl];
    
}
-(void)prepareUI2{
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    CGFloat x = 10;
    CGFloat y = 0;
    CGFloat w = 100;
    CGFloat h = 44;
    _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _titleLbl.text = @"提现金额";
    _titleLbl.textColor = AppTextCOLOR;
    _titleLbl.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_titleLbl];
    
    x +=w;
    w = Main_Screen_Width - 10 - x;
    
   
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(x, y,w, h)];
    _textField.placeholder = @"输入提现金额";
    _textField.font = AppFont;
    _textField.textColor = [UIColor darkTextColor];
    _textField.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_textField];

    
    
    
    
    
}
-(void)prepareUI3{
    
    
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    _imgview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 6, 32, 32)];
    _imgview.image = [UIImage imageNamed:@"支付宝"];
    [self.contentView addSubview:_imgview];

    
    
    
    
    CGFloat x = 10 + 34 + 10;
    CGFloat y = 0;
    CGFloat w = 100;
    CGFloat h = 44;
    _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _titleLbl.text = @"支付宝";
    _titleLbl.textColor = AppTextCOLOR;
    _titleLbl.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_titleLbl];
    
    x = Main_Screen_Width - 10 - 30;
    y = (h - 30)/2;
    h = 30;
    w = 30;
    _selectBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [_selectBtn setImage:[UIImage imageNamed:@"radio-btn_nor"] forState:UIControlStateNormal];
    [_selectBtn setImage:[UIImage imageNamed:@"radio-btn_selected"] forState:UIControlStateSelected];
    [self.contentView addSubview:_selectBtn];
    
    
    
}
-(void)prepareUI4{
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    CGFloat x = 10;
    CGFloat y = 0;
    CGFloat w = 60;
    CGFloat h = 44;
    _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _titleLbl.text = @"账号:";
    _titleLbl.textColor = AppTextCOLOR;
    _titleLbl.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_titleLbl];
    
    x +=w;
    w = Main_Screen_Width - 10 - x;
    
    
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(x, y,w, h)];
    _textField.placeholder = @"请输入提现账号";
    _textField.font = AppFont;
    _textField.textColor = [UIColor darkTextColor];
//    _textField.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_textField];
    
    

    
    
    
    
    
}



-(void)prepareUI5{
    
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }

    CGFloat x = 10;
    CGFloat y = 6;
    CGFloat w = 30;
    CGFloat h = 30;

    
    _selectBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [_selectBtn setImage:[UIImage imageNamed:@"radio-btn_nor"] forState:UIControlStateNormal];
    [_selectBtn setImage:[UIImage imageNamed:@"radio-btn_selected"] forState:UIControlStateSelected];
    [self.contentView addSubview:_selectBtn];

    
    
     x = 0;
    y = 0;
    w= Main_Screen_Width;
    h = 44;
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_bgView];
    _subtitleLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, w - 10, h)];
    _subtitleLbl.text = @"支付宝(12321321312321)";
    _subtitleLbl.textColor = [UIColor darkTextColor];
    
    _subtitleLbl.font = [UIFont systemFontOfSize:15];
    [_bgView addSubview:_subtitleLbl];

    
    
    
    
    
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
