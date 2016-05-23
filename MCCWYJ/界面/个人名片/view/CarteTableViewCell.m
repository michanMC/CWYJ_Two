//
//  CarteTableViewCell.m
//  MCCWYJ
//
//  Created by MC on 16/5/23.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "CarteTableViewCell.h"

@implementation CarteTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)prepareUI:(NSString *)titleStr {
    
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    CGFloat x=(Main_Screen_Width - 50*5 -20 ) / 6;
    
    
    CGFloat w = 50;
    CGFloat y = 10;
    CGFloat h = w;
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, 10, w, h)];
    lbl.text = titleStr;
    lbl.font = AppFont;
    lbl.textColor = AppTextCOLOR;
    [self.contentView addSubview:lbl];
    x += w + 5;
    
    for (NSInteger i  = 0; i < 4; i++) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
        
        [btn setBackgroundImage:[UIImage imageNamed:@"city-card_default-photo"] forState:0];
        [self.contentView addSubview:btn];
        x += w + 5;

    }
    
    
    
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
