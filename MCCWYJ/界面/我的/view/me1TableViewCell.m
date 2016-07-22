//
//  me1TableViewCell.m
//  MCCWYJ
//
//  Created by MC on 16/5/3.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "me1TableViewCell.h"

@implementation me1TableViewCell
-(void)prepareStr:(NSString*)str TitleStr:(NSString*)titleStr Ishong:(BOOL)ishong{
    
    for (UIView * view  in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    CGFloat selfViewW = Main_Screen_Width - 50;
    CGFloat h = 0;
    CGFloat y = 20;
    CGFloat x = 10;

    if ([str length]) {
      h  = [MCIucencyView heightforString:str andWidth:selfViewW - 20 fontSize:14];
        UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, selfViewW - 20, h)];
        lbl.textColor = AppTextCOLOR;
        lbl.text = str;
        lbl.numberOfLines = 0;
        lbl.font = AppFont;
        [self.contentView addSubview:lbl];
        
    }
    y +=h + 10;
    CGFloat w = 20;
    h = 20;
  _imgview = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
//    imgview.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_imgview];

    x +=w + 10;
    w = selfViewW / 2;
    UILabel * titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    titleLbl.text = titleStr;
    titleLbl.textColor = AppTextCOLOR;
    titleLbl.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:titleLbl];

   
    
    x = selfViewW - 10 - 5;
    y +=7.5;
    w = 5;
    h = 5;
    UIView * hongview = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    hongview.backgroundColor = AppCOLOR;//[UIColor orangeColor];
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
