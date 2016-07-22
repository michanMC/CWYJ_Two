//
//  AppDelegate.m
//  MCCWYJ
//
//  Created by MC on 16/4/28.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "IQKeyboardManager.h"
#import <MAMapKit/MAMapKit.h>
#import "AppDelegate+EaseMob.h"
#import "PromotionPage.h"


#define EaseMobAppKey @"ifenguo#fenguoim"

@interface AppDelegate ()<WXApiDelegate>
{
    
    
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//环信：ifenguo fenguoim
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    ViewController * root = [[ViewController alloc]init];
    
    self.window.rootViewController = root;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
   // _requestManager = [MCNetworkManager instanceManager];
    //[self loadImg];
    


    
    
    
    _connectionState = EMConnectionConnected;
#warning 初始化环信SDK，详细内容在AppDelegate+EaseMob.m 文件中
#warning SDK注册 APNS文件的名字, 需要与后台上传证书时的名字一一对应
    NSString *apnsCertName = nil;
#if DEBUG
    apnsCertName = @"caidian_dev";
#else
    apnsCertName = @"caidian_dev";
#endif
    
    
    NSString *appkey = EaseMobAppKey;
    
    [self easemobApplication:application
didFinishLaunchingWithOptions:launchOptions
                      appkey:appkey
                apnsCertName:apnsCertName
                 otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
    
    [self MCJPUSHService:launchOptions];
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    
    //添加键盘控制
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    
    manager.enableAutoToolbar = YES;
//友盟
   [MobClick startWithAppkey:@"56c4351667e58ef63e001c2d" reportPolicy:BATCH   channelId:@"App Store"];
    
    //微信注册
    [WXApi registerApp:@"wx4b6f3cac7fa9e6f2" withDescription:@"ciwei"];

    [self prepareShareSDK];
//    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//    [MobClick setAppVersion:version];
    application.applicationIconBadgeNumber = 0;

    return YES;
}
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    //[userInfo mj_JSONString]
    [self JPUSHServiceman:userInfo[@"extras"]];

