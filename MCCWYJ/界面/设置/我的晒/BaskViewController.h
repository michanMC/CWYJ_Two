//
//  BaskViewController.h
//  MCCWYJ
//
//  Created by MC on 16/6/3.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "BaseViewController.h"
#import "MyBaskViewController.h"
@interface BaskViewController : BaseViewController
-(void)actionEdit;
@property(nonatomic,weak)MyBaskViewController * delegate;
@property(nonatomic,strong)UITableView *tableView;


@end
