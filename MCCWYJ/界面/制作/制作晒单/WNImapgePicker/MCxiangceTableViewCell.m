//
//  MCxiangceTableViewCell.m
//  MCCWYJ
//
//  Created by MC on 16/5/25.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MCxiangceTableViewCell.h"

@implementation MCxiangceTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 70, 70)];
        [self.contentView addSubview:_imgView];
        _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(90, 0, 200, 90)];
        _titleLbl.textColor = AppTextCOLOR;
        _titleLbl.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_titleLbl];

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
