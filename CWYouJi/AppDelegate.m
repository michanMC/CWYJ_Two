//
//  AppDelegate.m
//  CWYouJi
//
//  Created by MC on 15/10/27.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "IQKeyboardManager.h"
#import "APService.h"
#import <AVFoundation/AVFoundation.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import <AMapSearchKit/AMapSearchObj.h>
#import <AMapSearchKit/AMapCommonObj.h>
//#import <AMapSearchKit/AMapSearchKit.h>

//#import "AMapLocationManager.h"
@interface AppDelegate ()<MAMapViewDelegate,AMapSearchDelegate>
{
    AMapSearchAPI               * _bmksearch;
    BOOL _isxitongtongzhi;

}
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation AppDelegate
static void uncaughtExceptionHandler(NSException *exception) {
    NSLog(@"CRASH: %@", exception);
    NSLog(@"Stack Trace: %@", [exception callStackSymbols]);
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    requestManager = [NetworkManager instanceManager];
    requestManager.needSeesion = YES;
    
    // Override point for customization after application launch.
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    NSLog(@"=-=======测试");
    ViewController * root = [[ViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:root];
    self.window.rootViewController = nav;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    

    
    [MobClick startWithAppkey:@"56c4351667e58ef63e001c2d" reportPolicy:BATCH   channelId:@"App Store"];
    
    
    
    /*保存数据－－－－－－－－－－－－－－－－－begin*/
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSLog(@"==%@",[defaults objectForKey:@"xitong"]);
    
    //开启系统通知
    if(![defaults objectForKey:@"xitong"]||[[defaults objectForKey:@"xitong"] isEqualToString:@""]){
        _isxitongtongzhi = YES;
        
        if (launchOptions) {
            NSDictionary*userInfo = [launchOptions objectForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"];
            if(userInfo)
            {
                [self didReceiveRemoteNotification:userInfo];
            }
        }

    
    }
    else
    {
        _isxitongtongzhi = NO;
    }
   
    
    [self loadImg];
    //监听页面监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(yemianjisuan:) name:@"disyemianjisuanObjNotification" object:nil];
    //添加键盘控制
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    
    manager.enableAutoToolbar = YES;
    //地图341b28fd4e63a240fd2ef4feafc9b2aa
       // 开始持续定位
       // [self.locationManager startUpdatingLocation];
    //配置用户Key
    [MAMapServices sharedServices].apiKey = @"341b28fd4e63a240fd2ef4feafc9b2aa";
    
    _mapView = [[MAMapView alloc] init];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES; //YES 为打开定位，NO为关闭定位
    _mapView.userTrackingMode = MAUserTrackingModeNone;
    
    [self.window addSubview:_mapView];
    
    
   
    
   // AMapSearchServices
       // [AMapSearchServices sharedServices].apiKey = @"341b28fd4e63a240fd2ef4feafc9b2aa";
    
    _bmksearch = [[AMapSearchAPI alloc] initWithSearchKey:@"341b28fd4e63a240fd2ef4feafc9b2aa" Delegate:self];
    
    if (_isxitongtongzhi) {
    
    
    // Required
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
#else
    //categories 必须为nil
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
#endif
    // Required
    [APService setupWithOption:launchOptions];
    
    }
    
    
    
    
    [MCUser sharedInstance].launchOptions = launchOptions;

   // [defaults setValue:launchOptions forKey:@"launchOptions"];
    //强制让数据立刻保存

    
    

    
    
    
    
    
    
/**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个参数用于指定要使用哪些社交平台，以数组形式传入。第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    [ShareSDK registerApp:@"c888f29db88a"
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ),
                            @(SSDKPlatformSubTypeWechatTimeline)
                           
                            ]
                 onImport:^(SSDKPlatformType platformType) {
                     
                     switch (platformType)
                     {
                         case SSDKPlatformTypeWechat:
                             //                             [ShareSDKConnector connectWeChat:[WXApi class]];
                             [ShareSDKConnector connectWeChat:[WXApi class] delegate:self];
                             break;
                         case SSDKPlatformTypeQQ:
                             [ShareSDKConnector connectQQ:[QQApiInterface class]
                                        tencentOAuthClass:[TencentOAuth class]];
                             break;
                         case SSDKPlatformTypeSinaWeibo:
                             [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                             break;
                             
                         default:
                             break;
                     }
                     
                 }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
              
              switch (platformType)
              {
                  case SSDKPlatformTypeSinaWeibo:
                      //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                     

                      [appInfo SSDKSetupSinaWeiboByAppKey:@"255748822"
                                                appSecret:@"650697fb366b3b7884f33aa769a4e8e9"
                                              redirectUri:@"http://www.sharesdk.cn"
                                                 authType:SSDKAuthTypeBoth];
                      break;
                  case SSDKPlatformTypeWechat:
                      [appInfo SSDKSetupWeChatByAppId:@"wxd754731ce0fc1570"
                                            appSecret:@"c68d71a441c3e3e18956d3ba1cbeb07f"];
                      break;
                  case SSDKPlatformTypeQQ:
                      [appInfo SSDKSetupQQByAppId:@"1104987300"
                                           appKey:@"yhjLU8J5KhlGQcKb"
                                         authType:SSDKAuthTypeBoth];
                      
                      break;
                  case SSDKPlatformSubTypeQZone:
                      [appInfo SSDKSetupQQByAppId:@"1104987300"
                                           appKey:@"yhjLU8J5KhlGQcKb"
                                         authType:SSDKAuthTypeBoth];
                      
                      break;

                      
                      
                  case SSDKPlatformTypeDouBan:
                      [appInfo SSDKSetupDouBanByApiKey:@"02e2cbe5ca06de5908a863b15e149b0b"
                                                secret:@"9f1e7b4f71304f2f"
                                           redirectUri:@"http://www.sharesdk.cn"];
                      break;
                  default:
                      break;
              }
          }];
    

    
    return YES;
}
-(void)onResp:(BaseResp *)resp
{
    NSLog(@"The response of wechat.");
    
    
    
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    NSLog(@">>>>>>>>%@",url);
    NSString *urlStr = [url absoluteString];
    NSRange range = [urlStr rangeOfString:@"ciwei://"];//判断字符串是否包含
    if (range.length >0)//包含
    {
   // ciwei://app.cardm.net?travelId=4144

        urlStr = [urlStr stringByReplacingOccurrencesOfString:@"ciwei://" withString:@""];
        NSArray *paramArray = [urlStr componentsSeparatedByString:@"="];
        NSLog(@"paramArray: %@", paramArray);
        if (paramArray.count == 2) {//paramArray.count == 2
           NSString * travelId = paramArray[1];
            
            if ([travelId isEqualToString:@"china"]) {
                //发送通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectObjNotification" object:@"3"];
                [MCUser sharedInstance].tiaoStr =  @"china";

            }
            if ([travelId isEqualToString:@"world"]) {
                //发送通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectObjNotification" object:@"5"];
                [MCUser sharedInstance].tiaoStr =  @"world";

            }
else if([travelId integerValue] > 0)
{
   // kAlertMessage(@"跳");
    [MCUser sharedInstance].tiaoStr =  travelId;
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"oneyoujiNotification" object:travelId];
}
        }
    }
    else//不包含
    {
        
        
        
    }
//    UIAlertView *alertView = [[ UIAlertView alloc ] initWithTitle : nil message : @" 你唤醒了您的应用 " delegate : self cancelButtonTitle : @" 确定 " otherButtonTitles : nil , nil ];
//    
//    [alertView show ];
    
     return YES;
}
- ( BOOL )application:( UIApplication *)application handleOpenURL:( NSURL *)url {
    
//    if (url) {
//        
//        UIAlertView *alertView = [[ UIAlertView alloc ] initWithTitle : nil message : @" 你唤醒了您的应用 " delegate : self cancelButtonTitle : @" 确定 " otherButtonTitles : nil , nil ];
//        
//        [alertView show ];
//        
//    }
    
    return YES ;
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    //    [APService stopLogPageView:@"aa"];
    // Sent when the application is about to move from active to inactive state.
    // This can occur for certain types of temporary interruptions (such as an
    // incoming phone call or SMS message) or when the user quits the application
    // and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down
    // OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate
    // timers, and store enough application state information to restore your
    // application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called
    // instead of applicationWillTerminate: when the user quits.
    
    //[[UIApplication sharedApplication] setApplicationIconBadgeNumber:1];
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the
    // application was inactive. If the application was previously in the
    // background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if
    // appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    rootViewController.deviceTokenValueLabel.text =
    [NSString stringWithFormat:@"%@", deviceToken];
//    rootViewController.deviceTokenValueLabel.textColor =
    [UIColor colorWithRed:0.0 / 255
                    green:122.0 / 255
                     blue:255.0 / 255
                    alpha:1];
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject :deviceToken forKey:@"deviceToken"];
    
    //强制让数据立刻保存
    [defaults synchronize];

    [APService registerDeviceToken:deviceToken];
    // Required
    [APService setDebugMode];

}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
}

// Called when your app has been activated by the user selecting an action from
// a local notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forLocalNotification:(UILocalNotification *)notification
  completionHandler:(void (^)())completionHandler {
}

// Called when your app has been activated by the user selecting an action from
// a remote notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler {
}
#endif


//#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [APService handleRemoteNotification:userInfo];
    BOOL isActive;
    if (application.applicationState == UIApplicationStateActive) {
        isActive = TRUE;
    } else {
        isActive = FALSE;
    }
    NSDictionary *dict=[[NSMutableDictionary alloc] initWithDictionary:userInfo];
    
    [dict setValue: [[NSNumber alloc] initWithBool:isActive] forKey:@"isActive" ];
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:kJPFNetworkDidReceiveMessageNotification
                                                        //object:dict] ;//viper

    NSLog(@"收到通知:%@", [self logDic:userInfo]);
    if ([userInfo[@"type"] isEqualToString:@"systemNotice"]) {
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        [defaults setObject :@"1" forKey:@"systemNotice"];
        
        //强制让数据立刻保存
        [defaults synchronize];
    }

    [self didReceiveRemoteNotification:userInfo];
//    [rootViewController addNotificationCount];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
   
    [APService handleRemoteNotification:userInfo];
    NSLog(@"收到通知:%@", [self logDic:userInfo]);
    if ([userInfo[@"type"] isEqualToString:@"systemNotice"]) {
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        [defaults setObject :@"1" forKey:@"systemNotice"];
        
        //强制让数据立刻保存
        [defaults synchronize];
    }
//    [rootViewController addNotificationCount];
    [self didReceiveRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}






- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    
    
    
    //[APService showLocalNotificationAtFront:notification identifierKey:nil];
}

// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}
#pragma mark - MAMapViewDelegate 取出当前位置的坐标
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {

 AMapReGeocodeSearchRequest * regeo = [[AMapReGeocodeSearchRequest alloc]init];
        
        regeo.searchType = AMapSearchType_ReGeocode;

        regeo.location        = [AMapGeoPoint locationWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
        
        [MCUser sharedInstance].myLocation.la =userLocation.coordinate.latitude;
        [MCUser sharedInstance].myLocation.lo =userLocation.coordinate.longitude;
        regeo.requireExtension            = YES;
         regeo.radius = 1000;
        if (![MCUser sharedInstance].myLocation.city || ![MCUser sharedInstance].myLocation.city.length)
        [_bmksearch AMapReGoecodeSearch:regeo];
 
    }
}









/* 逆地理编码回调. */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{
    
    
    if (response.regeocode != nil) {
        MCUser * user = [MCUser sharedInstance];
        
        user.myLocation.city =response.regeocode.addressComponent.city;
        NSLog(@">>>>>>%@",user.myLocation.city);
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dingweiCounNotification" object:nil];
        
    }

    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"dingweiCounNotification" object:nil];
}
-(void)aa:(NSString*)messageStr{
    
    
    
    //发送本地推送
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate date]; //触发通知的时间
    notification.alertBody = messageStr;//[NSString stringWithFormat:@"%@:%@", messageStr];


    
    //#warning 去掉注释会显示[本地]开头, 方便在开发中区分是否为本地推送
   // notification.alertBody = [[NSString alloc] initWithFormat:@"你收到了一条讯息"];
    
//    notification.alertAction = NSLocalizedString(@"open", @"Open");
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.soundName = UILocalNotificationDefaultSoundName;
    
    NSDictionary *dict =[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:1],@"nfkey",nil];
    //推送时的声音,（若不设置的话系统推送时会无声音）
    notification.soundName=UILocalNotificationDefaultSoundName;
        [notification setUserInfo:dict];
    
   // [APService showLocalNotificationAtFront:notification identifierKey:nil];
    
    
    
    //1.获得音效文件的全路径
    
    NSURL *url=[[NSBundle mainBundle]URLForResource:@"sound.caf" withExtension:nil];
    
    //2.加载音效文件，创建音效ID（SoundID,一个ID对应一个音效文件）
    SystemSoundID soundID=0;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"shengyin"] isEqualToString:@"2"]) {//关声音
        
        if(![[NSUserDefaults standardUserDefaults] objectForKey:@"zhendong"])
        {//指正
            
            AudioServicesPlaySystemSound (nil);//声音
            AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);//震动
            
            
        }

        
        
        
    }else if(([[[NSUserDefaults standardUserDefaults] objectForKey:@"shengyin"] isEqualToString:@""] && [[[NSUserDefaults standardUserDefaults] objectForKey:@"zhendong"] isEqualToString:@""]) ||(![[NSUserDefaults standardUserDefaults] objectForKey:@"shengyin"] &&![[NSUserDefaults standardUserDefaults] objectForKey:@"zhendong"] )){//生意真懂
        
        
         //AudioServicesDisposeSystemSoundID(soundID);
        AudioServicesPlaySystemSound (soundID);//声音
        AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);//震动
        
        
        
    }else if(![[NSUserDefaults standardUserDefaults] objectForKey:@"shengyin"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"zhendong"])
    {//
        
        AudioServicesPlaySystemSound (soundID);//声音
        
        
    }
    
    
    
    
    
    
    
    
    //发送通知
   [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    notification = nil;
}
-(void)loadImg{
    
//    NSDictionary * Parameterdic = @{
//                                    @"device":@(2)
//                                    };
//    
    
    //[self showLoading:iszhuan AndText:nil];
   // NSString *paths = [[NSBundle mainBundle] pathForResource:@"qidong" ofType:@"png"];
    NSString *paths = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:@"/qidong.png"];
    
    
    NSString *filePath =[paths stringByAppendingPathComponent:@"qidong"];

   NSFileManager *fileManager = [NSFileManager defaultManager];
   BOOL result = [fileManager fileExistsAtPath:filePath];

    [requestManager requestWebWithParaWithURL:@"api/common/bootPicture.json" Parameter:nil IsLogin:NO Finish:^(NSDictionary *resultDic) {
        NSLog(@"返回==%@",resultDic);
        NSURL  *urlKey = [NSURL URLWithString:resultDic[@"object"][@"image"]];
        
        
        
        
        
        NSURLRequest *request = [NSURLRequest requestWithURL:urlKey];
        NSError *error = nil;
        NSData   *data =[NSURLConnection sendSynchronousRequest:request
                                              returningResponse:nil
                                                          error:&error];
        /* 下载的数据 */
        if (data != nil){
            NSLog(@"下载成功");
            //NSString *  path =[paths stringByAppendingPathComponent:@"w"];
            
            // filePath = [filePath stringByAppendingPathComponent:muiscStr];
            if ([data writeToFile:paths atomically:YES]) {
                
                
                NSLog(@"tup保存成功.");
                NSLog(@"%@",paths);
                
               // [_DelegateData.footView loadImage:muiscname];
            }
            else
            {
                NSLog(@"保存失败.");
            }
        } else {
            NSLog(@"%@", error);
        }
        
        

        
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        
        NSLog(@"失败");
    }];

    
}

