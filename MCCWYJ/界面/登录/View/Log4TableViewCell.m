//
//  Log4TableViewCell.m
//  MCCWYJ
//
//  Created by MC on 16/4/29.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "Log4TableViewCell.h"

@implementation Log4TableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, .5)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:lineView];
        
        lineView = [[UIView alloc]initWithFrame:CGRectMake(Main_Screen_Width/2 - 0.5, 5, .5, 44 - 10)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:lineView];
        
        _forgetBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, .5,(Main_Screen_Width - .5)/2 , 43)];
        [_forgetBtn setTitle:@"忘记密码" forState:0];
        [_forgetBtn setTitleColor:RGBCOLOR(127, 125, 147) forState:0];
        _forgetBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_forgetBtn];

        
        _recBtn = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width/2+.5, .5,(Main_Screen_Width - .5)/2 , 43)];
        [_recBtn setTitle:@"注册账号" forState:0];
        [_recBtn setTitleColor:RGBCOLOR(127, 125, 147) forState:0];
        _recBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_recBtn];
        
        

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
