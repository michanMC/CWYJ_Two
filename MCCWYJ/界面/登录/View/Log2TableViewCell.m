//
//  Log2TableViewCell.m
//  MCCWYJ
//
//  Created by MC on 16/4/29.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "Log2TableViewCell.h"

@implementation Log2TableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat h = 50*MCHeightScale;
        NSString * str = @"使用采点账号登录";
        CGFloat lblw =[MCIucencyView heightforString:str andHeight:h fontSize:15];
        
        CGFloat linew = (Main_Screen_Width - 80 - lblw - 10 ) /2;
        CGFloat liney = (h -1)/2;
        
        UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, h)];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.textColor = AppTextCOLOR;
        lbl.font = [UIFont systemFontOfSize:15];
        lbl.text = str;
        [self.contentView addSubview:lbl];
        
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(40, liney, linew, 1)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:lineView];
        lineView = [[UIView alloc]initWithFrame:CGRectMake(Main_Screen_Width - 40 - linew, liney, linew, 1)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:lineView];
        
        
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
