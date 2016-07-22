//
//  MCLogisticsViewController.m
//  MCCWYJ
//
//  Created by MC on 16/7/15.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MCLogisticsViewController.h"
#import "MCLogisticsViewTableViewCell.h"
#import "MaterialViewController.h"
#import "MCScanViewController.h"
@interface MCLogisticsViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,MCScanViewDelegate>
{
    UITableView * _tableView;
    
    
    NSInteger _indexcell1;
    
    
    NSString *_courierCompanyStr;
    NSString *_courierNumberStr;

    
    
    
}

@end

@implementation MCLogisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = AppMCBgCOLOR;
    _indexcell1 = 0;
    self.title = @"填写物流信息";
     _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = AppMCBgCOLOR;
    [self.view addSubview:_tableView];
    [self prepareFooter];
    // Do any additional setup after loading the view.
}
-(void)prepareFooter{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 100)];
    view.backgroundColor = AppMCBgCOLOR;
    _tableView.tableFooterView = view;
    
    
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(40, 30, Main_Screen_Width - 80, 40)];
    [btn setTitle:@"确认发货" forState:0];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setBackgroundImage:[UIImage imageNamed:@"login_red_btn"] forState:0];
    [btn addTarget:self action:@selector(actionOK) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    
    
    
}
-(void)actionOK{
    if (!_orderId.length) {
        [self showHint:@"无效ID"];
        return;
    }
    UITextField * text = [self.view viewWithTag:800];
    [text resignFirstResponder];
    

    if (_indexcell1 == 0) {
        //快递
        if (!_courierCompanyStr.length) {
            [self showHint:@"请输入快递公司"];
            return;
        }
        if (!_courierNumberStr.length) {
            [self showHint:@"请输入快递单号"];
            return;
        }

    }
        
        [self showLoading];
    NSDictionary * dic = @{
                         @"orderNumber":_orderId,
                         @"deliveryType":@(_indexcell1),
                         @"courierCompany":_courierCompanyStr?_courierCompanyStr:@"",
                         @"courierNumber":_courierNumberStr?_courierNumberStr:@""
                           };
    [self.requestManager postWithUrl:@"api/buy/deliver.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
        [self showHint:@"发货成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ShoppingManView" object:@""];
            [self.navigationController popViewControllerAnimated:YES];
            
        });

        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
    }];

    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_indexcell1 == 1) {
        return 1;
    }
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (section ==0) {
        return @"请选择交付方式";
    }
    return @"请输入物流信息";
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * cellid = @"MCLogisticsViewTableViewCell";
    MCLogisticsViewTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[MCLogisticsViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;

    
    if (indexPath.section==0) {
        [cell prepareCell1];

        if (indexPath.row == 0) {
            cell.titleLbl.text = @"快递交付";
            if (_indexcell1 == 0) {
                cell.seleBtn.selected = YES;
            }
            else
            {
                cell.seleBtn.selected = NO;
 
            }
        }
        else if (indexPath.row == 1){
            cell.titleLbl.text = @"当面交付";
            if (_indexcell1 == 1) {
                cell.seleBtn.selected = YES;
            }
            else
            {
                cell.seleBtn.selected = NO;
                
            }


        }
        return cell;
    }
    if (indexPath.section==1) {
        if (indexPath.row == 0) {
            [cell prepareCell2];
            cell.titleLbl.text = @"快递公司";
            cell.titlesubLbl.text = _courierCompanyStr?_courierCompanyStr:@"填写快递公司";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;


        }
        else if (indexPath.row == 1){
            [cell prepareCell3];
            cell.titleLbl.text = @"快递单号";
            cell.text_Field.text = _courierNumberStr;
            cell.text_Field.delegate = self;
            cell.text_Field.tag = 800;
            [cell.erweiBtn addTarget:self action:@selector(actionerweiBtn) forControlEvents:UIControlEventTouchUpInside];
        }
        
        return cell;
    }
    return cell;
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1&&indexPath.row == 1) {
        return;
    }
    UITextField * text = [self.view viewWithTag:800];
    [text resignFirstResponder];

    
    if (indexPath.section == 0) {
        
            _indexcell1 = indexPath.row;
        [_tableView reloadData];
    }
    if (indexPath.section == 1&&indexPath.row ==0) {
        MaterialViewController * ctl = [[MaterialViewController alloc]init];
        ctl.delegate = self;
        [self pushNewViewController:ctl];
        
        
    }
    
    
}
-(void)actionerweiBtn{
    
    
    MCScanViewController * ctl = [[MCScanViewController alloc]init];
   
    ctl.teypIndex = @"1";
    ctl.delegate = self;
    [self pushNewViewController:ctl];

}
-(void)MCScanViewStr:(NSString *)ScanStr
{
    _courierNumberStr = ScanStr;
    [_tableView reloadData];

    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    _courierNumberStr = textField.text;
    
    
    
}
-(void)updateCompanyStr:(NSString*)str{
    
    _courierCompanyStr = str;
    [_tableView reloadData];
    
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
