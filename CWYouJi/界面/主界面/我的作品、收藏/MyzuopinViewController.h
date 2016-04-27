//
//  MyzuopinViewController.h
//  CWYouJi
//
//  Created by MC on 15/11/1.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "BaseViewController.h"

@interface MyzuopinViewController : BaseViewController
@property(strong,nonatomic)NSMutableArray *dateMutablearray;
@property(strong,nonatomic)    UITableView * tableView;

//BOOL _isquanxuan;
//UIButton * _deleteBtn;
//
//NSMutableArray *_deleArray;//记录要删除的Btn
@property(nonatomic,assign)BOOL isquanxuan;
@property(nonatomic,strong)UIButton * deleteBtn;
@property(nonatomic,strong)NSMutableArray * deleArray;

-(void)actionBianji;

@end
