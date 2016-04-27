//
//  zuopinDataViewController.h
//  CWYouJi
//
//  Created by MC on 15/11/7.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "BaseViewController.h"
#import "homeYJModel.h"
@interface zuopinDataViewController : BaseViewController
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)homeYJModel *home_model;
-(id)initFrame:(CGRect)frame;
@end
