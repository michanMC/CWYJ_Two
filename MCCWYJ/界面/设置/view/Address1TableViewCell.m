//
//  Address1TableViewCell.m
//  MCCWYJ
//
//  Created by MC on 16/5/4.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "Address1TableViewCell.h"

@implementation Address1TableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
//        imgView.backgroundColor = AppRegTextCOLOR;
        imgView.image = [UIImage imageNamed:@"icon_add"];
        [self.contentView addSubview:imgView];
        
        UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 100, 50)];
        lbl.text = @"新增地址";
        lbl.textColor  = AppTextCOLOR;
        lbl.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:lbl];

        
        
        
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
