//
//  MCUser.m
//  Hair
//
//  Created by michan on 15/6/7.
//  Copyright (c) 2015年 MC. All rights reserved.
//






#import "MCUser.h"

@implementation MyLocation

@end






@implementation MCUser

+ (MCUser *)sharedInstance
{
    static dispatch_once_t  onceToken;
    static MCUser * sSharedInstance;

    dispatch_once(&onceToken, ^{
        sSharedInstance = [[MCUser alloc] init];
        sSharedInstance.myLocation = [[MyLocation alloc]init];
        sSharedInstance.launchOptions = [NSDictionary dictionary];
    });
    return sSharedInstance;
}

@end
