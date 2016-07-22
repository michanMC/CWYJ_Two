//
//  ShoppingManTableViewCell.h
//  MCCWYJ
//
//  Created by MC on 16/6/24.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingManModel.h"


@protocol ShoppingManDelegate <NSObject>

-(void)seleImgModel:(ShoppingManModel*)mdoel Index:(NSInteger)index;

@end


@interface ShoppingManTableViewCell : UITableViewCell
@property(nonatomic,weak)id<ShoppingManDelegate>delegate;
@property(nonatomic,strong)ShoppingManModel * ShoppingModel;

@property(nonatomic,strong)UIButton * typeBtn;
@property(nonatomic,strong)UIButton * type2Btn;

@property(nonatomic,strong)UIButton * imgBtn;

-(void)prepareUI1;
-(void)prepareUI2;
-(void)prepareUI3;
-(void)prepareUI4;
-(void)prepareUI5;


@end
