//
//  DepositView1Controller.m
//  MCCWYJ
//
//  Created by MC on 16/5/27.
//  Copyright © 2016年 MC. All rights reserved.
//
#define NUMBERS @"0123456789.\n"

#import "DepositView1Controller.h"
#import "DepositTableViewCell.h"
#import "DepositViewController.h"
#import "DepositManageViewController.h"
#import "RechargeSuccViewController.h"
#import "LTAlertView.h"
@interface DepositView1Controller ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

{
    
    
    UIButton * _Depositbtn;
    UILabel * _subTitleLbl;
    UIButton * _allDepositbtn;
    
    
    
    NSMutableArray * _dataArray;
    NSString * _textStr;
}

@end

@implementation DepositView1Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现到";
    _dataArray = [NSMutableArray array];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = AppMCBgCOLOR;

    [self prepareFooerView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"账号管理" style:UIBarButtonItemStylePlain target:self action:@selector(actionrightBar)];
    [self loadData];
    
    
    
    
    // Do any additional setup after loading the view.
}
-(void)setSeleModel:(MyIntegralModel *)seleModel
{
    _seleModel = seleModel;
    [_tableView reloadData];
}
-(void)loadData{
    
        [self showLoading];
    NSDictionary * dic = @{
                         
                           };
    [self.requestManager postWithUrl:@"api/paymentAccount/list.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
        
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
    }];

    
}


