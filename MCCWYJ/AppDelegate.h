//
//  AppDelegate.h
//  MCCWYJ
//
//  Created by MC on 16/4/28.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPUSHService.h"

static NSString *appKey = @"51ad7016a7cf571276c313b5";
static NSString *channel = @"Publish channel";
static BOOL isProduction = NO;

//static NSString *RegistrationID = @"";

@interface AppDelegate : UIResponder <UIApplicationDelegate,EMChatManagerDelegate>
{
    
    EMConnectionState _connectionState;

}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) MCNetworkManager *requestManager;


@end

