//
//  wangjiViewController.m
//  CWYouJi
//
//  Created by MC on 15/10/28.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "wangjiViewController.h"

@interface wangjiViewController ()
{
    UITextField * _phoneText;
    UITextField * _cvvText;
    UITextField * _pwdText;
    NSTimer *_gameTimer;
    NSDate   *_gameStartTime;
    
    UIButton * _cvvBtn;
    
}

@end

@implementation wangjiViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //[self.navigationController setToolbarHidden:YES animated:NO];
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    [self prepareUI];
    // Do any additional setup after loading the view.
}
-(void)prepareUI{
    CGFloat x = 10;
    CGFloat y = 64;
    CGFloat width = Main_Screen_Width - 20;
    CGFloat height = 44;
    _phoneText = [[UITextField alloc]initWithFrame:CGRectMake(x, y, width, height)];
    _phoneText.keyboardType = UIKeyboardTypeNumberPad;
    _phoneText.placeholder = @"请输入手机号码";
    _phoneText.font = AppFont;
    [self.view addSubview:_phoneText];
    y += height;
    height = 0.5;
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(x, y, width, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView];
    
    y +=height;
    height = 44;
    CGFloat cvvBtnY = y;
    _cvvText = [[UITextField alloc]initWithFrame:CGRectMake(x, y, width, height)];
    _cvvText.keyboardType = UIKeyboardTypeNumberPad;
    _cvvText.placeholder = @"验证码";
    _cvvText.font = AppFont;
    [self.view addSubview:_cvvText];
    y += height;
    height = 0.5;
    lineView = [[UIView alloc]initWithFrame:CGRectMake(x, y, width, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView];
    y +=height;
    height = 44;
    _pwdText = [[UITextField alloc]initWithFrame:CGRectMake(x, y, width, height)];
    _pwdText.keyboardType = UIKeyboardTypeNumberPad;
    _pwdText.placeholder = @"请输入新密码";
    _pwdText.font = AppFont;
    //设置密码输入
    _pwdText.secureTextEntry = YES;

    [self.view addSubview:_pwdText];
    y += height;
    height = 0.5;
    lineView = [[UIView alloc]initWithFrame:CGRectMake(x, y, width, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView];
    
    y += height  + 50;
    x = 40;
    width = Main_Screen_Width - 80;
    height = 40;
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
   // btn.tag = 102;
    //[btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"确认" forState:0];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setBackgroundImage:[UIImage imageNamed:@"login_btn_normal"] forState:0];
    [btn addTarget:self action:@selector(actionQurding) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    y = cvvBtnY;
    x = Main_Screen_Width - 20 - 70;
    width = 70;
    height = 44;
    _cvvBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    [_cvvBtn setTitle:@"获取验证码" forState:0];
    [_cvvBtn setTitleColor:[UIColor orangeColor] forState:0];
    _cvvBtn.titleLabel.font = AppFont;
    //_cvvBtn.backgroundColor = [UIColor yellowColor];
    [_cvvBtn addTarget:self action:@selector(cvvBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cvvBtn];
    x -= 10;
    y += 12;
    width = 0.5;
    height = 22;
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    lineview.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineview];
    

    
    
    
}
-(void)actionQurding{
    [_pwdText resignFirstResponder];
    [_cvvText resignFirstResponder];
    [_phoneText resignFirstResponder];

    
       if (!_phoneText.text.length) {
        kAlertMessage(@"请输入手机号码");
        return;
    }
    if (![CommonUtil isMobile:_phoneText.text]) {
        kAlertMessage(@"请正确输入手机号码");
        return;
    }
    if (!_cvvText.text.length) {
        kAlertMessage(@"请输入验证码");
        return;
    }

    if (!_pwdText.text.length) {
        kAlertMessage(@"请输入密码");
        return;
    }
    if(_pwdText.text.length < 6){
        kAlertMessage(@"请输入6位以上的密码");
        return;
    }
    
    
    NSDictionary * Parameterdic = @{
                                    @"mobile":_phoneText.text,
                                    @"password":_pwdText.text,
                                    @"code":_cvvText.text
                                    };
    
    
    [self showLoading:YES AndText:nil];
    [self.requestManager requestWebWithParaWithURL:@"api/user/changePassword.json" Parameter:Parameterdic IsLogin:NO Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        [self showAllTextDialog:@"修改成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.navigationController popViewControllerAnimated:YES];
        });

        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];
        
        NSLog(@"失败");
    }];
    

}
#pragma mark-点击获取验证码
-(void)cvvBtn{
    
    _gameStartTime=[NSDate date];
    [_phoneText resignFirstResponder];

    if (!_phoneText.text.length) {
        [self showAllTextDialog:@"请输入手机号码"];
        return;
    }
    if (![CommonUtil isMobile:_phoneText.text]) {
        [self showAllTextDialog:@"请正确输入手机号码"];
        return;
    }
    
    NSDictionary * Parameterdic = @{
                                    @"phone":_phoneText.text,
                                    @"type":@(1)
                                    };
    
    
    [self showLoading:YES AndText:nil];
    [self.requestManager requestWebWithParaWithURL:@"api/user/genCode.json" Parameter:Parameterdic IsLogin:NO Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        [self showAllTextDialog:@"发送成功，请留意你的手机短信"];
        _gameTimer= [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];
        
        NSLog(@"失败");
    }];

}
// 时钟触发执行的方法
- (void)updateTimer:(NSTimer *)sender
{
    
    NSInteger deltaTime = [sender.fireDate timeIntervalSinceDate:_gameStartTime];
    
    NSString *text = [NSString stringWithFormat:@"%ld",60 - deltaTime];
    
    if (deltaTime>60) {
        [_cvvBtn setTitle:@"重新发送" forState:UIControlStateNormal];
        [_cvvBtn setUserInteractionEnabled:YES];
        [_gameTimer invalidate];
        return;
    }else
    {
        [_cvvBtn setTitle:text forState:UIControlStateNormal];
        [_cvvBtn setUserInteractionEnabled:NO];
        
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
