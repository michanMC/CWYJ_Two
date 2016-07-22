//
//  DepositView1Controller.h
//  MCCWYJ
//
//  Created by MC on 16/5/27.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "BaseViewController.h"
#import "MyIntegralModel.h"

@interface DepositView1Controller : BaseViewController
@property(nonatomic,strong)UITableView *tableView;


@property(nonatomic,copy)NSString * paymentAccountId;


@property(nonatomic,copy)NSString *integral;

@property(nonatomic,strong)MyIntegralModel * seleModel;
@end
