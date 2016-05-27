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
@interface MyIntegralViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView *_tableView;
    
    
    
}

@end

@implementation MyIntegralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的采点";
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    else
    {
        return 2;
  
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
//            cell.selectionStyle = 
        }
        [cell prepareUI1];
        
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
        //            cell.selectionStyle =
    }
    [cell prepareUI2];
    return cell;
}
    
    
    
    
    return [[UITableViewCell alloc]init];
}
-(void)actionmingxiBtn{
    CaidianDetailedViewController * ctl = [[CaidianDetailedViewController alloc]init];
    [self pushNewViewController:ctl];
    
    
}
#pragma mark-提现
-(void)actionTiXian{
    DepositView1Controller * ctl = [[DepositView1Controller alloc]init];
    [self pushNewViewController:ctl];
    
    
}
-(void)actionchongzhi{
    
    RechargeViewController * ctl = [[RechargeViewController alloc]init];
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
