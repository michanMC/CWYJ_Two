//
//  MyTools.m
//  OwnPeople
//
//  Created by fenguo on 14-11-22.
//  Copyright (c) 2014年 fenguo. All rights reserved.
//

#import "MyTools.h"
#import <objc/runtime.h>

typedef NS_ENUM(NSInteger, HYBJSONModelDataType) {
    kHYBJSONModelDataTypeObject    = 0,
    kHYBJSONModelDataTypeBOOL      = 1,
    kHYBJSONModelDataTypeInteger   = 2,
    kHYBJSONModelDataTypeFloat     = 3,
    kHYBJSONModelDataTypeDouble    = 4,
    kHYBJSONModelDataTypeLong      = 5,
};


@implementation MyTools

+ (BOOL)appIsFirstOpen
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:@"first.txt"];
    
    return ![[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

+ (void)appHasOpened
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:@"first.txt"];
    
    NSArray *array = @[@"opened"];
    [array writeToFile:filePath atomically:YES];
}

+ (id)modelWithDict:(NSDictionary *)dict className:(NSString *)className
{
    if (dict == nil || className == nil || className.length == 0) {
        return nil;
    }
    
    id model = [[NSClassFromString(className) alloc]init];
    
    // 取得类对象
    id classObject = objc_getClass([className UTF8String]);
    
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList(classObject, &count);
    Ivar *ivars = class_copyIvarList(classObject, nil);
    
    for (int i = 0; i < count; i ++) {
        // 取得成员名
        NSString *memberName = [NSString stringWithUTF8String:ivar_getName(ivars[i])];
        const char *type = ivar_getTypeEncoding(ivars[i]);
        NSString *dataType =  [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
        
        NSLog(@"Data %@ type: %@",memberName,dataType);
        
        HYBJSONModelDataType rtype = kHYBJSONModelDataTypeObject;
        if ([dataType hasPrefix:@"c"]) {
            rtype = kHYBJSONModelDataTypeBOOL;// BOOL
        } else if ([dataType hasPrefix:@"i"]) {
            rtype = kHYBJSONModelDataTypeInteger;// int
        } else if ([dataType hasPrefix:@"f"]) {
            rtype = kHYBJSONModelDataTypeFloat;// float
        } else if ([dataType hasPrefix:@"d"]) {
            rtype = kHYBJSONModelDataTypeDouble; // double
        } else if ([dataType hasPrefix:@"l"])  {
            rtype = kHYBJSONModelDataTypeLong;// long
        }
        
        for (int j = 0; j < count; j++) {
            objc_property_t property = properties[j];
            NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property)
                                                              encoding:NSUTF8StringEncoding];
            NSRange range = [memberName rangeOfString:propertyName];
            
            if (range.location == NSNotFound) {
                continue;
            } else {
                id propertyValue = [dict objectForKey:propertyName];
                
                switch (rtype) {
                    case kHYBJSONModelDataTypeBOOL: {
                        BOOL temp = [[NSString stringWithFormat:@"%@", propertyValue] boolValue];
                        propertyValue = [NSNumber numberWithBool:temp];
                    }
                        break;
                    case kHYBJSONModelDataTypeInteger: {
                        int temp = [[NSString stringWithFormat:@"%@", propertyValue] intValue];
                        propertyValue = [NSNumber numberWithInt:temp];
                    }
                        break;
                    case kHYBJSONModelDataTypeFloat: {
                        float temp = [[NSString stringWithFormat:@"%@", propertyValue] floatValue];
                        propertyValue = [NSNumber numberWithFloat:temp];
                    }
                        break;
                    case kHYBJSONModelDataTypeDouble: {
                        double temp = [[NSString stringWithFormat:@"%@", propertyValue] doubleValue];
                        propertyValue = [NSNumber numberWithDouble:temp];
                    }
                        break;
                    case kHYBJSONModelDataTypeLong: {
                        long long temp = [[NSString stringWithFormat:@"%@",propertyValue] longLongValue];
                        propertyValue = [NSNumber numberWithLongLong:temp];
                    }
                        break;
                        
                    default:
                        break;
                }
                
                [model setValue:propertyValue forKey:memberName];
                break;
            }
        }
    }
    return model;
}

+ (BOOL)isPhoneNumber:(NSString*)number {
    NSString *regex = @"^((13[0-9])|(147)|(15[0-9])|(18[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
}

+ (BOOL)isPrice:(NSString*)price{
    NSString *regex = @"^\\d+(\\.\\d{0,2})?$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:price];
    return isMatch;
}

+ (void)saveLoginSeesionId:(NSString *)seesionId AndExpire:(NSString *)expire
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    
    NSArray *array = @[expire,seesionId];
    NSString *filePath = [path stringByAppendingPathComponent:@"login.txt"];
    [array writeToFile:filePath atomically:YES];
}

+ (NSString *)getTheSeesionId
{
    if ([self expireIsValidate]) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *docDir = [paths objectAtIndex:0];
        NSString *filePath = [docDir stringByAppendingPathComponent:@"login.txt"];
        NSArray *array = [[NSArray alloc] initWithContentsOfFile:filePath];
        NSString *seesionId = [array objectAtIndex:1];
        
        return seesionId;
    }
    
    return nil;
}

+ (BOOL)expireIsValidate
{
    long timeInterval = [[NSDate date] timeIntervalSince1970]*1000;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *filePath = [docDir stringByAppendingPathComponent:@"login.txt"];
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    //DLog(@"拿到了--%@",array);
    NSString *expire = [array objectAtIndex:0];
    
    return (timeInterval<expire.longLongValue);
}

+ (void)saveSinaAccount:(NSString *)accountUid
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:@"SinaAccount.txt"];
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    if (![array containsObject:accountUid]) {
        NSMutableArray * new1 = [NSMutableArray arrayWithArray:array];
       // NSMutableArray *new = [NSMutableArray arrayWithArray:array];
        [new1 addObject:accountUid];
        [new1 writeToFile:filePath atomically:YES];
    }
}

+ (BOOL)sinaAccountHasSave:(NSString *)accountUid
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:@"SinaAccount.txt"];
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    return [array containsObject:accountUid];
}

+ (void)saveQQAccount:(NSString *)accountUid
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:@"QQAccount.txt"];
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    if (![array containsObject:accountUid]) {
        NSMutableArray *new1 = [NSMutableArray arrayWithArray:array];
        [new1 addObject:accountUid];
        [new1 writeToFile:filePath atomically:YES];
    }
}

+ (BOOL)qqAccountHasSave:(NSString *)accountUid
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:@"QQAccount.txt"];
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    return [array containsObject:accountUid];
}

@end
