//
//  MCLogisticsViewTableViewCell.h
//  MCCWYJ
//
//  Created by MC on 16/7/15.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCLogisticsViewTableViewCell : UITableViewCell

@property(nonatomic,strong)UIButton*seleBtn;
@property(nonatomic,strong)UILabel * titleLbl;


@property(nonatomic,strong)UILabel * titlesubLbl;

@property(nonatomic,strong)UITextField*text_Field;

@property(nonatomic,strong)UIButton*erweiBtn;

-(void)prepareCell1;
-(void)prepareCell2;
-(void)prepareCell3;


-(void)prepareCell4;



@end
