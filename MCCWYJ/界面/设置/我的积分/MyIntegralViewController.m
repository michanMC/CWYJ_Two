//
//  MyIntegralViewController.m
//  MCCWYJ
//
//  Created by MC on 16/5/27.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MyIntegralViewController.h"
#import "MyIntegralTableViewCell.h"
#import "DepositView1Controller.h"
#import "RechargeViewController.h"
#import "CaidianDetailedViewController.h"
#import "CaiParticularsViewController.h"
#import "MyIntegralModel.h"
#import "IntegralQXModel.h"
@interface MyIntegralViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView *_tableView;
    YJUserModel * _usermodel;

    MyIntegralModel *  _IntegralModel;
    
    NSMutableArray * _dataArray;
}

@end

@implementation MyIntegralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的采点";
    //监听数据的刷新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"MyIntegralViewObjNotification" object:nil];
    _dataArray = [NSMutableArray array];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = AppMCBgCOLOR;
    [self loadData];
    [self Datadetail];
//    __weak MyIntegralViewController *weakSelf = self;
//    __weak UITableView *weakSelft = _tableView;
//
//    [weakSelf showLoading];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//        
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            
//            [weakSelf stopshowLoading];
//            [weakSelft reloadData];
//            
//        });
//    });
//    

    // Do any additional setup after loading the view.
}

-(void)loadData2{
    NSDictionary * dic = @{
                           @"page":@(1)
                           };
    [self.requestManager postWithUrl:@"api/integral/query.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        [_dataArray removeAllObjects];
        [self stopshowLoading];

        NSLog(@"resultDic ===%@",resultDic);
        for (NSDictionary * dic in resultDic[@"object"]) {
            IntegralQXModel * modle = [IntegralQXModel mj_objectWithKeyValues:dic];
            [_dataArray addObject:modle];
        }
        [_tableView reloadData];

        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
    }];
 
    
}
-(void)Datadetail{
    [self.requestManager postWithUrl:@"api/user/detail.json" refreshCache:NO params:nil IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        
        NSLog(@"查询资料resultDic == %@",resultDic);
        
        
        _usermodel  = [YJUserModel mj_objectWithKeyValues:resultDic[@"object"]];
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
          }];
    
}

-(void)loadData{
    
     [self showLoading];
    NSDictionary * dic = @{
                         
                           };
    [self.requestManager postWithUrl:@"api/purse/getPurse.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        NSLog(@"resultDic ===%@",resultDic);
        _IntegralModel = [MyIntegralModel mj_objectWithKeyValues:resultDic[@"object"]];
        NSLog(@"%@",   _IntegralModel.systemIntegral);
        [_tableView reloadData];
        [self loadData2];

        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
        [self loadData2];

    }];
  
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    else
    {
        return _dataArray.count;
  
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view;
    if (section == 1) {
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 40)];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, Main_Screen_Width, 40)];
        lbl.textColor =AppTextCOLOR;
        lbl.text = @"账户余额收支明细";
        lbl.font = [UIFont systemFontOfSize:16];
        [view addSubview:lbl];
        return view;
    }
    
    return view;

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.001;
    }
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 125.50;
    }
    return 96;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString * cellid1 = @"MyIntegralTableViewCell";
    if (indexPath.section == 0) {
        MyIntegralTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
        if (!cell) {
            cell = [[MyIntegralTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid1];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        [cell prepareUI1:_IntegralModel];
        
        [cell.withdrawBtn addTarget:self action:@selector(actionTiXian) forControlEvents:UIControlEventTouchUpInside];
        [cell.rechargeBtn addTarget:self action:@selector(actionchongzhi) forControlEvents:UIControlEventTouchUpInside];
        [cell.mingxiBtn addTarget:self action:@selector(actionmingxiBtn) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
        
        
    }
else
{
    MyIntegralTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
    if (!cell) {
        cell = [[MyIntegralTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid1];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (_dataArray.count > indexPath.row) {
        IntegralQXModel * model = _dataArray[indexPath.row];
        cell.QXModel = model;
        [cell prepareUI2];

        
    }
    return cell;
}
    
    
    
    
    return [[UITableViewCell alloc]init];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section != 0) {
        CaiParticularsViewController * ctl = [[CaiParticularsViewController alloc]init];
        
        if (_dataArray.count > indexPath.row) {
            IntegralQXModel * model = _dataArray[indexPath.row];
            ctl.QXModel = model;
            
            [self pushNewViewController:ctl];

        }

        
    }
    
    
}
-(void)actionmingxiBtn{
    CaidianDetailedViewController * ctl = [[CaidianDetailedViewController alloc]init];
    [self pushNewViewController:ctl];
    
    
}
#pragma mark-提现
-(void)actionTiXian{
//    if (!_IntegralModel.uid.length) {
//        [self showHint:@"无效id"];
//        return;
//    }
    if (!_usermodel.hasPayPassword) {
        [self showHint:@"亲，你还没设置支付密码哦"];
        return;
    }
    DepositView1Controller * ctl = [[DepositView1Controller alloc]init];
    ctl.integral = _IntegralModel.rechargeIntegral;
    [self pushNewViewController:ctl];
    
    
}
-(void)actionchongzhi{
    if (!_usermodel.hasPayPassword) {
        [self showHint:@"亲，你还没设置支付密码哦"];
        return;
    }

    RechargeViewController * ctl = [[RechargeViewController alloc]init];
    
  ctl.rechargeIntegral =  _IntegralModel.rechargeIntegral;
    [self pushNewViewController:ctl];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
