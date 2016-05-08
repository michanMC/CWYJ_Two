//
//  AddressViewController.m
//  MCCWYJ
//
//  Created by MC on 16/5/4.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "AddressViewController.h"
#import "Address1TableViewCell.h"
#import "Address2TableViewCell.h"
#import "AddadderssViewController.h"
@interface AddressViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
    
    
}

@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"地址管理";
     _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    // Do any additional setup after loading the view.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    return 1;
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    return 50;
    return 10+20+10+40+10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellid = @"Address1TableViewCell";
    static NSString * cellid2 = @"Address2TableViewCell";

    if (indexPath.section == 0) {
        Address1TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[Address1TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
        
    }
    else
    {
        
        Address2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid2];
        if (!cell) {
            cell = [[Address2TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid2];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
cell.nameStr = @"michan";
        cell.phoneStr = @"13420065848";
        cell.addressStr = @"广东省广州市天河区唐安撸34号信息港qbc栋213213213室";
        if (indexPath.row == 0) {
            cell.ismoren = YES;
        }
        else
            cell.ismoren = NO;
        
        
        return cell;
  
        
        
        
    }
    
    return [[UITableViewCell alloc]init];
   
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     AddadderssViewController * ctl = [[AddadderssViewController alloc]init];
    if (indexPath.section == 0) {
        ctl.titleStr = @"地址管理";

    }
    else
    {
        ctl.titleStr = @"编辑收货地址";
  
    }
    
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
