//
//  MCCaiParticularsTableViewCell.m
//  MCCWYJ
//
//  Created by MC on 16/6/24.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MCCaiParticularsTableViewCell.h"

@implementation MCCaiParticularsTableViewCell
-(void)preppareui{
    
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    _lbl_l = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, Main_Screen_Width/2, 44)];
    _lbl_l.textColor = AppTextCOLOR;
    _lbl_l.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_lbl_l];
    
    _lbl_r = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width - 10, 44)];
    _lbl_r.textColor = AppTextCOLOR;
    _lbl_r.font = [UIFont systemFontOfSize:16];
    _lbl_r.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_lbl_r];
    

    
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
