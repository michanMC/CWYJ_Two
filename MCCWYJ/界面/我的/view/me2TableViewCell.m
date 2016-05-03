//
//  me2TableViewCell.m
//  MCCWYJ
//
//  Created by MC on 16/5/3.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "me2TableViewCell.h"

@implementation me2TableViewCell


-(void)preapreTitleStr:(NSString*)titleStr Ishong:(BOOL)ishong{
    for (UIView * view  in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    CGFloat x = 10;
    CGFloat y = 12;
    CGFloat w = 20;
    CGFloat h = 20;
    CGFloat selfViewW = Main_Screen_Width - 50;

    UIImageView * imgview = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    imgview.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:imgview];

    
    x +=w + 10;
    w = selfViewW / 2;
    UILabel * titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    titleLbl.text = titleStr;
    titleLbl.textColor = AppTextCOLOR;
    titleLbl.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:titleLbl];
    
    
    
    x = selfViewW - 10 - 5;
    y =(44 - 5)/2;
    w = 5;
    h = 5;
    UIView * hongview = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    hongview.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:hongview];
    ViewRadius(hongview, 5/2);
    hongview.hidden = !ishong;
    

    
    
    
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
