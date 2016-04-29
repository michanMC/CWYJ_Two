//
//  CommonUtil.h
//  常用工具类
//  Created by just-bob on 13-6-8.
//  Copyright (c) 2013年 just-bob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//将RGB值转换UIColor
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//定义调试日志
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif
#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

//获取Bundle包路径
#define GETBUNDLEWITHPATH(X) [NSBundle bundleWithPath: [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: X]]


@interface CommonUtil : NSObject{
    
}
//获取一个日期＋星期的字串15位长度yyyy年MM月dd日 星期五
+(NSString*)getDateForWeek:(NSDate*)currdate;
+(NSDate*)getDateForDD:(NSString*)currdate;
//日期工具函数
+(NSString*)getHHMM2:(NSDate*)currdate;
+(NSString*)getHHMM:(NSDate*)currdate;
+(NSString*)getDate:(NSDate*)currdate;
+(NSString*)getHour:(NSDate*)currdate;
+(NSString*)toCNWeekFromYYYYMMDD:(NSString*)currdate;
+(NSString*)toCNTimeFromYYYYMMDD:(NSString*)currdate;
+(NSString*)getDateForYYYYMMDD24HHMMSS:(NSDate*)currdate;
+(NSDate*)getDateFromYYYYMMDD24HHMMSS2:(NSString*)currdate;

+(NSString*)getDateForYYYYMMDD:(NSDate*)currdate;
+(NSDate*)getDateFromYYYYMMDD:(NSString*)currdate;
+(NSDate*)getDateFromYYYYMMDD2:(NSString*)currdate;
+(NSString*)getDateYYYYMMDD:(NSDate*)currdate;
+(NSDate*)getDateFromYYYYMMDD24HHMMSS:(NSString*)currdate;
+(NSString*)getCNDate:(NSDate*)currdate;
+(NSString*)getCNWeek:(NSDate*)currdate;
+(NSString*)getMMDD:(NSDate*)currdate;
+(NSString*)getMMDDWeek:(NSDate*)currdate;
+(NSString*)getMMDDHHMM:(NSDate*)currdate;
+(NSString*)getMMDD2:(NSDate*)currdate;
//+(NSString*)getCNMMDD:(NSDate*)currdate;
+(NSString*)getNMMDDHHMM:(NSDate*)currdate;
+(NSString*)getCNMMDDHHMM:(NSDate*)currdate;
//几天后日期
+(NSDate *)dateAfterDay: (NSDate *)currdate dayafter:(int)day;
//间隔天数
+(NSUInteger)daysAgo:(NSDate *)currdate;
//午夜时间距今几天
+(NSUInteger)daysAgoAgainstMidnight:(NSDate *) mydate;
//时间格式化
+(NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format;
//间隔天数
+(NSUInteger)daysAgo:(NSDate *) fromdate todate:(NSDate *) todate;
/**
 时间戳转化为NSString
 */
+(NSString*)getStringWithLong:(long long)time Format:(NSString*)format;

//电话号码打****
+(NSString *)phonenumbel:(NSString *)num;
//身份号码打****
+(NSString *)Number:(NSString *)num;
//车牌****
+(NSString *)carNumbel:(NSString *)num;




//是否数字
+ (BOOL) isNumbericString:(NSString *)str;
//是否手机号码
+ (BOOL) isMobile:(NSString *)strNum;
//a-z\A-Z\!@#$&
+ (BOOL) isLimitChar:(NSString *)strNum;
//字母数字结合
+ (BOOL) isTranNum:(NSString *)strNum;
//是否身份证件号码
+ (BOOL) isCardNum:(NSString *)strNum;
//是否邮箱地址
+ (BOOL) isEmail:(NSString*)email;
//首位是否字母
+ (BOOL) isFirstChr:(NSString*)str;
//从16进制获取颜色
+ (UIColor *) getColorFromHex: (NSString *) hexColor;

//是否是车牌号码
+(BOOL) isChePaiHao:(NSString *)cheNum;
//是否是车挂号码
+(BOOL) isCheGuaHao:(NSString *)cheGuaNum;

//从bundle中获取图片
+ (UIImage *) getImageFromBundle:(NSString*)name;

//从bundle配置文件中获取配置参数信息
+ (NSString*) getValueFromBundle:(NSString*)filename Key:(NSString*) key;

//文件操作部分
+(NSString*) getHomeDir;
+(NSString*) getDocumentDir;
+(NSString*) getCacheDir;
+(NSString*) getTmpDri;

//票价
+(NSString*) getPrice:(NSString*)price Len:(NSInteger)len;
//时间
+(NSString*) getTime:(NSString*)time;
//性别 1男 0女
+(NSString*) getSex:(NSString*)flag;
//取票截止时间
+(NSString*) getLimit_Time:(NSString*)limit_time;
//获取历时
+(NSString*) getLishi:(NSString*)min;

+(NSString*) getDataInt:(NSInteger)num;




+(NSString*)getProvinceKey:(NSInteger)provinceKey CityKey:(NSInteger)cityKey AreaKey:(NSInteger)areaKey;




/**
 *  @brief  将字符串和image 合并为NSAttributedString
 *
 *  @param str   字符串
 *  @param image 图片
 *  @param acolor 文本颜色
 *  @param afont 文本字体 大小
 *
 *  @return NSAttributedString 对象
 *
 *  @since 1.0
 */
+(NSAttributedString *)formatString:(NSString *)str textColor:(UIColor *)acolor font:(UIFont *)afont image:(UIImage *)image;
+(NSString*)daysAgoAgainst:(long long)time;

@end
