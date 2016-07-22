//
//  ReleaseMakeSellViewController.h
//  MCCWYJ
//
//  Created by MC on 16/6/23.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "BaseViewController.h"

@interface ReleaseMakeSellViewController : BaseViewController

@property(nonatomic,strong)UIImage * img;
@property(nonatomic,strong)NSMutableDictionary *commodityDic;
@property(nonatomic,assign)CGFloat lblView_x;
@property(nonatomic,assign)CGFloat lblView_y;
@property(nonatomic,copy)NSString * lblViewAlignmen;
@property(nonatomic,strong)NSMutableArray * shanBtnArray;
@property(nonatomic,assign)CGRect imgViewRect;

@end
