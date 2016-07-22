

#import "BaseViewController.h"
#import "CLGifLoadView.h"
#import "UIViewController+HUD.h"
#import "MChomeViewController.h"
@interface BaseViewController ()
{
    CLGifLoadView * gifLoading;

}

@end

@implementation BaseViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
  //  self.navigationController.navigationBarHidden = YES;
    
}
- (void)pushNewViewController:(UIViewController *)newViewController {
    if (newViewController) {
    }
    [self.navigationController pushViewController:newViewController animated:YES];
}


-(void)stopshowLoading{
   // [self hideHud];
    [gifLoading setState:CLLoadStateFinish];

    
}
//-(void)hideHud{
//    
//}
- (void)showAllTextDialog:(NSString *)title
{
   [self showHint:title];
}
#pragma mark - Loading

- (void)showLoading
{
    // [self showHudInView:self.view hint:nil];
    gifLoading = [[CLGifLoadView alloc]initWithFrame:self.view.bounds];
    gifLoading.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:gifLoading];
    [gifLoading setState:CLLoadStateLoading];

}
- (void)showLoading:(BOOL)show AndText:(NSString *)text
{
    if (show) {
        gifLoading = [[CLGifLoadView alloc]initWithFrame:self.view.bounds];
        gifLoading.backgroundColor = [UIColor clearColor];
        
        [self.view addSubview:gifLoading];
        
        [gifLoading setState:CLLoadStateLoading];
        
    }
    else{
        [self stopshowLoading];
        
    }
}

- (void)showSuccess
{
    
}

