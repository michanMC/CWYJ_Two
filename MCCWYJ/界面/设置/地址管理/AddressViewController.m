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
    NSMutableArray *_dataArray;
    
}

@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"地址管理";
    _dataArray = [NSMutableArray array];
    //监听数据的刷新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loaddata2) name:@"didaddersObjNotification" object:nil];
     _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = AppMCBgCOLOR;

    [self loaddata];
    // Do any additional setup after loading the view.
}
-(void)loaddata2{
    [_dataArray removeAllObjects];
    [self loaddata];
}
-(void)loaddata{
    
        [self showLoading];
    NSDictionary * dic = @{
                         
                           };
    [self.requestManager postWithUrl:@"api/logistics_address/list.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
        for (NSDictionary * dic in resultDic[@"object"]) {
            AddressModel *model = [AddressModel mj_objectWithKeyValues:dic];
            model.MCdescription = dic[@"description"];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
    }];

    
    
    
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    return 1;
    return _dataArray.count;
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
    return 10+20+10+40+18;
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
        
        if (_dataArray.count > indexPath.row) {
            AddressModel * modle = _dataArray[indexPath.row];
            
            cell.nameStr =modle.name;// @"michan";
            cell.phoneStr = modle.mobile;//@"13420065848";
            cell.addressStr = [NSString stringWithFormat:@"%@%@%@%@",modle.province,modle.city,modle.region,modle.MCdescription ];//@"广东省广州市天河区唐安撸34号信息港qbc栋213213213室";
//            if (indexPath.row == 0) {
                cell.ismoren = [modle.status boolValue];
//            }
//            else
//                cell.ismoren = NO;
            cell.deteBtn.tag = indexPath.row + 500;
                cell.deteBtn.hidden = _isSele;
            [cell.deteBtn addTarget:self action:@selector(ActiondeteBtn:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
        
        return cell;
  
        
        
        
    }
    
    return [[UITableViewCell alloc]init];
   
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     AddadderssViewController * ctl = [[AddadderssViewController alloc]init];
    if (indexPath.section == 0) {
        ctl.titleStr = @"地址管理";
        [self pushNewViewController:ctl];


    }
    else
    {
        if (_dataArray.count > indexPath.row) {
            AddressModel * modle = _dataArray[indexPath.row];

            if (!_isSele) {
                
        ctl.titleStr = @"编辑收货地址";
            ctl.model = modle;
            [self pushNewViewController:ctl];
            }
            else
            {
                if (_degate) {
                    
                    [_degate seleAddressModel:modle];
                }
                [self.navigationController popViewControllerAnimated:YES];
                
                
            }

        }
  
    }
    

    
}
-(void)ActiondeteBtn:(UIButton*)btn{
    NSInteger indetag = btn.tag - 500;
    AddressModel * modle = _dataArray[indetag];

        [self showLoading];
    NSDictionary * dic = @{
                         @"ids":modle.id
                           };
    [self.requestManager postWithUrl:@"api/logistics_address/delete.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
        [self showHint:@"删除成功"];
        
        [self loaddata2];
        
        
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
    }];

    
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