    NSLog(@"userInfo232132132132 ==%@",userInfo);
    
//    NSString *content = [userInfo valueForKey:@"content"];
//    NSDictionary *extras = [userInfo valueForKey:@"extras"];
//    NSString *customizeField1 = [extras valueForKey:@"customizeField1"]; //服务端传递的Extras附加字段，key是自己定义的
    
}
-(void)prepareShareSDK{
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
                      [appInfo SSDKSetupWeChatByAppId:@"wx4b6f3cac7fa9e6f2"
                                            appSecret:@"52544894801db9f1e68c9306bfbbef3d"];
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
    

}
#pragma mark-极光
-(void)MCJPUSHService:(NSDictionary*)launchOptions{
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
 
    
    
    
}
-(BOOL)Alipay:(NSURL *)url{
    /*
     9000 订单支付成功
     8000 正在处理中
     4000 订单支付失败
     6001 用户中途取消
     6002 网络连接出错
     */
//    if ([url.host isEqualToString:@"safepay"]) {
//        //这个是进程KILL掉之后也会调用，这个只是第一次授权回调，同时也会返回支付信息
//        [[AlipaySDK defaultService]processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
//            [self AlipayWithResutl:resultDic];
//        }];
//        //跳转支付宝钱包进行支付，处理支付结果，这个只是辅佐订单支付结果回调
//        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//            [self AlipayWithResutl:resultDic];
//        }];
//        
//    }else if ([url.host isEqualToString:@"platformapi"]){
//        //授权返回码
//        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
//            [self AlipayWithResutl:resultDic];
//        }];
//    }
    
    return YES;
    
}
-(void)onResp:(BaseResp *)resp
{
    NSLog(@"The response of wechat.");
    if ([resp isKindOfClass:[PayResp class]])
    {
        PayResp *response = (PayResp *)resp;
        NSLog(@">>>>>>%@",response.returnKey);
        NSLog(@">>>>>>%d",response.type);
        NSLog(@">>>>>>%d",response.errCode);
        
        switch (response.errCode) {
            case WXSuccess: {
                //发送通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WXPaymentObjNotification" object:@"success"];
                //发送通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WXRechargeViewObjNotification" object:@"success"];

                break;
            }
                
            case WXErrCodeCommon: {
                NSLog(@"普通错误类型");
                //发送通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WXPaymentObjNotification" object:@"Fail"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WXRechargeViewObjNotification" object:@"Fail"];
                
                
                break;
            }
            case WXErrCodeUserCancel: {
                NSLog(@"用户点击取消并返回");
                //发送通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WXPaymentObjNotification" object:@"Cancel"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WXRechargeViewObjNotification" object:@"Cancel"];

                
                             break;
            }
            case WXErrCodeSentFail: {
                NSLog(@"发送失败");
                //发送通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WXPaymentObjNotification" object:@"Fail"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WXRechargeViewObjNotification" object:@"Fail"];

                
                break;
            }
            case WXErrCodeAuthDeny: {
                NSLog(@"授权失败");
                //发送通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WXPaymentObjNotification" object:@"Fail"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WXRechargeViewObjNotification" object:@"Fail"];

                

                break;
            }
            case WXErrCodeUnsupport: {
                NSLog(@"微信不支持");
                
                //发送通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WXPaymentObjNotification" object:@"Fail"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WXRechargeViewObjNotification" object:@"Fail"];

                break;
            }
                
                
            default: {
                
                //发送通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WXPaymentObjNotification" object:@"Fail"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WXRechargeViewObjNotification" object:@"Fail"];

                
                break;
            }
        }
    }

    
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    application.applicationIconBadgeNumber = 0;

}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"收到通知1:%@", [userInfo mj_JSONString]);
    [self JPUSHServiceman:[userInfo mj_JSONString]];

    application.applicationIconBadgeNumber = 0;

}
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    application.applicationIconBadgeNumber = 0;

    [JPUSHService handleRemoteNotification:userInfo];
    
    NSLog(@"收到通知2:%@", [userInfo mj_JSONString]);
    [self JPUSHServiceman:[userInfo mj_JSONString]];
    completionHandler(UIBackgroundFetchResultNewData);
}
- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    NSLog(@"?");
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}


