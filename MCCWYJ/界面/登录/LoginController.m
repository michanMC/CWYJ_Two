//
//  LoginController.m
//  MCCWYJ
//
//  Created by MC on 16/4/29.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "LoginController.h"
#import "Log1TableViewCell.h"
#import "Log2TableViewCell.h"
#import "Log3TableViewCell.h"
#import "Log4TableViewCell.h"
#import "RegisterViewController.h"
#import "ForgetViewController.h"
@interface LoginController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView * _tableView;
    NSString * _phoneStr;//13798996333
    NSString * _pwdStr;
    


    
}

@end

@implementation LoginController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
 
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _phoneStr = [MCUserDefaults objectForKey:@"UserName"];
    _pwdStr = [MCUserDefaults objectForKey:@"Pwd"];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    _tableView.delegate = self;
    _tableView.dataSource =self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [self prepareHeadView];
    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 30, 30)];
//    backBtn.backgroundColor = [UIColor redColor];
    [backBtn setImage:[UIImage imageNamed:@"login_icon_close"] forState:0];
    [self.view addSubview:backBtn];
    [backBtn addTarget:self action:@selector(actionBack) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}
-(void)prepareHeadView{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Height, (Main_Screen_Height-50*MCHeightScale)/2 - 64*MCHeightScale )];
//    view.backgroundColor = [UIColor yellowColor];
    _tableView.tableHeaderView = view;
    UIImageView * imgview = [[UIImageView alloc]initWithFrame:CGRectMake((Main_Screen_Width-60) / 2, (view.mj_h - 60)/2, 60, 60)];
    imgview.image = [UIImage imageNamed:@"login_logo"];
