//
//  SearchTableViewCell.m
//  MCCWYJ
//
//  Created by MC on 16/5/23.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "SearchTableViewCell.h"

@interface SearchTableViewCell ()
{
    
    
    
}

@end


@implementation SearchTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 12, 20, 20)];
        img.image = [UIImage imageNamed:@"ic_icon_search2"];

        [self.contentView addSubview:img];
        
        
        _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(10 + 20 + 10, 0, Main_Screen_Width - 40 -(10 +15 + 10 + 30 +25 + 5), 44)];
        _titleLbl.textColor = AppTextCOLOR;
        _titleLbl.font = [UIFont systemFontOfSize:15];
        
        [self.contentView addSubview:_titleLbl];

        
        CGFloat w = 15;
        CGFloat x = Main_Screen_Width - 10 - w;
        CGFloat y = 10;
        CGFloat h = 24;
        
        
        w = 30;
        x = Main_Screen_Width - 10 - w;
        y = (44-18)/2;
        h = 18;
        
        _currentGrade = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
//        _currentGrade.image = [UIImage imageNamed:@"Lv_2"];
        [self.contentView addSubview:_currentGrade];
        
        w = 25;
        x -= (10 + w);
        y = (44-w)/2;
        h = w;
        
        _originalGrade = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
//        _originalGrade.image = [UIImage imageNamed:@"2A"];
        [self.contentView addSubview:_originalGrade];

         w = 15;
        x -= (10 + w);
         y = 10;
         h = 24;

        _trend = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
        //        _trend.image = [UIImage imageNamed:@"red_arrow"];
        [self.contentView addSubview:_trend];

        
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
