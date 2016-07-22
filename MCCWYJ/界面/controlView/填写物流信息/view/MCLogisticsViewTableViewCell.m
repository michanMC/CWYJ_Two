//
//  MCLogisticsViewTableViewCell.m
//  MCCWYJ
//
//  Created by MC on 16/7/15.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MCLogisticsViewTableViewCell.h"

@implementation MCLogisticsViewTableViewCell
-(void)prepareCell1{
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, 44)];
    _titleLbl.textColor = [UIColor darkTextColor];
    _titleLbl.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_titleLbl];
    
    
    _seleBtn = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width - 10 - 30, 6, 30, 30)];
    _seleBtn.userInteractionEnabled = NO;
    [_seleBtn setImage:[UIImage imageNamed:@"list_checkbox_normal"] forState:UIControlStateNormal];
    [_seleBtn setImage:[UIImage imageNamed:@"list_checkbox_checked"] forState:UIControlStateSelected];
    [self.contentView addSubview:_seleBtn];

    
    
}
-(void)prepareCell2{
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 44)];
    _titleLbl.textColor = AppTextCOLOR;//[UIColor darkTextColor];
    _titleLbl.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_titleLbl];
    
    _titlesubLbl = [[UILabel alloc]initWithFrame:CGRectMake(10+100 + 10, 0, Main_Screen_Width - 120 - 20, 44)];
    _titlesubLbl.textColor = [UIColor lightGrayColor];
    _titlesubLbl.font = [UIFont systemFontOfSize:16];
    _titlesubLbl.text = @"请填写快递公司";
    [self.contentView addSubview:_titlesubLbl];
  
}

-(void)prepareCell3{
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 44)];
    _titleLbl.textColor = AppTextCOLOR;//[UIColor darkTextColor];
    _titleLbl.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_titleLbl];
    _text_Field = [[UITextField alloc]initWithFrame:CGRectMake(10+100 + 10, 0, Main_Screen_Width - 120 - 10 - 30, 44)];
    _text_Field.placeholder = @"请填写快递单号";
    _text_Field.font = [UIFont systemFontOfSize:16];
    _text_Field.textColor = AppTextCOLOR;//[UIColor darkTextColor];
    _text_Field.keyboardType = UIKeyboardTypeNumberPad;
    [self.contentView addSubview:_text_Field];

    _erweiBtn = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width - 40, 6, 30, 30)];
    [_erweiBtn setBackgroundImage:[UIImage imageNamed:@"nav_code"] forState:0];
    [self.contentView addSubview:_erweiBtn];

    
}
-(void)prepareCell4{
    
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    _text_Field = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, Main_Screen_Width -10 - 10 -30, 44)];
    _text_Field.placeholder = @"其他";
    _text_Field.font = [UIFont systemFontOfSize:16];
    _text_Field.textColor = AppTextCOLOR;//[UIColor darkTextColor];
    [self.contentView addSubview:_text_Field];

    
    _seleBtn = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width - 10 - 30, 6, 30, 30)];
    [_seleBtn setImage:[UIImage imageNamed:@"list_checkbox_normal"] forState:UIControlStateNormal];
    [_seleBtn setImage:[UIImage imageNamed:@"list_checkbox_checked"] forState:UIControlStateSelected];
    [self.contentView addSubview:_seleBtn];

    
    
    
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