-(void)page_view:(NSString*)type{
    
    
    
    NSDictionary * dic = @{
                           @"type":@([type integerValue])
                           };
    
    
    [requestManager requestWebWithParaWithURL:@"api/global/page_view.json" Parameter:dic IsLogin:NO Finish:^(NSDictionary *resultDic) {
        NSLog(@"返回==%@",resultDic);
        
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        
        NSLog(@"失败");
    }];

}
-(void)yemianjisuan:(NSNotification*)Notification{
    
    if (Notification.object) {
        NSString * ss = [NSString stringWithFormat:@"%@",Notification.object];
        [self page_view:ss];
    }
    
    
    
}
// 打印收到的apns信息
-(void)didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //didReceiveRemoteNotification
//    if (IOS8) {
//        
//    
//    [self application:[UIApplication sharedApplication] didReceiveRemoteNotification:userInfo];
//    
//    }
//    else
//    {
//         [self application:[UIApplication sharedApplication] didReceiveRemoteNotification:userInfo fetchCompletionHandler:nil];
//    }
//    
    
    
//    
//    
//    
//    UIRemoteNotificationType t = UIRemoteNotificationTypeNone|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound;
//    
//    
//    // Required
//#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
//        
//        t = UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert;
//       
//    } else {
//        //categories 必须为nil
//        t = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert;
//
//       
//    }
    
    
    
