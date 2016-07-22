//
//  AddDepositViewController.m
//  MCCWYJ
//
//  Created by MC on 16/5/27.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "AddDepositViewController.h"
#import "DepositTableViewCell.h"
@interface AddDepositViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

{
    
    UITableView *_tableView;

    NSInteger _cellindex1;
    
    
    
    NSString * _accountStr;
    NSString * _nameStr;

    
}

@end

@implementation AddDepositViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加新账号";
    _cellindex1 = 0;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = AppMCBgCOLOR;

    [self prepareFooerView];
// Do any additional setup after loading the view.
}
-(void)prepareFooerView{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 100)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.tableFooterView = view;
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(40, 40, Main_Screen_Width - 80, 35)];
    btn.backgroundColor = AppRegTextCOLOR;
    ViewRadius(btn, 5);
    [btn setTitle:@"保存" forState:0];
    btn.titleLabel.font  = AppFont;
    [btn addTarget:self action:@selector(actionBtn) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    [view addSubview:btn];
    
    
    
    
}
-(void)shoujianpan{
    UITextField * text1 = (UITextField*)[self.view viewWithTag:900];
    UITextField * text2 = (UITextField*)[self.view viewWithTag:901];
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self shoujianpan];
    return YES;
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 900) {
        _accountStr = textField.text;
    }
    else if(textField.tag == 901){
        _nameStr = textField.text;
        
    }
    //[_tableView reloadData];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view;
    view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 40)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake( 10, 0, Main_Screen_Width, 40)];
    lbl.textColor =AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:16];
    [view addSubview:lbl];
    
    if (section == 0) {
        
        
        lbl.text = @"请选择账号类型";
        
        
    }
    else
    {
        
        lbl.text = @"请填写相关信息";
        
        
    }
    
    return view;
    
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
        [cell prepareUI3];
        if (indexPath.row == 0) {
            cell.imgview.image = [UIImage imageNamed:@"支付宝"];
            cell.titleLbl.text = @"支付宝";
            
            cell.selectBtn.selected = _cellindex1== 0? YES:NO;
            
            return cell;

        }
        else
        {
            cell.imgview.image = [UIImage imageNamed:@"微信1"];
            cell.titleLbl.text = @"微信";
            cell.selectBtn.selected = _cellindex1== 1? YES:NO;

            return cell;

            
        }
    }
    else{
        [cell prepareUI4];
        cell.textField.delegate = self;

        if (indexPath.row == 0) {
           
            cell.titleLbl.text = @"账号:";
            cell.textField.placeholder = @"请输入提现账号";
            cell.textField.tag = 900;
            return cell;
            
        }
        else
        {

            cell.titleLbl.text = @"姓名:";
            cell.textField.placeholder = @"请输入真实姓名";
            cell.textField.tag = 901;

            

            return cell;
            
            
        }

    }
    
    return cell;
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        [self shoujianpan];
        _cellindex1 = indexPath.row ;
        [_tableView reloadData];
    }
    
    
}
-(void)actionBtn{
    [self shoujianpan];
    if (!_accountStr.length) {
        [self showHint:@"请输入提现账号"];
        return;
    }
    if (!_nameStr.length) {
        [self showHint:@"请输入真实姓名"];
        return;
    }

    
        [self showLoading];
    NSDictionary * dic = @{
                         @"type":@(_cellindex1),
                         @"name":_nameStr,
                         @"account":_accountStr
                           };
    [self.requestManager postWithUrl:@"api/paymentAccount/add.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
        [self showHint:@"添加成功"];
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didszhanghaoObjNotification" object:@""];
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didDepositObjNotification" object:@""];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.navigationController popViewControllerAnimated:YES];
        });

        
        
        
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