-(void)actionrightBar{
    DepositManageViewController * ctl = [[DepositManageViewController alloc]init];

    ctl.delegate = self;
    [self pushNewViewController:ctl];
    
}
-(void)prepareFooerView{
    
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 200)];
    view.backgroundColor = AppMCBgCOLOR;//[UIColor groupTableViewBackgroundColor];
    _tableView.tableFooterView = view;
    
    _subTitleLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, Main_Screen_Width/2, 20)];
    _subTitleLbl.textColor = AppTextCOLOR;
    _subTitleLbl.font = AppFont;
    _subTitleLbl.text = [NSString stringWithFormat:@"可提现采点:%@采点",_integral];
    [view addSubview:_subTitleLbl];

    _allDepositbtn = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width/2, 10, 100, 20)];
    [_allDepositbtn setTitle:@"全部提现" forState:0];
    [_allDepositbtn setTitleColor:RGBCOLOR(232, 48, 17) forState:0];
    _allDepositbtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_allDepositbtn addTarget:self action:@selector(actionallDepositbtn) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_allDepositbtn];
    
    
    
    _Depositbtn= [[UIButton alloc]initWithFrame:CGRectMake(40, 100, Main_Screen_Width - 80, 40)];
    _Depositbtn.backgroundColor = AppRegTextCOLOR;
    ViewRadius(_Depositbtn, 5);
    [_Depositbtn setTitle:@"提现" forState:0];
    [_Depositbtn addTarget:self action:@selector(actiontixingbtn) forControlEvents:UIControlEventTouchUpInside];
    _Depositbtn.titleLabel.font  = AppFont;
    [_Depositbtn setTitleColor:[UIColor whiteColor] forState:0];
    [view addSubview:_Depositbtn];
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 100 + 40, Main_Screen_Width, 20)];
    lbl.text = @"每月最后一日开放提现";
    lbl.textColor = AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:13];
    lbl.textAlignment = NSTextAlignmentCenter;
    [view addSubview:lbl];
    
}
-(void)actionallDepositbtn{
    UITextField * text = [self.view viewWithTag:333];
    [text resignFirstResponder];
    text.text = _integral;
    _textStr  = _integral;
    
}
-(void)actiontixingbtn{
    
    [self shoujianopan];
    if (!_seleModel.id) {
        [self showHint:@"请设置提现到的账号"];
        return;
    }
    if (!_textStr.length) {
        [self showHint:@"请输入提现金额"];
        return;
    }
    if ([_integral floatValue] < [_textStr floatValue]) {
        [self showHint:@"超过了可提现采点数"];
        return;

    }
    _textStr = [NSString stringWithFormat:@"%.2f",[_textStr floatValue]];
    
    
//    BOOL ss=    [CommonUtil getMonthBeginAndEndWith];
//    if (!ss) {
//        [self showHint:@"每个月最后一天才能提现哦"];
//        return;
//
//    }

    __weak  DepositView1Controller* swakSelf = self;
    [LTAlertView showConfigBlock:^(LTAlertView *alertView) {
        alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
    } Title:@"提示" message:@"请输入支付密码" ButtonTitles:@[@"确定",@"取消"] OnTapBlock:^(LTAlertView* alert,NSInteger num) {
        
        if (num==0) {
            
            NSString* str = [alert textFieldAtIndex:0].text;
            NSLog(@"输入的文字是%@,点击了第%d个按钮",str,num);
            
            [swakSelf drawCash:str];
        }
        
    }];
    

    
}
-(void)drawCash:(NSString*)password {
    
    [self showLoading];
    NSString *sign = [CommonUtil md5:password];

    NSDictionary * dic = @{
                           @"password":sign,
                           @"integral":_textStr,
                           @"paymentAccountId":@([_seleModel.id integerValue])
                           };
    [self.requestManager postWithUrl:@"api/purse/drawCash.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
//        RechargeSuccViewController * ctl = [[RechargeSuccViewController alloc]init];
//        ctl.title = @"充值";
//        ctl.titleStr = @"提现申请已提交";
//        ctl.subtitleStr = @"预计到账时间:2016年1月23日 23:59";
//        [self pushNewViewController:ctl];
        [self showHint:@"提现申请已提交"];
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MyIntegralViewObjNotification" object:@""];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
            
        });

        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
    }];
    

    
    
    

    
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
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 0) {
        [cell prepareUI1];
        if (_seleModel) {
            
            cell.subtitleLbl.text = [NSString stringWithFormat:@"%@(%@)",_seleModel.name,_seleModel.account];
            cell.accessoryType = UITableViewCellAccessoryNone;

        }
        else
        {
            cell.subtitleLbl.text = @"";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        }
        
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;

        [cell prepareUI2];
        cell.textField.tag = 333;
        cell.textField.delegate = self;
        cell.textField.text = _textStr;
 
    }
    
    return cell;//[[UITableViewCell alloc]init];

    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        [self shoujianopan];
        DepositViewController * ctl = [[DepositViewController alloc]init];
        ctl.seleModel = _seleModel;
        ctl.delegate = self;
        [self pushNewViewController:ctl];

    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if([textField.text floatValue]<10){
        textField.text = @"10";
        
    }

//    _textStr = textField.text;
    NSString *str1 = [NSString stringWithFormat:@"%.2f",[textField.text floatValue]];
    
    CGFloat str = [textField.text floatValue];
    
    _textStr = str1;
    textField.text = _textStr;
    NSLog(@"textField = %@",textField.text);

}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSCharacterSet *cs;
    
    cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    
    if(!basicTest)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请输入数字"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        
        [alert show];
        return NO;
    }
    
    
    
    
    
    if ([string isEqualToString:@"\n"]){
        [textField resignFirstResponder];
        return NO;
    }
    NSString * aString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    
    if ([string isEqualToString:@"."]) {
        if([textField.text rangeOfString:@"."].location !=NSNotFound)//_roaldSearchText
        {
            
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"输入有误"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            
            [alert show];
            return NO;
            
        }
        else
        {
            
            
            
        }
    }
    
    
    NSLog(@"aString ===%.2f",[aString floatValue]);
//    if([aString floatValue]<10){
//        textField.text = @"10";
//        
//    }

    
    return YES;
    
    
}



-(void)shoujianopan{
    UITextField * text = [self.view viewWithTag:333];
    [text resignFirstResponder];
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
