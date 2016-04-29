//
//  Log1TableViewCell.m
//  MCCWYJ
//
//  Created by MC on 16/4/29.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "Log1TableViewCell.h"



@implementation Log1TableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat selfViewh = 64*MCHeightScale;
        CGFloat imgW = (Main_Screen_Width - 2 - 80) / 3;
        CGFloat imgh = selfViewh - 20;
        CGFloat x = 40;
        UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(x, 0, imgW, imgh)];
        imgview.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:imgview];
        
        UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(x,selfViewh - 20 , imgW, 20)];
        lbl.text = @"微信登录";
        lbl.textColor = AppTextCOLOR;
        lbl.textAlignment = NSTextAlignmentCenter;

        lbl.font = AppFont;
        [self.contentView addSubview:lbl];
        
        
        x += imgW;
        UIView *lineView = [[UIView alloc]initWithFrame: CGRectMake(x, 0, 1, selfViewh)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:lineView];
        x +=1;
        imgview = [[UIImageView alloc]initWithFrame:CGRectMake(x, 0, imgW, imgh)];
        imgview.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:imgview];
        lbl = [[UILabel alloc]initWithFrame:CGRectMake(x,selfViewh - 20 , imgW, 20)];
        lbl.text = @"微信登录";
        lbl.textColor = AppTextCOLOR;
        lbl.textAlignment = NSTextAlignmentCenter;

        lbl.font = AppFont;
        [self.contentView addSubview:lbl];
        x += imgW;
        lineView = [[UIView alloc]initWithFrame: CGRectMake(x, 0, 1, selfViewh)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:lineView];

        
        
        x +=1;
        imgview = [[UIImageView alloc]initWithFrame:CGRectMake(x, 0, imgW, imgh)];
        imgview.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:imgview];
        lbl = [[UILabel alloc]initWithFrame:CGRectMake(x,selfViewh - 20 , imgW, 20)];
        lbl.text = @"微信登录";
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.textColor = AppTextCOLOR;
        lbl.font = AppFont;
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
