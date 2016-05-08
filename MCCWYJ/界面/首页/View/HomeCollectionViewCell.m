//
//  HomeCollectionViewCell.m
//  MCCWYJ
//
//  Created by MC on 16/5/7.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "HomeCollectionViewCell.h"

@implementation HomeCollectionViewCell

-(void)prepareMeUI{
    for (UIView* obj in self.contentView.subviews)
        [obj removeFromSuperview];
    
    self.contentView.backgroundColor = [UIColor yellowColor];
//    CGFloat slefViewW = (Main_Screen_Width - 15)/2 - 10+2.5;
//    CGFloat slefViewH = 110*MCHeightScale + 85 - 10;
//    UIView * _bgView = [[UIView alloc]initWithFrame:CGRectMake(5, 0, slefViewW, slefViewH)];
//    
//    _bgView.backgroundColor = [UIColor whiteColor];
//    [self.contentView addSubview:_bgView];
//    
}
-(void)prepareHotUI;
{
    for (UIView* obj in self.contentView.subviews)
        [obj removeFromSuperview];
    
    self.contentView.backgroundColor = [UIColor yellowColor];

}
-(void)prepareYJUI{
    for (UIView* obj in self.contentView.subviews)
        [obj removeFromSuperview];
    
    
    
    self.contentView.backgroundColor = [UIColor yellowColor];

    
}




@end
