//
//  BillViewController.h
//  MCCWYJ
//
//  Created by MC on 16/6/3.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "BaseViewController.h"
#import "MyPurchaseViewController.h"
@interface BillViewController : BaseViewController
-(void)actionEdit;
@property(nonatomic,weak)MyPurchaseViewController * delegate;
@property(nonatomic,strong)UITableView *tableView;

@end
