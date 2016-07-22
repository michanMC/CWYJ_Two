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
-(void)prepareUI:(NSString *)titleStr DataArray:(NSMutableArray*)dataArray {
    
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
    
    NSInteger count  = dataArray.count;
    
    if (dataArray.count > 4) {
        count = 4;
    }
    
    
    for (NSInteger i  = 0; i < count; i++) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
        NSString * urlStr;
        if ([titleStr isEqualToString:@"游记"]) {
         
            homeYJModel * model = dataArray[i];
            if (model.YJphotos.count) {
                YJphotoModel * dic = model.YJphotos[0];
                urlStr = dic.thumbnail;
            }
        }
        if ([titleStr isEqualToString:@"代购单"]) {
            
            MCBuyModlel * model = dataArray[i];
            if (model.YJphotos.count) {
                YJphotoModel * dic = model.YJphotos[0];
                urlStr = dic.raw;
            }
        }
        if ([titleStr isEqualToString:@"售卖单"]) {
            
            MCBuyModlel * model = dataArray[i];
            if (model.YJphotos.count) {
                YJphotoModel * dic = model.YJphotos[0];
                urlStr = dic.raw;
            }
        }

        
        
        [btn sd_setImageWithURL:[NSURL URLWithString:urlStr] forState:0 placeholderImage:[UIImage imageNamed:@"city-card_default-photo"]];
        btn.userInteractionEnabled = NO;
        [self.contentView addSubview:btn];
        x += w + 5;

    }
    
    
    
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
