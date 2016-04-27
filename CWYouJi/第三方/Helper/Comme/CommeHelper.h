//
//  CommeHelper.h
//  StarGroups
//
//  Created by zijin on 15/4/7.
//  Copyright (c) 2015年 fenguo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static NSString *const url = @"http://203.195.168.151:8080/front";
@interface CommeHelper : NSObject
+(NSString*)getEncryptWithString:(NSDictionary*)dict;
+(NSDictionary*)getDecryptWithString:(NSString*)jsonStr;
+(NSString*)getJson:(NSDictionary*)dict;

@end
