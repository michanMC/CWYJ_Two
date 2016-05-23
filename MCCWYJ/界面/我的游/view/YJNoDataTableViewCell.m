//
//  YJNoDataTableViewCell.m
//  MCCWYJ
//
//  Created by MC on 16/5/23.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "YJNoDataTableViewCell.h"

@implementation YJNoDataTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)prepareNoDataUI:(CGFloat)viewH TitleStr:(NSString*)titleStr{
    for (UIView* obj in self.contentView.subviews)
        [obj removeFromSuperview];

    CGFloat w = 150;
    CGFloat h = w;
    CGFloat x = (Main_Screen_Width - w )/2;
    CGFloat y = (viewH - w) / 2 - 20 - 10;
    
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    
    imgView.image = [UIImage imageNamed:@"搜索空-缺省页"];
    [self.contentView addSubview:imgView];
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, y + w + 10, Main_Screen_Width, 20)];
    lbl.text = titleStr;
    lbl.textColor = AppTextCOLOR;
    lbl.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:lbl];
    
    _tapBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, viewH)];
    [self.contentView addSubview:_tapBtn];
    

    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
