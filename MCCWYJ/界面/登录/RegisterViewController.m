//
//  RegisterViewController.m
//  MCCWYJ
//
//  Created by MC on 16/5/4.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterTableViewCell.h"
#import "Register2TableViewCell.h"
#import "MCWebViewController.h"
@interface RegisterViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *_tableView;
    NSString * _phoneStr;
    NSString * _cvvStr;
    NSString * _pwd1Str;
    NSString * _pwd2Str;
    NSTimer *_gameTimer;
    NSDate   *_gameStartTime;

    UIButton * _yueduBtn;
    
}

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"注册";
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.bounces = NO;
    [self prepareFooer];
    // Do any additional setup after loading the view.
}

-(void)prepareFooer{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 150)];
    view.backgroundColor = [UIColor whiteColor];
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(40, 150 - 40 -20,Main_Screen_Width - 2* 40, 40)];
    [btn setTitle:@"确认" forState:0];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    btn.titleLabel.font = AppFont;
    btn.backgroundColor = AppRegTextCOLOR;//[UIColor redColor];
    [view addSubview:btn];
    ViewRadius(btn, 5);
    [btn addTarget:self action:@selector(okbtn) forControlEvents:UIControlEventTouchUpInside];
    _tableView.tableFooterView = view;
    
    _yueduBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
    [_yueduBtn setImage:[UIImage imageNamed:@"list_checkbox_normal"] forState:0];
    [_yueduBtn setImage:[UIImage imageNamed:@"list_checkbox_checked"] forState:UIControlStateSelected];
    [_yueduBtn addTarget:self action:@selector(action_yueduBtn) forControlEvents:UIControlEventTouchUpInside];

    [view addSubview:_yueduBtn];
    
    CGFloat x = 10 + 30 + 5;
    CGFloat y = 5;
    CGFloat w = [MCIucencyView heightforString:@"阅读并同意" andHeight:40 fontSize:14];
    CGFloat h = 40;
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.text = @"阅读并同意";
    lbl.font = AppFont;
    lbl.textColor = AppTextCOLOR;
    [view addSubview:lbl];
    
    x += w + 5;
    w = Main_Screen_Width - x;
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.text = @"《采点注册协议》";
    lbl.font = AppFont;
    lbl.textColor = AppCOLOR;
    [view addSubview:lbl];
    UIButton * btn1 = [[UIButton alloc]initWithFrame:CGRectMake(10 + 30 + 10, 0, Main_Screen_Width - 50, 50)];
    [btn1 addTarget:self action:@selector(actionBTn1) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn1];


    
    
    
    
}
-(void)action_yueduBtn{
    
    if (_yueduBtn.selected) {
        _yueduBtn.selected = NO;
    }
    else
    {
        _yueduBtn.selected = YES;

    }
}
-(void)actionBTn1{
    
    
    MCWebViewController * ctl = [[MCWebViewController alloc]init];
    ctl.menuagenturl = [NSString stringWithFormat:@"%@api/agreement/query.jhtml",AppURL];
    [self pushNewViewController:ctl];
    
    
}
-(void)shoujianpan{
    UITextField * text1 = (UITextField*)[self.view viewWithTag:210];
    UITextField * text2 = (UITextField*)[self.view viewWithTag:211];
    UITextField * text3 = (UITextField*)[self.view viewWithTag:212];
    UITextField * text4 = (UITextField*)[self.view viewWithTag:213];

    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    [text3 resignFirstResponder];
    [text4 resignFirstResponder];

    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self shoujianpan];
    return YES;
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 210) {
        _phoneStr = textField.text;
    }
    else if(textField.tag == 211){
        _cvvStr = textField.text;
        
    }
    else if(textField.tag == 212){
        _pwd1Str = textField.text;
        
    }else if(textField.tag == 213){
        _pwd2Str = textField.text;
        
    }
    //[_tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid1 = @"RegisterTableViewCell";
    static NSString *cellid2 = @"Register2TableViewCell";
    if (indexPath.row == 1) {
       
        Register2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid2];
        if (!cell) {
            cell = [[Register2TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid2];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textField.text = _cvvStr;
        cell.textField.delegate = self;
        cell.textField.tag = 211;
        cell.cvvBtn.tag = 220;
        [cell.cvvBtn addTarget:self action:@selector(actionYanzhen:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
  
    }
    else
    {
    RegisterTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
    if (!cell) {
        cell = [[RegisterTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid1];
        
    }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        if (indexPath.row == 0) {
            cell.textField.placeholder = @"请输入手机号码";
            cell.textField.text = _phoneStr;
            cell.textField.delegate = self;
            cell.textField.tag = 210;
            cell.textField.secureTextEntry = NO;

            return cell;

        }
        if (indexPath.row == 2) {
            cell.textField.placeholder = @"请输入密码";
            cell.textField.text = _pwd1Str;
            
            cell.textField.delegate = self;
            cell.textField.tag = 212;
            //设置密码输入
            cell.textField.secureTextEntry = YES;

            return cell;



        }

        if (indexPath.row == 3) {
            cell.textField.placeholder = @"请输入密码";
            cell.textField.text = _pwd2Str;
            cell.textField.delegate = self;
            cell.textField.tag = 213;
            //设置密码输入
            cell.textField.secureTextEntry = YES;

            return cell;


        }


        
        
        
    return cell;
    
    }
}
-(void)actionYanzhen:(UIButton*)btn{
    _gameStartTime=[NSDate date];
    [self shoujianpan];
    
    if (!_phoneStr.length) {
        [self showAllTextDialog:@"请输入手机号码"];
        return;
    }
    if (![CommonUtil isMobile:_phoneStr]) {
        [self showAllTextDialog:@"请正确输入手机号码"];
        return;
    }
    [self showLoading];
    NSDictionary * Parameterdic = @{
                                    @"phone":_phoneStr,
                                    @"type":@(0)
                                    };
    
[self.requestManager postWithUrl:@"api/user/genCode.json" refreshCache:NO params:Parameterdic IsNeedlogin:NO success:^(id resultDic) {
    [self stopshowLoading];
    NSLog(@"成功");
    NSLog(@"返回==%@",resultDic);
    [self showAllTextDialog:@"发送成功，请留意你的手机短信"];
    _gameTimer= [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];

} fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
    [self stopshowLoading];

    [self showAllTextDialog:description];
    
    NSLog(@"失败");
}];
    
    
    
}
// 时钟触发执行的方法
- (void)updateTimer:(NSTimer *)sender
{
    UIButton * btn = (UIButton*)[self.view viewWithTag:220];
    NSInteger deltaTime = [sender.fireDate timeIntervalSinceDate:_gameStartTime];
    
    NSString *text = [NSString stringWithFormat:@"%ld",60 - deltaTime];
    
    if (deltaTime>60) {
        [btn setTitle:@"重新发送" forState:UIControlStateNormal];
        [btn setUserInteractionEnabled:YES];
        [_gameTimer invalidate];
        return;
    }else
    {
        [btn setTitle:text forState:UIControlStateNormal];
        [btn setUserInteractionEnabled:NO];
        
    }
    
}
-(void)okbtn{
    
    [self shoujianpan];
    
    if (!_yueduBtn.selected) {
        [self showAllTextDialog:@"亲，你还没阅读采点注册协议哦"];
        return;
 
    }
    if (!_phoneStr.length) {
        [self showAllTextDialog:@"请输入手机号码"];
        return;
    }
    
    if (!_pwd1Str.length) {
        [self showAllTextDialog:@"请输入密码"];
        return;
    }
    if (!_pwd2Str.length) {
        [self showAllTextDialog:@"请输入确定密码"];
        return;
    }
    if (_pwd1Str.length < 6 || _pwd1Str.length > 30 ) {
        [self showAllTextDialog:@"请输入6-30位的密码"];
        return;
        
    }
    
    if (!_cvvStr.length) {
        [self showAllTextDialog:@"请输入验证码"];
        return;
    }
    if (![_pwd1Str isEqualToString:_pwd2Str]) {
        [self showAllTextDialog:@"两次输入密码不一致"];
        return;
    }
    [self showLoading];
    
    NSString *sign = [CommonUtil md5:_pwd1Str];

    
    NSDictionary * Parameterdic = @{
                                    @"mobile":_phoneStr,
                                    @"password":sign,
                                    @"Code":_cvvStr
                                    };
[self.requestManager postWithUrl:@"api/user/register.json" refreshCache:NO params:Parameterdic IsNeedlogin:NO success:^(id resultDic) {
    [self stopshowLoading];
    [self showAllTextDialog:@"注册成功"];
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [self.navigationController popViewControllerAnimated:YES];
//         [self.navigationController popToRootViewControllerAnimated:YES];
     });

} fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
    [self stopshowLoading];
    [self showAllTextDialog:description];
    NSLog(@"失败");

    
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
