//
//  RechargeViewController.m
//  MCCWYJ
//
//  Created by MC on 16/5/27.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "RechargeViewController.h"
#import "RechargeTableViewCell.h"
#import "RechargeSuccViewController.h"
@interface RechargeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    
    UITableView *_tableView;
    UILabel *_caidianLbl;
    
}

@end

@implementation RechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值";
     _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [self prepareHeaderView];
    [self prepareFooerView];
    // Do any additional setup after loading the view.
}
-(void)prepareFooerView{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 100)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.tableFooterView = view;
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(40, 40, Main_Screen_Width - 80, 35)];
    btn.backgroundColor = AppCOLOR;
    ViewRadius(btn, 5);
    [btn setTitle:@"充值" forState:0];
    btn.titleLabel.font  = AppFont;
    [btn addTarget:self action:@selector(actionchongzhi) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    [view addSubview:btn];
    
    
    
    
}

-(void)prepareHeaderView{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 70)];
    view.backgroundColor = [UIColor whiteColor];
    _tableView.tableHeaderView = view;
    CGFloat x = 10;
    CGFloat y = 10;
    CGFloat w = 50;
    CGFloat h = w;
    UIImageView * imgview = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    imgview.image = [UIImage imageNamed:@"icon_money"];
    [view addSubview:imgview];
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(70, 0, 70, 70)];
    lbl.textColor = AppTextCOLOR;
    lbl.text = @"我的采点";
    lbl.font = [UIFont systemFontOfSize:16];
    [view addSubview:lbl];
    
    _caidianLbl = [[UILabel alloc]initWithFrame:CGRectMake(70 + 70 + 5, 0, Main_Screen_Width - 140 - 60, 70)];
    _caidianLbl.textColor = AppCOLOR;
    _caidianLbl.text = @"23333";
    _caidianLbl.font = [UIFont systemFontOfSize:16];
    [view addSubview:_caidianLbl];
    
    
    
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width - 10 - 70, 0, 70, 70)];
    lbl.textColor = [UIColor lightGrayColor];
    lbl.textAlignment = NSTextAlignmentRight;
    lbl.text = @"1采点=1元";
    lbl.font = [UIFont systemFontOfSize:14];
    [view addSubview:lbl];


    
    
    
    
    
    
}
-(void)actionchongzhi{
    RechargeSuccViewController * ctl = [[RechargeSuccViewController alloc]init];
    ctl.title = @"充值";
    ctl.titleStr = @"充值成功";
    ctl.subtitleStr = @"你已经成功充值233采点";
    [self pushNewViewController:ctl];
    
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }
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
    
    
    static NSString * cellid = @"RechargeTableViewCell";
    RechargeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[RechargeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section== 0) {
        if (indexPath.row == 0) {
            [cell prepareUI1];
            return cell;
        }
        if (indexPath.row == 1) {
            [cell prepareUI2];
            return cell;

            
            
        }
        if (indexPath.row == 2) {
            [cell prepareUI2];
            return cell;
            
        }

    }
    else
    {
        [cell prepareUI3];
        return cell;

    }
    
    
    
    
    return [[UITableViewCell alloc]init];
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
