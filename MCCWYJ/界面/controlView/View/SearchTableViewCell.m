//
//  SearchTableViewCell.m
//  MCCWYJ
//
//  Created by MC on 16/5/23.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "SearchTableViewCell.h"

@implementation SearchTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 12, 20, 20)];
        img.image = [UIImage imageNamed:@"ic_icon_search2"];

        [self.contentView addSubview:img];
        
        
        _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(10 + 20 + 10, 0, Main_Screen_Width - 40, 44)];
        _titleLbl.textColor = AppTextCOLOR;
        _titleLbl.font = [UIFont systemFontOfSize:15];
        
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
