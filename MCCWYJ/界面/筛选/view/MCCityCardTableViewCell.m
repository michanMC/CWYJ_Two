//
//  MCCityCardTableViewCell.m
//  MCCWYJ
//
//  Created by MC on 16/6/8.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MCCityCardTableViewCell.h"

@implementation MCCityCardTableViewCell

-(void)prepareUI1:(NSString*)str{
    
    
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    self.backgroundColor = [UIColor clearColor];

    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, Main_Screen_Width - 100, 50)];
    lbl.font = [UIFont systemFontOfSize:20];
    lbl.textColor = [UIColor whiteColor];
    [self.contentView addSubview:lbl];
    lbl.text = str;
    
    
    
    
}
-(void)prepareUI2:(NSMutableDictionary*)dic{
    
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    self.backgroundColor = [UIColor clearColor];

    NSString * str = dic[@"str"];
//    NSArray * array = dic[@"array"];
    NSArray * array = dic[@"array"];

    
    CGFloat x = 10;
    CGFloat y  = 5;
    CGFloat w = 10;
    CGFloat h = 10;
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    view.backgroundColor = [UIColor whiteColor];
    ViewRadius(view, w / 2);
    [self.contentView addSubview:view];
    
    x += w + 10;
    y = 0;
    h = 20;
    w = 200;
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
//    lbl.font = [UIFont systemFontOfSize:20];
    lbl.textColor = [UIColor whiteColor];
    [self.contentView addSubview:lbl];
    lbl.text = str;

    
    y += 10+h;
    h = 24;
    CGFloat offx = 10;
    CGFloat offy = 10;
    CGFloat offw = x;
    CGFloat overy = y;
    w = Main_Screen_Width - 100 - x - 10;
    
    
    for (NSInteger i = 0; i < array.count; i ++) {
        NSString * str2 = array[i];
        
      CGFloat lblw = [MCIucencyView heightforString:str2 andHeight:h fontSize:14] + 15;
        UILabel * titleLbl =[[UILabel alloc]initWithFrame:CGRectMake(x, y, lblw, h)];
        overy = y;
        titleLbl.font = [UIFont systemFontOfSize:14];
        titleLbl.textColor = AppTextCOLOR;
        [self.contentView addSubview:titleLbl];
        titleLbl.text = str2;
        titleLbl.textAlignment = NSTextAlignmentCenter;
        ViewRadius(titleLbl, 2);
        titleLbl.backgroundColor = [UIColor whiteColor];
       x+=lblw + offx;
        
        
        if (i+1 <array.count) {
            str2 = array[i+1];
           lblw = [MCIucencyView heightforString:str2 andHeight:h fontSize:14] + 15;
            if (x + lblw > w) {
                x = offw;
                y += offy + h;
            }
            
        }
        

    }
    
    overy +=h + 9;
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(10, overy, Main_Screen_Width - 120, 1)];
    lineView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:lineView];
    
    
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
