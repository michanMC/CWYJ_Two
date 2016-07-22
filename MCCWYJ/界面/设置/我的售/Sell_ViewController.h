//
//  SellViewController.h
//  MCCWYJ
//
//  Created by MC on 16/6/3.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "BaseViewController.h"
#import "MySellViewController.h"
@interface Sell_ViewController : BaseViewController
-(void)actionEdit;
@property(nonatomic,weak)MySellViewController * delegate;
@property(nonatomic,strong)UITableView *tableView;

@end
