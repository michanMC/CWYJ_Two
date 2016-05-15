//
//  ProductionViewController.h
//  MCCWYJ
//
//  Created by MC on 16/5/8.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "BaseViewController.h"
@class homeYJModel;

@interface ProductionViewController : BaseViewController
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,strong)homeYJModel *home_model;

@end
