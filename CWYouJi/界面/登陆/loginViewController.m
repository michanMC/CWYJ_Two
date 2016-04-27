//
//  loginViewController.m
//  CWYouJi
//
//  Created by MC on 15/10/28.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "loginViewController.h"
#import "zhuceViewController.h"
#import "wangjiViewController.h"
#import "REFrostedViewController.h"
#import "AppDelegate.h"
#import "DEMONavigationController.h"
#import "DEMOHomeViewController.h"
#import "DEMOMenuViewController.h"
#import "APService.h"
@interface loginViewController ()
{
    UIImageView * _bgImgView;
    UITextField * _nameText;
    UITextField * _pwdText;

    
}

@end

@implementation loginViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //[self.navigationController setToolbarHidden:YES animated:NO];
    //self.navigationController.navigationBarHidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUI];
    // Do any additional setup after loading the view.
}
-(void)prepareUI{
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = Main_Screen_Width;
    CGFloat height = Main_Screen_Height;
    
    _bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    _bgImgView.image =[UIImage imageNamed:@"login_bg_720"];
    _bgImgView.userInteractionEnabled = YES;
    [self.view addSubview:_bgImgView];
    
    x = 40;
    y  = Main_Screen_Height /2 - 40;
    width = Main_Screen_Width - 80;
    height = 40;
    UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    view1.backgroundColor = [UIColor blackColor];
    view1.alpha = .4;
    [_bgImgView addSubview:view1];
    ViewRadius(view1, 20);
    
    y += height +1;
    view1 = [[UIView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    view1.backgroundColor = [UIColor blackColor];
    view1.alpha = .4;
    [_bgImgView addSubview:view1];
    ViewRadius(view1, 20);
    x += 15;
    y = Main_Screen_Height /2 - 30;
    width = 20;
    height = 20;
    UIImageView * imgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    imgView1.image =[UIImage imageNamed:@"login_icon_user"];
    [_bgImgView addSubview:imgView1];
    y +=height + 10 + 1 + 10;
    imgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    imgView1.image =[UIImage imageNamed:@"login_icon_lock"];
    [_bgImgView addSubview:imgView1];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];

    x += 40;
    y = Main_Screen_Height /2 - 30;
    width = Main_Screen_Width - 80 - 15 - 60;
    height = 20;
    _nameText = [[UITextField alloc]initWithFrame:CGRectMake(x, y, width, height)];
    _nameText.keyboardType = UIKeyboardTypeNumberPad;
    _nameText.textColor = [UIColor whiteColor];
    _nameText.font = [UIFont systemFontOfSize:14];
    //_nameText.backgroundColor = [UIColor yellowColor];
    _nameText.text =  [defaults objectForKey:@"UserName"];
    [_bgImgView addSubview:_nameText];
    y +=height + 10 + 1 + 10;
    _pwdText = [[UITextField alloc]initWithFrame:CGRectMake(x, y, width, height)];
    _pwdText.textColor = [UIColor whiteColor];
    _pwdText.font = [UIFont systemFontOfSize:14];
    //设置再次输入时,是否清原来内容
    _pwdText.clearsOnBeginEditing = YES;
    //设置密码输入
    _pwdText.secureTextEntry = YES;
    _pwdText.text =  [defaults objectForKey:@"Pwd"];

   // _pwdText.backgroundColor = [UIColor yellowColor];
    [_bgImgView addSubview:_pwdText];
    x = 40;
    y +=20+15;
    width = 50;
    height = 20;
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    [btn setTitle:@"新用户" forState:0];
    btn.tag = 100;
    [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
   // [_bgImgView addSubview:btn];
    
    width = 70;
    x = Main_Screen_Width - 40 - width;
    btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    btn.tag = 101;
    [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"忘记密码?" forState:0];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_bgImgView addSubview:btn];
    
    //登陆
    x = 40;
    y += height + 20;
    width = Main_Screen_Width - 80;
    height = 40;
    btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    btn.tag = 102;
    [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"登陆" forState:0];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setBackgroundImage:[UIImage imageNamed:@"login_btn_normal"] forState:0];
    [_bgImgView addSubview:btn];
    
    y+=height+10;
    btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    [btn setTitle:@"新用户" forState:0];
    btn.tag = 100;
    [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor whiteColor];
    ViewRadius(btn, height/2);
    [btn setTitleColor:[UIColor orangeColor] forState:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_bgImgView addSubview:btn];

    
    
    

    width = 40;
    height = 40;
    x = (Main_Screen_Width - width)/2;
    y = Main_Screen_Height - 40 - 30;
    btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setBackgroundImage:[UIImage imageNamed:@"qq"] forState:0];
    btn.tag = 104;
    [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_bgImgView addSubview:btn];
    x -= (30 + 40);
    btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setBackgroundImage:[UIImage imageNamed:@"weibo"] forState:0];
    btn.tag = 103;
    [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_bgImgView addSubview:btn];
    x = (Main_Screen_Width - width)/2;
    x += (30 + 40);
    btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setBackgroundImage:[UIImage imageNamed:@"weixin"] forState:0];
    btn.tag = 105;
    [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_bgImgView addSubview:btn];
    
    
    width = 80;
    x = (Main_Screen_Width - width)/2;
    height = 160;
    y  = 50;
    UIImageView * imgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    imgView2.image= [UIImage imageNamed:@"login_logo"];
    [_bgImgView addSubview:imgView2];
    
    UIButton* _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 23, 35, 35)];
    [_backBtn setImage:[UIImage imageNamed:@"nav_icon_back"] forState:UIControlStateNormal];
    [self.view addSubview:_backBtn];
    [_backBtn addTarget:self action:@selector(actionBackBtn) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark-返回
-(void)actionBackBtn{
    [self lloginChenggong];
  //  [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark-点击按钮
-(void)actionBtn:(UIButton*)btn{
    
    if (btn.tag == 100) {//注册
        zhuceViewController * ctl = [[zhuceViewController alloc]init];
        [self pushNewViewController:ctl];
    }
    else if(btn.tag == 101){//忘记密码
        wangjiViewController * ctl = [[wangjiViewController alloc]init];
        [self pushNewViewController:ctl];
  
    }
    else if(btn.tag == 102){//登陆
        [self login];
    }
    else if(btn.tag == 103){//微博
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
                    [self showLoading:YES AndText:@"正在授权"];
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
    else if(btn.tag == 104){//qq
        
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
                    [self showLoading:YES AndText:@"正在授权"];
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
    else if(btn.tag == 105){//微信
        
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
                    [self showLoading:YES AndText:@"正在授权"];
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
            
            
            

//            NSLog(@">>%d",state);
//            NSLog(@"%@",user.nickname);
//            NSLog(@"%@",user.icon);
//            NSLog(@"%@",user.uid);
//            
//            NSDictionary * Parameterdic = @{
//                                            @"uname":user.uid,
//                                            @"nickname":user.nickname,
//                                            @"type":@(3),
//                                            @"raw":user.icon,
//                                            @"thumbnail":user.icon
//                                            };
//            
//            
//            [self socialLogin:Parameterdic];
            
        }];
        

        
    }
    
}
#pragma mark-第三方登录
-(void)socialLogin:(NSDictionary *)Parameterdic{
    
    
    
    
    [self showLoading:YES AndText:nil];
    [self.requestManager requestWebWithParaWithURL:@"api/user/socialLogin.json" Parameter:Parameterdic IsLogin:NO Finish:^(NSDictionary *resultDic) {
        [self hideHud];
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
        /*保存数据－－－－－－－－－－－－－－－－－end*/
        MCUser *_user = [MCUser sharedInstance];
        _user.userExpire = resultDic[@"expire"];
        _user.userSessionId = resultDic[@"object"][@"sessionId"];
        
        
        
        _user.userid = resultDic[@"object"][@"user"][@"id"];
        _user.userphone = resultDic[@"object"][@"user"][@"mobile"];
        _user.userNickname = resultDic[@"object"][@"user"][@"nickname"];
        _user.userSex = resultDic[@"object"][@"user"][@"sex"];
        _user.userThumbnail = [NSString stringWithFormat:@"%@%@",AppImgURL,resultDic[@"object"][@"user"][@"thumbnail"]];
        NSLog(@">>>>%@",[NSString stringWithFormat:@"%@%@",AppImgURL,resultDic[@"object"][@"user"][@"thumbnail"]]);
        
        [self lloginChenggong];

        
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];
        
        NSLog(@"失败");
    }];

    
    
    
    
    
    
    
    
}



#pragma mark-登陆
-(void)login{
    
    [_nameText resignFirstResponder];
    [_pwdText resignFirstResponder];
//    _nameText;
//    UITextField * _pwdText;
    if (!_nameText.text.length) {
        [self showAllTextDialog:@"请输入登录账户"];
        return;
    }
    if (!_pwdText.text.length) {
        [self showAllTextDialog:@"请输入密码"];
        return;

    }
    if (_pwdText.text.length < 6 || _pwdText.text.length > 30 ) {
        [self showAllTextDialog:@"请输入6-30位的密码"];
        return;
        
    }

    if (![CommonUtil isMobile:_nameText.text]) {
        [self showAllTextDialog:@"请正确输入手机号码"];
        return;

    }
//     [self lloginChenggong];
//    return;
    [self showLoading:YES AndText:nil];

    NSDictionary * Parameterdic = @{
                           @"mobile":_nameText.text,
                           @"password":_pwdText.text
                           };
    
    
    
    [self.requestManager requestWebWithParaWithURL:@"api/user/login.json" Parameter:Parameterdic IsLogin:NO Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"登录成功");
        NSLog(@"返回==%@",resultDic);
       // resultDic = resultDic[@"object"];
        
        /*保存数据－－－－－－－－－－－－－－－－－begin*/
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        
    
        [defaults setObject:_nameText.text forKey:@"UserName"];
        [defaults setObject :_pwdText.text forKey:@"Pwd"];
        [defaults setObject:@"1" forKey:@"isLogOut"];
        [defaults setObject :resultDic[@"object"][@"sessionId"] forKey:@"sessionId"];
        [defaults setObject :resultDic[@"object"][@"user"][@"nickname"] forKey:@"nickname"];
        NSLog(@"==%@",resultDic[@"object"][@"user"][@"nickname"]);
        
        
        [defaults setObject :resultDic[@"mobile"] forKey:@"mobile"];
        [defaults setObject :resultDic[@"object"][@"user"][@"id"] forKey:@"id"];
        [defaults setObject :resultDic[@"sign"] forKey:@"password"];
        [defaults setObject :[NSString stringWithFormat:@"%@",resultDic[@"object"][@"user"][@"raw"]] forKey:@"thumbnail"];

        
        
        
//        
//        [defaults setObject :resultDic[@"sessionId"] forKey:@"sessionId"];
//          [defaults setObject :resultDic[@"nickname"] forKey:@"nickname"];
//        [defaults setObject :resultDic[@"mobile"] forKey:@"mobile"];
//        [defaults setObject :resultDic[@"id"] forKey:@"id"];
//        [defaults setObject :resultDic[@"sign"] forKey:@"password"];
//
//        
        
        //强制让数据立刻保存
        [defaults synchronize];
        /*保存数据－－－－－－－－－－－－－－－－－end*/
        MCUser *_user = [MCUser sharedInstance];
        _user.userExpire = resultDic[@"user"][@"expire"];
        _user.userSessionId = resultDic[@"sessionId"];
        
        
        
        _user.userid = resultDic[@"user"][@"id"];
        _user.userphone = resultDic[@"user"][@"mobile"];
        _user.userNickname = resultDic[@"user"][@"nickname"];
        _user.userSex = resultDic[@"user"][@"sex"];
        _user.userThumbnail = [NSString stringWithFormat:@"%@%@",@"",resultDic[@"user"][@"raw"]];
        NSLog(@">>>>%@",[NSString stringWithFormat:@"%@%@",AppImgURL,resultDic[@"user"][@"thumbnail"]]);
        
//        [APService registerForRemoteNotificationTypes:]
//launchOptions
        // Required
        [self lloginChenggong];
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];

          NSLog(@"登录失败");
    }];
    
    
 
}
-(void)lloginChenggong{
    
    DEMONavigationController *navigationController = [[DEMONavigationController alloc] initWithRootViewController:[[DEMOHomeViewController alloc] init]];
    
    DEMOMenuViewController *menuController = [[DEMOMenuViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    
    REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:navigationController menuViewController:menuController];
    
    frostedViewController.direction = REFrostedViewControllerDirectionLeft;
    
    frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
    frostedViewController.panGestureEnabled = YES;
    frostedViewController.limitMenuViewSize = YES;

    frostedViewController.liveBlur = YES;
    frostedViewController.delegate = self;
    
    // Make it a root controller
    
    
    //
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController = frostedViewController;

    
    
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
