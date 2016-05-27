//
//  DepositView1Controller.m
//  MCCWYJ
//
//  Created by MC on 16/5/27.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "DepositView1Controller.h"
#import "DepositTableViewCell.h"
#import "DepositViewController.h"
#import "DepositManageViewController.h"
#import "RechargeSuccViewController.h"
@interface DepositView1Controller ()<UITableViewDelegate,UITableViewDataSource>

{
    
    
    UITableView *_tableView;
    UIButton * _Depositbtn;
    UILabel * _subTitleLbl;
    UIButton * _allDepositbtn;
}

@end

@implementation DepositView1Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现到";
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [self prepareFooerView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"账号管理" style:UIBarButtonItemStylePlain target:self action:@selector(actionrightBar)];
    // Do any additional setup after loading the view.
}
-(void)actionrightBar{
    DepositManageViewController * ctl = [[DepositManageViewController alloc]init];
    [self pushNewViewController:ctl];
    
    
    
}
-(void)prepareFooerView{
    
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 200)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.tableFooterView = view;
    
    _subTitleLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, Main_Screen_Width/2, 20)];
    _subTitleLbl.textColor = AppTextCOLOR;
    _subTitleLbl.font = AppFont;
    _subTitleLbl.text = @"可提现采点:1332312采点";
    [view addSubview:_subTitleLbl];

    _allDepositbtn = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width/2, 10, 100, 20)];
    [_allDepositbtn setTitle:@"全部提现" forState:0];
    [_allDepositbtn setTitleColor:RGBCOLOR(232, 48, 17) forState:0];
    _allDepositbtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:_allDepositbtn];
    
    
    
    _Depositbtn= [[UIButton alloc]initWithFrame:CGRectMake(40, 100, Main_Screen_Width - 80, 35)];
    _Depositbtn.backgroundColor = AppCOLOR;
    ViewRadius(_Depositbtn, 5);
    [_Depositbtn setTitle:@"提现" forState:0];
    [_Depositbtn addTarget:self action:@selector(actiontixingbtn) forControlEvents:UIControlEventTouchUpInside];
    _Depositbtn.titleLabel.font  = AppFont;
    [_Depositbtn setTitleColor:[UIColor whiteColor] forState:0];
    [view addSubview:_Depositbtn];
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 100 + 35, Main_Screen_Width, 20)];
    lbl.text = @"每月最后一日开放提现";
    lbl.textColor = AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:13];
    lbl.textAlignment = NSTextAlignmentCenter;
    [view addSubview:lbl];


    
    
    
}
-(void)actiontixingbtn{
    RechargeSuccViewController * ctl = [[RechargeSuccViewController alloc]init];
    ctl.title = @"充值";
    ctl.titleStr = @"提现申请已提交";
    ctl.subtitleStr = @"预计到账时间:2016年1月23日 23:59";
    [self pushNewViewController:ctl];

    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    static NSString * cellid1 = @"DepositTableViewCell";
    DepositTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
    if (!cell) {
        cell = [[DepositTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid1];
        //        cell.selectionStyle =
    }
    if (indexPath.section == 0) {
        [cell prepareUI1];

    }
    else
    {
        [cell prepareUI2];
 
    }
    
    return cell;//[[UITableViewCell alloc]init];

    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        DepositViewController * ctl = [[DepositViewController alloc]init];
        [self pushNewViewController:ctl];

    }
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