#pragma mark-推送处理
-(void)JPUSHServiceman:(id)str{
    id rec;
    if ([str isKindOfClass:[NSString class]]) {
        rec = [self analysis:str];

    }
    if ([str isKindOfClass:[NSDictionary class]]) {
        rec = str;
    }
    homeYJModel * modle =[homeYJModel mj_objectWithKeyValues:rec];
    if ([modle.pushType isEqualToString:@"travel"]) {
        NSLog(@"游记");
       

       NSString * _travelArrayStr = [MCUserDefaults objectForKey:@"travelArrayID"];
        NSMutableArray * _travelArrayID = [NSMutableArray array];
        
        if (_travelArrayStr) {
         NSArray * arra   = [_travelArrayStr componentsSeparatedByString:@","];
            
            for (NSString * str in arra) {
                [_travelArrayID addObject:str];
            }
        }
        else
        {
            
        }
        [_travelArrayID addObject:modle.value?modle.value : @""];
        NSString * ss = [_travelArrayID componentsJoinedByString:@","];
        [MCUserDefaults setObject:ss forKey:@"travelArrayID"];
        
        NSString * home = @"travel";
        [MCUserDefaults setObject:@"1" forKey:home];
        

    }
    else if ([modle.pushType isEqualToString:@"show"]) {
        NSLog(@"晒");
        NSString * _showArrayStr = [MCUserDefaults objectForKey:@"showArrayID"];
        
        
        NSMutableArray * _showArrayID = [NSMutableArray array];
        
        
        if (_showArrayStr) {
            NSArray * arra   = [_showArrayStr componentsSeparatedByString:@","];
            
            for (NSString * str in arra) {
                [_showArrayID addObject:str];
            }
        }
        else
        {
            
        }
        [_showArrayID addObject:modle.value?modle.value : @""];
        
        
        NSString * ss = [_showArrayID componentsJoinedByString:@","];
        
        
        [MCUserDefaults setObject:ss forKey:@"showArrayID"];
        

        NSString * home = @"show";
        [MCUserDefaults setObject:@"1" forKey:home];

    }
    else if ([modle.pushType isEqualToString:@"pick"]) {
        NSLog(@"代购单发生了改变");
        NSString * _pickArrayStr = [MCUserDefaults objectForKey:@"pickArrayID"];
        
        NSMutableArray * _pickArrayID = [NSMutableArray array];
        
        
        if (_pickArrayStr) {
            NSArray * arra   = [_pickArrayStr componentsSeparatedByString:@","];
            
            for (NSString * str in arra) {
                [_pickArrayID addObject:str];
            }
        }
        else
        {
            
        }
        [_pickArrayID addObject:modle.value?modle.value : @""];

        NSString * ss = [_pickArrayID componentsJoinedByString:@","];
        
        
        [MCUserDefaults setObject:ss forKey:@"pickArrayID"];
                
        NSString * home = @"pick";
        [MCUserDefaults setObject:@"1" forKey:home];

    }
    else if ([modle.pushType isEqualToString:@"sell"]) {
        NSLog(@"售卖单发生了改变");
        NSString * _pickArrayStr = [MCUserDefaults objectForKey:@"sellArrayID"];
        
        NSMutableArray * _pickArrayID = [NSMutableArray array];
        
        
        if (_pickArrayStr) {
            NSArray * arra   = [_pickArrayStr componentsSeparatedByString:@","];
            
            for (NSString * str in arra) {
                [_pickArrayID addObject:str];
            }
        }
        else
        {
            
        }
        [_pickArrayID addObject:modle.value?modle.value : @""];
        
        NSString * ss = [_pickArrayID componentsJoinedByString:@","];
        
        
        [MCUserDefaults setObject:ss forKey:@"sellArrayID"];
                
        NSString * home = @"sell";
        [MCUserDefaults setObject:@"1" forKey:home];

    }
    else if ([modle.pushType isEqualToString:@"task"]) {
        NSLog(@"任务完成了");
    }
    else if ([modle.pushType isEqualToString:@"friend"]) {
        NSLog(@"有新朋友");
    }
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didHomeRemindObjNotification" object:@""];
    
}


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

