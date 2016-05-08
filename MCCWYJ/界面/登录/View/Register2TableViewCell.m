//
//  Register2TableViewCell.m
//  MCCWYJ
//
//  Created by MC on 16/5/4.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "Register2TableViewCell.h"

@implementation Register2TableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat x = 20;
        CGFloat y = 0;
        CGFloat w = (Main_Screen_Width -40 )/2;
        CGFloat h = 50;
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(x, y, w, h)];
        _textField.font = AppFont;
        _textField.placeholder = @"验证码";
        [self.contentView addSubview:_textField];
        
        w = [MCIucencyView heightforString:@"获取验证码" andHeight:50 fontSize:14] + 10;
        
        x = Main_Screen_Width - 20 -w;
        
        _cvvBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
        [_cvvBtn setTitle:@"获取验证码" forState:0];
        [_cvvBtn setTitleColor:RGBCOLOR(207, 0, 51) forState:0];
        _cvvBtn.titleLabel.font = AppFont;
        [self.contentView addSubview:_cvvBtn];

        
        x = _cvvBtn.mj_x- 5;
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(x, 10, 1, 30)];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        [self.contentView addSubview:view];

        
    }
    return self;
    
    
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
