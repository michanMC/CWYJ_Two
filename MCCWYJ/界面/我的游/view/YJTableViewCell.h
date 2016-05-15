//
//  YJTableViewCell.h
//  MCCWYJ
//
//  Created by MC on 16/5/14.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "homeYJModel.h"
@interface YJTableViewCell : UITableViewCell
-(void)prepareUI:(homeYJModel*)model;

@property(nonatomic,strong)UIButton * headerimgBtn;
@property(nonatomic,strong)UIButton * dingweibtn;

@end
