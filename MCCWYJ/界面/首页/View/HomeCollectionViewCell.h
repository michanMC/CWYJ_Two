//
//  HomeCollectionViewCell.h
//  MCCWYJ
//
//  Created by MC on 16/5/7.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UIButton * headerimgBtn;
@property(nonatomic,strong)UIButton * buyBtn;



-(void)prepareMeUI;

-(void)prepareHotUI;

-(void)prepareYJUI;


@end