- (void)showError
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.view.backgroundColor = AppMCBgCOLOR;
    _requestManager = [MCNetworkManager instanceManager];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:@"sessionId"]){
            NSDictionary * dic = @{
                                   @"user_session":[defaults objectForKey:@"sessionId"],

                                   };

[_requestManager configCommonHttpHeaders:dic];
    }
    
   

    
    if (IOS7) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self appColorNavigation];
   // [self ColorNavigation];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    

}
-(void)appColorNavigation{
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     RGBCOLOR(127, 125, 147), NSForegroundColorAttributeName,
                                                                     [UIFont fontWithName:@"CourierNewPSMT" size:20.0], NSFontAttributeName,
                                                                     nil]];
    self.navigationController.navigationBar.barTintColor =    [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];//RGBCOLOR(127, 125, 147);
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
//    if (![self isKindOfClass:[MChomeViewController class] ]) {
//        [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
//
//    }
    
 
}
-(void)ColorNavigation{
    
    self.navigationController.navigationBar.barTintColor =       [UIColor whiteColor];
    [self.navigationController.navigationBar setTintColor:RGBCOLOR(127, 125, 147)];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     RGBCOLOR(127, 125, 147), NSForegroundColorAttributeName,
                                                                     [UIFont fontWithName:@"CourierNewPSMT" size:20.0], NSFontAttributeName,
                                                                     nil]];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)toPopVC
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark-点击某个分享按钮
-(void)actionFenxian:(SSDKPlatformType)PlatformType PopToRoot:(BOOL)isPopToRoot SsDic:(NSMutableDictionary*)ssdic{
    
    if (!ssdic) {
        return;
    }
    /**
     * 在简单分享中，只要设置共有分享参数即可分享到任意的社交平台
     **/
    __weak BaseViewController *theController = self;
    // [self showLoadingView:YES];
    [self showLoading:YES AndText:nil];
    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    NSString * url = ssdic[@"url"];
    NSString * title = ssdic[@"title"];
    NSString * titlesub = ssdic[@"titlesub"];
    if (!titlesub) {
        titlesub = @"分享";
    }
    NSArray* imageArray = @[[UIImage imageNamed:@"ios-template-180"]];
    
    //    if (imageArray) {
    if (PlatformType == SSDKPlatformTypeSinaWeibo) {
        NSString * wei = [NSString stringWithFormat:@"%@ %@",title,url];
        
        
        [shareParams SSDKSetupShareParamsByText:wei
                                         images:imageArray
                                            url:[NSURL URLWithString:url]
                                          title:titlesub
                                           type:SSDKContentTypeText];
    }else
    {
        [shareParams SSDKSetupShareParamsByText:title
                                         images:imageArray
                                            url:[NSURL URLWithString:url]
                                          title:titlesub
                                           type:SSDKContentTypeWebPage];
    }
    
    //进行分享
    [ShareSDK share:PlatformType
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         
         [theController stopshowLoading];
         // [theController.tableView reloadData];
         
         switch (state) {
             case SSDKResponseStateSuccess:
             {
                 if (_isshare) {
                     [self StateSuccess];

                 }else
                 {
                    [ self showAllTextDialog:@"分享成功"];
                 }
                 //

//                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
//                                                                     message:nil
//                                                                    delegate:theController
//                                                           cancelButtonTitle:@"确定"
//                                                           otherButtonTitles:nil];
//                 if (isPopToRoot)
//                     alertView.tag = 770;
//                 
//                 [alertView show];
//                 
//                 
                 
                 
                 break;
             }
             case SSDKResponseStateFail:
             {
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                     message:[NSString stringWithFormat:@"%@", error]
                                                                    delegate:theController
                                                           cancelButtonTitle:@"确定"
                                                           otherButtonTitles:nil];
                 if (isPopToRoot)
                     
                     alertView.tag = 770;
                 
                 [alertView show];
                 break;
             }
             case SSDKResponseStateCancel:
             {
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                                                                     message:nil
                                                                    delegate:theController
                                                           cancelButtonTitle:@"确定"
                                                           otherButtonTitles:nil];
                 if (isPopToRoot)
                     
                     alertView.tag = 770;
                 
                 //[alertView show];
                 break;
             }
             default:
                 break;
         }
     }];
    // }
    
    
}
-(void)StateSuccess{
    
        [self showLoading];
    NSDictionary * dic = @{
                         
                           };
    [self.requestManager postWithUrl:@"api/task/share.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
        [ self showAllTextDialog:@"分享成功"];

        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
    }];

}
-(id)analysis:(NSString*)str{
    if (!str) {
        return str;
    }
    NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    
    id result = [NSJSONSerialization JSONObjectWithData:jsonData
                                                options:NSJSONReadingMutableContainers
                                                  error:&err];
    NSLog(@"result == ======%@",result);
    return result;
    
}
-(void)jumpGogin{
    
    LoginController * ctl = [[LoginController alloc]init];
    [self pushNewViewController:ctl];
    
    
}
#pragma mark-推送
-(void)prepareTuisong{
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidSetup:)
                          name:kJPFNetworkDidSetupNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidClose:)
                          name:kJPFNetworkDidCloseNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidRegister:)
                          name:kJPFNetworkDidRegisterNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidLogin:)
                          name:kJPFNetworkDidLoginNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidReceiveMessage:)
                          name:kJPFNetworkDidReceiveMessageNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(serviceError:)
                          name:kJPFServiceErrorNotification
                        object:nil];
    
}
- (void)networkDidSetup:(NSNotification *)notification {
    NSLog(@"已连接");
    
}

- (void)networkDidClose:(NSNotification *)notification {
    NSLog(@"未连接");
}

- (void)networkDidRegister:(NSNotification *)notification {
    NSLog(@"%@", [notification userInfo]);
    [[notification userInfo] valueForKey:@"RegistrationID"];
    
    NSLog(@"已注册");
}

- (void)networkDidLogin:(NSNotification *)notification {
    
    NSLog(@"已登录");
    
    if ([JPUSHService registrationID]) {
        NSLog(@"get RegistrationID === %@",[JPUSHService registrationID]);
        [self updateClientId:[JPUSHService registrationID]];
        
    }
}
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSLog(@"收到非naps");
    
    
}
- (void)serviceError:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSString *error = [userInfo valueForKey:@"error"];
    NSLog(@"%@", error);
}

-(void)updateClientId:(NSString*)RegistrationID{
    
    //        [self showLoading];
    NSDictionary * dic = @{
                           @"clientId":RegistrationID,
                           @"clientType":@(1)
                           };
    [self.requestManager postWithUrl:@"api/user/updateClientId.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        //        [self stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
        NSLog(@"推送id上传成功");
        NSLog(@"返回==%@",resultDic);
        
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        //        [self stopshowLoading];
        [self showAllTextDialog:description];
    }];
    
}

@end
