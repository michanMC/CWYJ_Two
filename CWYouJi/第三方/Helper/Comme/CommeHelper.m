//
//  CommeHelper.m
//  StarGroups
//
//  Created by zijin on 15/4/7.
//  Copyright (c) 2015年 fenguo. All rights reserved.
//

#import "CommeHelper.h"
#import "AA3DESManager.h"
#import "NetworkManager.h"

@implementation CommeHelper

+(NSString*)getEncryptWithString:(NSDictionary*)dict
{

    //NSString *string ;
    @try {
        
            NSString *json;
            if ([NSJSONSerialization isValidJSONObject:dict])
            {
                NSError *error;
                NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
                json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            }
            NSString *string = [AA3DESManager getEncryptWithString:json keyString:@"p2p_standard2_base64_key" ivString:@"p2p_s2iv" ];
        
        
        return string;
            NSLog(@"string ===%@",string);

    }
    @catch (NSException *exception) {
        NSLog(@"加密失败＝＝＝＝＝＝＝＝》失败的参数是/n%@",dict);

    }
    @finally {
     
       // string=@"";
    }
    
    
  return @"";
}



+(NSDictionary*)getDecryptWithString:(NSString*)jsonStr
{
  
    @try {
        NSString  *stringJson=[AA3DESManager getDecryptWithString:jsonStr keyString:@"p2p_standard2_base64_key"  ivString:@"p2p_s2iv"];
        
        NSData *data=[stringJson dataUsingEncoding:NSUTF8StringEncoding ];
        
        NSError *error=nil;
        
        NSDictionary  *dict=[ NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        
        return dict;

    }
    @catch (NSException *exception) {
        NSLog(@"解析失败＝＝＝＝＝＝＝＝》/n%@",jsonStr);
    }
    @finally {
    
    }
   return nil;
}


+(NSString*)getJson:(NSDictionary*)dict
{
    
    @try{
        
        NSString *json;
        if ([NSJSONSerialization isValidJSONObject:dict])
        {
            NSError *error;
            NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
            json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        }
        return json;
        
    }@catch (NSException *exception) {
        NSLog(@"加密失败＝＝＝＝＝＝＝＝》失败的参数是/n%@",dict);
        
    }
    @finally {
        
        // string=@"";
    }
    
    return @"";
}


@end