//    imgview.backgroundColor = [UIColor redColor];
    [view addSubview:imgview];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 64*MCHeightScale;
    }
    if (indexPath.row == 1) {
        return 50*MCHeightScale;
    }
    if (indexPath.row == 2) {
        return (Main_Screen_Height-50*MCHeightScale)/2 - 44;
    }
    return 44;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellid1 = @"Login1Controller";
    static NSString * cellid2 = @"Login2Controller";
    static NSString * cellid3 = @"Login3Controller";
    static NSString * cellid4 = @"Login4Controller";

    if (indexPath.row == 0) {
        Log1TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
        if (!cell) {
            cell = [[Log1TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid1];

        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.weixinBtn.tag = 200;
        cell.weiboBtn.tag = 201;
        cell.QQBtn.tag = 202;
        [cell.weixinBtn addTarget:self action:@selector(Actionlogin:) forControlEvents:UIControlEventTouchUpInside];
        [cell.weiboBtn addTarget:self action:@selector(Actionlogin:) forControlEvents:UIControlEventTouchUpInside];
        [cell.QQBtn addTarget:self action:@selector(Actionlogin:) forControlEvents:UIControlEventTouchUpInside];

        
        return cell;
    }
    if (indexPath.row == 1) {
        Log2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid2];
        if (!cell) {
            cell = [[Log2TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid2];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }
    if (indexPath.row == 2) {
        Log3TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid3];
        if (!cell) {
            cell = [[Log3TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid3];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameTextField.tag = 100;
        cell.pwdTextField.tag = 101;
        cell.nameTextField.delegate = self;
        cell.pwdTextField.delegate = self;
        cell.nameTextField.text = _phoneStr;
        cell.pwdTextField.text = _pwdStr;
        [cell.loginBtn addTarget:self action:@selector(actionloginBtn) forControlEvents:UIControlEventTouchUpInside ];

        return cell;
    }
    if (indexPath.row == 3) {
        Log4TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid4];
        if (!cell) {
            cell = [[Log4TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid4];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.recBtn addTarget:self action:@selector(regBtn) forControlEvents:UIControlEventTouchUpInside];
        [cell.forgetBtn addTarget:self action:@selector(forgetBtn) forControlEvents:UIControlEventTouchUpInside];

        return cell;
    }



    return [[UITableViewCell alloc]init];
}
-(void)shoujianpan{
    UITextField * text1 = (UITextField*)[self.view viewWithTag:100];
    UITextField * text2 = (UITextField*)[self.view viewWithTag:101];
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
    if (textField.tag == 100) {
        _phoneStr = textField.text;
    }
    else if(textField.tag == 101){
        _pwdStr = textField.text;
        
    }
    //[_tableView reloadData];
}
#pragma mark-登录
-(void)actionloginBtn{
    [self shoujianpan];
    if (!_phoneStr.length) {
        [self showAllTextDialog:@"请输入手机号码"];
        return;
    }
    if (![CommonUtil isMobile:_phoneStr]) {
        [self showAllTextDialog:@"请正确输入手机号码"];
        return;
    }
    if (!_pwdStr.length) {
        [self showAllTextDialog:@"请输入密码"];
        return;
    }
    if (_pwdStr.length < 6 || _pwdStr.length > 30 ) {
        [self showAllTextDialog:@"请输入6-30位的密码"];
        return;
        
    }
    
    [self showLoading];
    
    NSDictionary * Parameterdic = @{
                                    @"mobile":_phoneStr,
                                    @"password":_pwdStr
                                    };
    
    
[self.requestManager postWithUrl:@"api/user/login.json" refreshCache:NO params:Parameterdic IsNeedlogin:NO success:^(id resultDic) {
    [self stopshowLoading];
    NSLog(@"登录成功");
    NSLog(@"返回==%@",resultDic);

    
    /*保存数据－－－－－－－－－－－－－－－－－begin*/
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    
    [defaults setObject:_phoneStr forKey:@"UserName"];
    [defaults setObject :_pwdStr forKey:@"Pwd"];
    
    
    [defaults setObject :resultDic[@"object"][@"sessionId"] forKey:@"sessionId"];
    
    [defaults setObject :resultDic[@"object"][@"user"][@"nickname"] forKey:@"nickname"];
    
    NSLog(@"==%@",resultDic[@"object"][@"user"][@"nickname"]);
    
    
    [defaults setObject :resultDic[@"mobile"] forKey:@"mobile"];
   
    [defaults setObject :resultDic[@"object"][@"user"][@"id"] forKey:@"id"];
    
    [defaults setObject :resultDic[@"sign"] forKey:@"password"];
    
    [defaults setObject :[NSString stringWithFormat:@"%@",resultDic[@"object"][@"user"][@"raw"]] forKey:@"thumbnail"];
    
    
    
    //强制让数据立刻保存
    [defaults synchronize];

    if (resultDic[@"object"][@"sessionId"])
        [[MCMApManager sharedInstance]Isdingwei:YES CtlView:self];

    [self.navigationController popViewControllerAnimated:YES];
    
    
    
    
    
} fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
    [self stopshowLoading];
    [self showAllTextDialog:description];
    
    NSLog(@"登录失败");
}];
    
    
    
}
#pragma mark-第三方登录
-(void)Actionlogin:(UIButton*)btn{
    
    NSLog(@"%zd",btn.tag);
    
    if (btn.tag == 201) {
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        
        SSDKUserQueryConditional * conditional;
        
        if (![[defaults objectForKey:@"uid"] length]|| ![defaults objectForKey:@"uid"]) {
            conditional = nil;
        }
        else
        {
            conditional = [SSDKUserQueryConditional userQueryConditionalByUserId:[defaults objectForKey:@"uid"]];
        }
        
        
        [ShareSDK getUserInfo:SSDKPlatformTypeSinaWeibo conditional:conditional onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
            
            NSLog(@">>%d",state);
            
            switch (state) {
                case SSDKResponseStateBegin://开始
                {
                    [self showAllTextDialog:@"正在授权"];
                }
                    break;
                case SSDKResponseStateSuccess://成功
                {
                    [self stopshowLoading];
                    NSLog(@"%@",user.nickname);
                    NSLog(@"%@",user.icon);
                    NSLog(@"%@",user.uid);
                    NSLog(@"%@",user.rawData);
                    
                    NSDictionary * Parameterdic = @{
                                                    @"uname":user.uid,
                                                    @"nickname":user.nickname,
                                                    @"type":@(3),
                                                    @"raw":user.icon,
                                                    @"thumbnail":user.icon
                                                    };
                    
                    
                    [self socialLogin:Parameterdic];
                    
                }
                    break;
                case SSDKResponseStateFail://失败
                {
                    [self stopshowLoading];
                    [self showAllTextDialog:@"登录失败"];
                }
                    break;
                case SSDKResponseStateCancel://取消
                {
                    [self stopshowLoading];
                    [self showAllTextDialog:@"取消登录"];
                }
                    break;
                    
                default:
                    break;
            }
            
            
            
            
        }];
    }
    else if(btn.tag == 200){
        //微信
        
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        
        SSDKUserQueryConditional * conditional;
        if (![[defaults objectForKey:@"uid"] length]|| ![defaults objectForKey:@"uid"]) {
            conditional = nil;
        }
        else
        {
            conditional = [SSDKUserQueryConditional userQueryConditionalByUserId:[defaults objectForKey:@"uid"]];
        }
        
        
        
        [ShareSDK getUserInfo:SSDKPlatformTypeWechat conditional:conditional onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
            NSLog(@">>%d",state);
            NSLog(@"%@",user.nickname);
            NSLog(@"%@",user.icon);
            NSLog(@"%@",user.uid);
            switch (state) {
                case SSDKResponseStateBegin://开始
                {
                    [self showAllTextDialog:@"正在授权"];
                }
                    break;
                case SSDKResponseStateSuccess://成功
                {
                    [self stopshowLoading];
                    NSLog(@"%@",user.nickname);
                    NSLog(@"%@",user.icon);
                    NSLog(@"%@",user.uid);
                    
                    NSDictionary * Parameterdic = @{
                                                    @"uname":user.uid,
                                                    @"nickname":user.nickname,
                                                    @"type":@(1),
                                                    @"raw":user.icon,
                                                    @"thumbnail":user.icon
                                                    };
                    
                    
                    [self socialLogin:Parameterdic];
                    
                }
                    break;
                case SSDKResponseStateFail://失败
                {
                    [self stopshowLoading];
                    [self showAllTextDialog:@"登录失败"];
                }
                    break;
                case SSDKResponseStateCancel://取消
                {
                    [self stopshowLoading];
                    [self showAllTextDialog:@"取消登录"];
                }
                    break;
                    
                default:
                    break;
            }
            
            
        }];
        

    }
    else if(btn.tag == 202){
        //QQ
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        
        SSDKUserQueryConditional * conditional;
        if (![[defaults objectForKey:@"uid"] length]|| ![defaults objectForKey:@"uid"]) {
            conditional = nil;
        }
        else
        {
            conditional = [SSDKUserQueryConditional userQueryConditionalByUserId:[defaults objectForKey:@"uid"]];
        }
        
        [ShareSDK getUserInfo:SSDKPlatformTypeQQ conditional:conditional onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
            
            NSLog(@">>%d",state);
            NSLog(@"%@",user.nickname);
            NSLog(@"%@",user.icon);
            NSLog(@"%@",user.uid);
            switch (state) {
                case SSDKResponseStateBegin://开始
                {
                    [self showAllTextDialog:@"正在授权"];
//                    [self showLoading:YES AndText:@"正在授权"];
                }
                    break;
                case SSDKResponseStateSuccess://成功
                {
                    [self stopshowLoading];
                    NSLog(@"%@",user.nickname);
                    NSLog(@"%@",user.icon);
                    NSLog(@"%@",user.uid);
                    NSLog(@"%@",user.rawData);
                    
                    NSDictionary * Parameterdic = @{
                                                    @"uname":user.uid,
                                                    @"nickname":user.nickname,
                                                    @"type":@(2),
                                                    @"raw":user.icon,
                                                    @"thumbnail":user.icon
                                                    };
                    
                    
                    [self socialLogin:Parameterdic];
                    
                }
                    break;
                case SSDKResponseStateFail://失败
                {
                    [self stopshowLoading];
                    [self showAllTextDialog:@"登录失败"];
                }
                    break;
                case SSDKResponseStateCancel://取消
                {
                    [self stopshowLoading];
                    [self showAllTextDialog:@"取消登录"];
                }
                    break;
                    
                default:
                    break;
            }
            
            
            
            
            
            
            //            NSDictionary * Parameterdic = @{
            //                                            @"uname":user.uid,
            //                                            @"nickname":user.nickname,
            //                                            @"type":@(3),
            //                                            @"raw":user.icon,
            //                                            @"thumbnail":user.icon
            //                                            };
            
            
            // [self socialLogin:Parameterdic];
            
        }];
        

        
    }
    
    
    
}
#pragma mark-第三方登录
-(void)socialLogin:(NSDictionary *)Parameterdic{
    
    [self showLoading];
    [self.requestManager postWithUrl:@"api/user/socialLogin.json" refreshCache:NO params:Parameterdic IsNeedlogin:NO success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        /*保存数据－－－－－－－－－－－－－－－－－begin*/
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        [defaults setObject:Parameterdic[@"uname"] forKey:@"uid"];//第三方的id
        [defaults setObject:@"1" forKey:@"isLogOut"];//是否登录状态
        [defaults setObject:[Parameterdic objectForKey:@"type"] forKey:@"type"];//第三方登录的key
        [defaults setObject :resultDic[@"object"][@"sessionId"] forKey:@"sessionId"];
        [defaults setObject :resultDic[@"object"][@"user"][@"nickname"] forKey:@"nickname"];
        NSLog(@"==%@",resultDic[@"object"][@"user"][@"nickname"]);
        
        
        [defaults setObject :resultDic[@"mobile"] forKey:@"mobile"];
        [defaults setObject :resultDic[@"object"][@"user"][@"id"] forKey:@"id"];
        [defaults setObject :resultDic[@"sign"] forKey:@"password"];
        [defaults setObject :[NSString stringWithFormat:@"%@",resultDic[@"object"][@"user"][@"raw"]] forKey:@"thumbnail"];
        
        
        
        //强制让数据立刻保存
        [defaults synchronize];
        
        if (resultDic[@"object"][@"sessionId"])
            [[MCMApManager sharedInstance]Isdingwei:YES CtlView:self];
        
        [self.navigationController popViewControllerAnimated:YES];
        


        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
        NSLog(@"失败");
    }];
    
    
    

}
#pragma mark-注册
-(void)regBtn{
    RegisterViewController * ctl = [[RegisterViewController alloc]init];
    [self pushNewViewController:ctl];
}
-(void)forgetBtn{
    
    ForgetViewController * ctl = [[ForgetViewController alloc]init];
    [self pushNewViewController:ctl];

    
}
-(void)actionBack{
    [self.navigationController popViewControllerAnimated:YES];
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
