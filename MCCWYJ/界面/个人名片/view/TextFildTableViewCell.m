//
//  TextFildTableViewCell.m
//  MCCWYJ
//
//  Created by MC on 16/5/24.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "TextFildTableViewCell.h"

@implementation TextFildTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, Main_Screen_Width - 20, 44)];
        
        _textField.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_textField];
        _textField.textColor = [UIColor grayColor];
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
