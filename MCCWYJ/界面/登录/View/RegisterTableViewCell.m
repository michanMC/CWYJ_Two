//
//  RegisterTableViewCell.m
//  MCCWYJ
//
//  Created by MC on 16/5/4.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "RegisterTableViewCell.h"

@implementation RegisterTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat x = 20;
        CGFloat y = 0;
        CGFloat w = Main_Screen_Width - 40;
        CGFloat h = 50;
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(x, y, w, h)];
        _textField.font = AppFont;
        [self.contentView addSubview:_textField];
        
        
        
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