//#else
//    //categories 必须为nil
//    t = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert;
//   
//#endif
//    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:t];
//
//   // aa
//    
//    
//   // kAlertMessage(@"亲，你有一条客服小宝的留言");
//    
        NSError *parseError = nil;
        NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:userInfo
                                                            options:NSJSONWritingPrettyPrinted error:&parseError];
    
    
        NSString *str =  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"str == %@",str);

    

    

    
    
//    NSData *jsonData = [[userInfo valueForKey:@"content"] dataUsingEncoding:NSUTF8StringEncoding];
   NSError *err;
    
    
    NSDictionary *content = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
    
    
    if (content[@"travelId"]) {
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:kJPFNetworkDidReceiveMessageNotification object:content];
    }

    
    
    
    
    
//
    if (content[@"aps"]) {
        if (content[@"aps"][@"alert"]) {
            [self aa:content[@"aps"][@"alert"]];
        }    }

//    
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"apns.content", @"Apns content")
//                                                        message:str
//                                                       delegate:nil
//                                              cancelButtonTitle:NSLocalizedString(@"ok", @"OK")
//                                              otherButtonTitles:nil];
//        [alert show];
//    //
}

- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    NSString *content = [userInfo valueForKey:@"content"];
    NSDictionary *extras = [userInfo valueForKey:@"extras"];
    NSString *customizeField1 = [extras valueForKey:@"customizeField1"]; //自定义参数，key是自己定义的
    NSLog(@"2222");
    
}





@end