-(void)loadImg{
    
    [self.requestManager postWithUrl:@"api/common/bootPicture.json" refreshCache:NO params:nil IsNeedlogin:NO success:^(id resultDic) {
        
        
        NSLog(@"resultDic ===>>>>>%@",resultDic);
        NSURL  *urlKey = [NSURL URLWithString:resultDic[@"object"][@"image"]];
        PromotionPage *proPage = [PromotionPage promotionPageWithLoginImage:nil promotionURL:urlKey];
        
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [app.window addSubview:proPage];
        
        //        [self.view addSubview:proPage];
        
        proPage.finishBlock = ^(){
            
            
            
            NSLog(@"进入主界面");
        };
        
        
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        
    }];
    
    
    
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    NSLog(@"url.host == %@",url.host);
    
    
    //如果极简开发包不可用,会跳转支付宝钱包进行支付,需要将支付宝钱包的支付结果回传给开 发包
    if ([url.host isEqualToString:@"safepay"])
    {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic)
         {
             NSLog(@"result = %@",resultDic);
             //发送通知
             [[NSNotificationCenter defaultCenter] postNotificationName:@"zhifupayObjNotification" object:resultDic];
             [[NSNotificationCenter defaultCenter] postNotificationName:@"RechargeViewObjNotification" object:resultDic];

             
             //             //发送通知
             //             [[NSNotificationCenter defaultCenter] postNotificationName:@"zhifupayObjNotification" object:resultDic];
             
         }];
        return YES;

    }
    //支付宝钱包快登授权返回 authCode
    if ([url.host isEqualToString:@"platformapi"])
    {
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic)
         {
             //发送通知
             [[NSNotificationCenter defaultCenter] postNotificationName:@"zhifupayObjNotification" object:resultDic];
             [[NSNotificationCenter defaultCenter] postNotificationName:@"RechargeViewObjNotification" object:resultDic];

             NSLog(@"result = %@",resultDic);
         }];
        return YES ;

    }

    
    
    if ([url.host isEqualToString:@"pay"])
    {
        return  [WXApi handleOpenURL:url delegate:self];
    }

    NSLog(@">>>>>>>>%@",url);
    [self applicationStr:url];
    
    return YES;

}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    
    NSLog(@"url.host == %@",url.host);
    //如果极简开发包不可用,会跳转支付宝钱包进行支付,需要将支付宝钱包的支付结果回传给开 发包
    if ([url.host isEqualToString:@"safepay"])
    {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic)
         {
             NSLog(@"result = %@",resultDic);
             
                          //发送通知
                          [[NSNotificationCenter defaultCenter] postNotificationName:@"zhifupayObjNotification" object:resultDic];
             [[NSNotificationCenter defaultCenter] postNotificationName:@"RechargeViewObjNotification" object:resultDic];

             
         }];
        return YES;
    }
    //支付宝钱包快登授权返回 authCode
    if ([url.host isEqualToString:@"platformapi"])
    {
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic)
         {
             NSLog(@"result = %@",resultDic);
             //发送通知
             [[NSNotificationCenter defaultCenter] postNotificationName:@"zhifupayObjNotification" object:resultDic];
             [[NSNotificationCenter defaultCenter] postNotificationName:@"RechargeViewObjNotification" object:resultDic];

         }];
        return YES;

    }

    if ([url.host isEqualToString:@"pay"])
    {
        return  [WXApi handleOpenURL:url delegate:self];
    }

    NSLog(@">>>>>>>>2%@",url);
    [self applicationStr:url];
//    return  [WXApi handleOpenURL:url delegate:self];

    return YES;
    
}
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    NSLog(@"url.host == %@",url.host);
    //如果极简开发包不可用,会跳转支付宝钱包进行支付,需要将支付宝钱包的支付结果回传给开 发包
    if ([url.host isEqualToString:@"safepay"])
    {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic)
         {
             NSLog(@"result = %@",resultDic);
             //发送通知
             [[NSNotificationCenter defaultCenter] postNotificationName:@"zhifupayObjNotification" object:resultDic];
             [[NSNotificationCenter defaultCenter] postNotificationName:@"RechargeViewObjNotification" object:resultDic];

             //             //发送通知
             //             [[NSNotificationCenter defaultCenter] postNotificationName:@"zhifupayObjNotification" object:resultDic];
             
         }];
        return YES;

    }
    //支付宝钱包快登授权返回 authCode
    if ([url.host isEqualToString:@"platformapi"])
    {
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic)
         {
             //发送通知
             [[NSNotificationCenter defaultCenter] postNotificationName:@"zhifupayObjNotification" object:resultDic];
             NSLog(@"result = %@",resultDic);
             [[NSNotificationCenter defaultCenter] postNotificationName:@"RechargeViewObjNotification" object:resultDic];

         }];
        return YES;

    }

    if ([url.host isEqualToString:@"pay"])
    {
        return  [WXApi handleOpenURL:url delegate:self];
    }

    NSLog(@">>>>>>>>3%@",url);
    [self applicationStr:url];

    return YES;

}
-(void)applicationStr:(NSURL*)url{
    
    NSString *urlStr = [url absoluteString];
    NSRange range = [urlStr rangeOfString:@"ciwei://"];//判断字符串是否包含
    if (range.length >0)//包含
    {
        
        
        
    }

    
}
@end
