//
//  ForgetViewController.m
//  MCCWYJ
//
//  Created by MC on 16/5/4.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "ForgetViewController.h"
#import "RegisterTableViewCell.h"
#import "Register2TableViewCell.h"


@interface ForgetViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    
    UITableView *_tableView;
    NSString * _phoneStr;
    NSString * _cvvStr;
    NSString * _pwd1Str;
    NSTimer *_gameTimer;
    NSDate   *_gameStartTime;

    
    
}

@end

@implementation ForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
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
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 100)];
    view.backgroundColor = [UIColor whiteColor];
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(40, 100 - 40 -20,Main_Screen_Width - 2* 40, 40)];
    [btn setTitle:@"确认" forState:0];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    btn.titleLabel.font = AppFont;
    btn.backgroundColor = AppRegTextCOLOR;//[UIColor redColor];
    [view addSubview:btn];
    ViewRadius(btn, 5);
    [btn addTarget:self action:@selector(okbtn) forControlEvents:UIControlEventTouchUpInside];
    _tableView.tableFooterView = view;
}
-(void)shoujianpan{
    UITextField * text1 = (UITextField*)[self.view viewWithTag:310];
    UITextField * text2 = (UITextField*)[self.view viewWithTag:311];
    UITextField * text3 = (UITextField*)[self.view viewWithTag:312];
    
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    [text3 resignFirstResponder];
//    [text4 resignFirstResponder];
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self shoujianpan];
    return YES;
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 310) {
        _phoneStr = textField.text;
    }
    else if(textField.tag == 311){
        _cvvStr = textField.text;
        
    }
    else if(textField.tag == 312){
        _pwd1Str = textField.text;
        
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
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
        cell.textField.tag = 311;
        cell.cvvBtn.tag = 320;
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
            cell.textField.tag = 310;
            cell.textField.secureTextEntry = NO;
            
            return cell;
            
        }
        if (indexPath.row == 2) {
            cell.textField.placeholder = @"请输入密码";
            cell.textField.text = _pwd1Str;
            
            cell.textField.delegate = self;
            cell.textField.tag = 312;
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
    NSDictionary * Parameterdic = @{
                                    @"phone":_phoneStr,
                                    @"type":@(1)
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
    UIButton * btn = (UIButton*)[self.view viewWithTag:320];
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
    if (!_phoneStr.length) {
        [self showAllTextDialog:@"请输入手机号码"];
        return;
    }
    
    if (!_pwd1Str.length) {
        [self showAllTextDialog:@"请输入密码"];
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
        [self showLoading];
    NSDictionary * Parameterdic = @{
                                    @"mobile":_phoneStr,
                                    @"password":_pwd1Str,
                                    @"Code":_cvvStr
                                    };
    [self.requestManager postWithUrl:@"api/user/changePassword.json" refreshCache:NO params:Parameterdic IsNeedlogin:NO success:^(id resultDic) {
        [self stopshowLoading];
        [self showAllTextDialog:@"修改成功"];
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
