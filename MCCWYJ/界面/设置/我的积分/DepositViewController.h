//
//  DepositViewController.h
//  MCCWYJ
//
//  Created by MC on 16/5/27.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "BaseViewController.h"
#import "MyIntegralModel.h"
#import "DepositView1Controller.h"
@interface DepositViewController : BaseViewController
@property(nonatomic,strong)MyIntegralModel * seleModel;
@property(weak,nonatomic)DepositView1Controller* delegate;

@end
