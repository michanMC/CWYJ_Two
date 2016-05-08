//
//  Log3TableViewCell.m
//  MCCWYJ
//
//  Created by MC on 16/4/29.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "Log3TableViewCell.h"

@implementation Log3TableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat x = 40;
        CGFloat y = 10;
        CGFloat w = Main_Screen_Width - 80;
//        CGFloat selfh = (Main_Screen_Height-50*MCHeightScale)/2 - 44;
        CGFloat h = 44;
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, h)];
        ViewRadius(view, 5);
        view.layer.borderWidth = .5;
        view.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self.contentView addSubview:view];
        _nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(40, 0, view.mj_w - 45, h)];
        _nameTextField.placeholder = @"请输入账号";
        _nameTextField.textColor = [UIColor grayColor];
        _nameTextField.font = AppFont;
        [view addSubview:_nameTextField];
        _nameTextField.keyboardType = UIKeyboardTypeNumberPad;

        
        
        
        
        y +=h + 10;
        view = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, h)];
        ViewRadius(view, 5);
        view.layer.borderWidth = .5;
        view.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self.contentView addSubview:view];
        _pwdTextField = [[UITextField alloc]initWithFrame:CGRectMake(40, 0, view.mj_w - 45, h)];
        _pwdTextField.placeholder = @"请输入密码";
        _pwdTextField.textColor = [UIColor grayColor];
        _pwdTextField.font = AppFont;
        [view addSubview:_pwdTextField];
        //设置密码输入
        _pwdTextField.secureTextEntry = YES;

        
        
        
        
        
        
        
        
        y +=h + 20*MCHeightScale;
        
        _loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
        _loginBtn.backgroundColor = AppRegTextCOLOR;//[UIColor redColor];
        [_loginBtn setTitle:@"登录" forState:0];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:0];
        ViewRadius(_loginBtn, 5);

        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_loginBtn];

        

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
