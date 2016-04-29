//
//  CommonUtil.m
//  一点通
//
//  Created by just-bob on 13-6-8.
//  Copyright (c) 2013年 just-bob. All rights reserved.
//

#import "CommonUtil.h"
//#import "MCUser.h"
#define kAlphaNum   @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
@implementation CommonUtil

//获取一个日期＋星期的字串15位长度yyyy年MM月dd日 星期五
+(NSString*)getDateForWeek:(NSDate*)currdate{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 EEEE"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr=nil;
    if(currdate==nil)
        currentDateStr= [dateFormatter stringFromDate:[NSDate date]];
    else
        currentDateStr= [dateFormatter stringFromDate:currdate];
    return currentDateStr;
}

//获取一个日期＋星期的字串15位长度yyyy年MM月dd日 星期五
+(NSDate*)getDateFromYYYYMMDD:(NSString*)currdate{    
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyyMMdd"];
    NSDate* date = [formater dateFromString:currdate];
    return date;
}

+(NSString*)toCNWeekFromYYYYMMDD:(NSString*)currdate{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyyMMdd"];
    NSDate* date = [formater dateFromString:currdate];
    return [CommonUtil getDateForWeek:date];
}

+(NSString*)toCNTimeFromYYYYMMDD:(NSString*)currdate{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyyMMdd"];
    NSDate* date = [formater dateFromString:currdate];
    return [CommonUtil getCNMMDDHHMM:date];
}

//获取一个日期＋星期的字串15位长度yyyy年MM月dd日 星期五
+(NSDate*)getDateFromYYYYMMDD2:(NSString*)currdate{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    NSDate* date = [formater dateFromString:currdate];
    return date;
}

+(NSString*)getDateYYYYMMDD:(NSDate*)currdate{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr=nil;
    if(currdate==nil)
        currentDateStr= [dateFormatter stringFromDate:[NSDate date]];
    else
        currentDateStr= [dateFormatter stringFromDate:currdate];

    return currentDateStr;
}

//获取天
+(NSDate*)getDateForDD:(NSString*)currdate{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    formater.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [formater setDateFormat:@"dd"];
    NSDate* date = [formater dateFromString:currdate];
    return date;
}

//获取一个日期＋星期的字串15位长度yyyy年MM月dd日 星期五
+(NSDate*)getDateFromYYYYMMDD24HHMMSS:(NSString*)currdate{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    formater.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [formater setDateFormat:@"yyyyMMddHHmmss"];
    NSDate* date=nil;
    @try {
          date= [formater dateFromString:currdate];
    }
    @catch (NSException *exception) {
//        date=[NSDate date];
    }
    @finally {
    }
    return date;
}


//获取一个日期＋星期的字串15位长度yyyy年MM月dd日 星期五
+(NSDate*)getDateFromYYYYMMDD24HHMMSS2:(NSString*)currdate{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    formater.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* date=nil;
    @try {
        date= [formater dateFromString:currdate];
    }
    @catch (NSException *exception) {
        //        date=[NSDate date];
    }
    @finally {
    }
    return date;
}




//获取一个日期＋星期的字串15位长度yyyy年MM月dd日 星期五
+(NSString*)getCNDate:(NSDate*)currdate{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr=nil;
    if(currdate==nil)
        currentDateStr= [dateFormatter stringFromDate:[NSDate date]];
    else
        currentDateStr= [dateFormatter stringFromDate:currdate];
    return currentDateStr;
}

+(NSString*)getMMDDHHMM:(NSDate*)currdate{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    //设定时间格式,这里可以设置成自己需要的格式
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat:@"MM月dd日 HH:mm"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr=nil;
    if(currdate==nil)
        currentDateStr= [dateFormatter stringFromDate:[NSDate date]];
    else
        currentDateStr= [dateFormatter stringFromDate:currdate];
    return currentDateStr;
}

//MM/DD格式
+(NSString*)getMMDD:(NSDate*)currdate{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    //设定时间格式,这里可以设置成自己需要的格式
//    dateFormatter.locale = [[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]autorelease];
    [dateFormatter setDateFormat:@"MM月dd日"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr=nil;
    if(currdate==nil)
        currentDateStr= [dateFormatter stringFromDate:[NSDate date]];
    else
        currentDateStr= [dateFormatter stringFromDate:currdate];
    return currentDateStr;
}

//MM/DD格式
+(NSString*)getMMDDWeek:(NSDate*)currdate{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    //设定时间格式,这里可以设置成自己需要的格式
    //    dateFormatter.locale = [[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]autorelease];
    [dateFormatter setDateFormat:@"MM月dd日 EEEE"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr=nil;
    if(currdate==nil)
        currentDateStr= [dateFormatter stringFromDate:[NSDate date]];
    else
        currentDateStr= [dateFormatter stringFromDate:currdate];
    return currentDateStr;
}

//获取一个日期＋星期的字串15位长度yyyy年MM月dd日 星期五
+(NSString*)getMMDD2:(NSDate*)currdate{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat:@"MM/dd"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr=nil;
    if(currdate==nil)
        currentDateStr= [dateFormatter stringFromDate:[NSDate date]];
    else
        currentDateStr= [dateFormatter stringFromDate:currdate];
    return currentDateStr;
}

//获取一个日期＋星期的字串15位长度yyyy年MM月dd日 星期五
+(NSString*)getCNMMDDHHMM:(NSDate*)currdate{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日HH时mm分"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr=nil;
    if(currdate==nil)
        currentDateStr= [dateFormatter stringFromDate:[NSDate date]];
    else
        currentDateStr= [dateFormatter stringFromDate:currdate];
    return currentDateStr;
}


+(NSString*)getHHMM:(NSDate*)currdate{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"HH:mm"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr=nil;
    if(currdate==nil)
        currentDateStr= [dateFormatter stringFromDate:[NSDate date]];
    else
        currentDateStr= [dateFormatter stringFromDate:currdate];
    return currentDateStr;
}

+(NSString*)getHHMM2:(NSDate*)currdate{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"HHmm"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr=nil;
    if(currdate==nil)
        currentDateStr= [dateFormatter stringFromDate:[NSDate date]];
    else
        currentDateStr= [dateFormatter stringFromDate:currdate];
    return currentDateStr;
}


+(NSString*)getDate:(NSDate*)currdate{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr=nil;
    if(currdate==nil)
        currentDateStr= [dateFormatter stringFromDate:[NSDate date]];
    else
        currentDateStr= [dateFormatter stringFromDate:currdate];
    return currentDateStr;
}

+(NSString*)getHour:(NSDate*)currdate{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"HH"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr=nil;
    if(currdate==nil)
        currentDateStr= [dateFormatter stringFromDate:[NSDate date]];
    else
        currentDateStr= [dateFormatter stringFromDate:currdate];
    return currentDateStr;
}

+(NSString*)getDateForYYYYMMDD24HHMMSS:(NSDate*)currdate{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr=nil;
    if(currdate==nil)
        currentDateStr= [dateFormatter stringFromDate:[NSDate date]];
    else
        currentDateStr= [dateFormatter stringFromDate:currdate];

    return currentDateStr;
}

+(NSString*)getDateForYYYYMMDD:(NSDate*)currdate{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr=nil;
    if(currdate==nil)
        currentDateStr= [dateFormatter stringFromDate:[NSDate date]];
    else
        currentDateStr= [dateFormatter stringFromDate:currdate];
    return currentDateStr;
}

//获取一个日期＋星期的字串15位长度yyyy年MM月dd日 星期五
+(NSString*)getCNWeek:(NSDate*)currdate{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat:@"EEEE"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr=nil;
    if(currdate==nil)
        currentDateStr= [dateFormatter stringFromDate:[NSDate date]];
    else
        currentDateStr= [dateFormatter stringFromDate:currdate];
    return currentDateStr;
}


+ (NSDate *)dateAfterDay: (NSDate *) mydate dayafter:(int)day
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // Get the weekday component of the current date
    // NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    // to get the end of week for a particular date, add (7 - weekday) days
    [componentsToAdd setDay:day];
    
    if(mydate==nil)
        mydate=[NSDate date];
    
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:mydate options:0];

    
    return dateAfterDay;
}

+(NSUInteger)daysAgo:(NSDate *) mydate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit)
                                               fromDate:mydate
                                                 toDate:[NSDate date]
                                                options:0];
    return [components day];
}

+(NSUInteger)daysAgo:(NSDate *) fromdate todate:(NSDate *) todate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit)
                                               fromDate:fromdate
                                                 toDate:todate
                                                options:0];
    return [components day];
}

//午夜时间距今几天
+ (NSUInteger)daysAgoAgainstMidnight:(NSDate *) mydate
{
    NSDateFormatter *mdf = [[NSDateFormatter alloc] init];
    [mdf setDateFormat:@"yyyy-MM-dd"];
    NSDate *midnight = [mdf dateFromString:[mdf stringFromDate:mydate]];
    
    return (int)[midnight timeIntervalSinceNow] / (60*60*24) *-1;
}
+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    NSDate *date = [inputFormatter dateFromString:string];
    return date;
}

+ (BOOL)isNumbericString:(NSString *)str
{
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:@"^(?:|0|[1-9]\\d{0,})(?:\\.\\d*)?$"
                                              options:NSRegularExpressionCaseInsensitive
                                              error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:str
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, str.length)];
    if(numberofMatch > 0)
    {
        return YES;
    }
    return NO;
}

+ (BOOL) isMobile:(NSString *)strNum
{
    
    NSString *regex = @"^((13[0-9])|(147)|(177)|(170)|(15[0-9])|(18[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:strNum];
    return isMatch;
    

    
    
    //中国移动G网 134 135 136 137  138 139 144 150 151 152 157 158 159 187 188
    //中国联通G网 130 131 132 155  156 185 186
    //中国电信C网 133 153 180 189
    //130 131 132 133
//    NSRegularExpression *regularexpression = [[NSRegularExpression alloc] initWithPattern:@"^(13[0-9]|15[0-9]|18[0-9]|14(4|3))[0-9]{8}$" options:NSRegularExpressionCaseInsensitive error:nil];
//    
//    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:strNum options:NSMatchingReportProgress range:NSMakeRange(0, strNum.length)];
//    if(numberofMatch > 0)
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
//    
//    return NO;
}

+ (BOOL) isLimitChar:(NSString *)strNum
{
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc] initWithPattern:@"^([A-Z]|[a-z]|[0-9]|@|#|$|&|!){1,30}$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:strNum options:NSMatchingReportProgress range:NSMakeRange(0, strNum.length)];
    if(numberofMatch > 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
    return NO;
}
//- (NSString *) trimming {
//    
//    return [self stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
//}
+ (BOOL) isTranNum:(NSString *)strNum{
    
    NSString *testString = strNum;
    NSString *perchar;
    int alength = [testString length];
    
    
    
    
    BOOL isChar = NO;
    BOOL isnum = NO;
    BOOL isnum1 = YES;

    for (int i = 0; i<alength; i++) {
        char commitChar = [testString characterAtIndex:i];
        NSString *temp = [testString substringWithRange:NSMakeRange(i,1)];
        const char *u8Temp = [temp UTF8String];
        if (3==strlen(u8Temp)){
            NSLog(@"字符串中含有中文");
            isnum1 = NO;
            break;
        }
        if((commitChar>64)&&(commitChar<91)){
            NSLog(@"字符串中含有大写英文字母");
            isChar = YES;
            continue;
        }
        if((commitChar>96)&&(commitChar<123)){
            NSLog(@"字符串中含有小写英文字母");
            isChar = YES;
            continue;


        }
        if((commitChar>47)&&(commitChar<58)){
            NSLog(@"字符串中含有数字");
            isnum = YES;
            continue;


        }
        else{
            NSLog(@"字符串中含有非法字符%c",commitChar);
            isnum1 = NO;
            break;

        }
    }
    
    if ((isnum || isChar)&&isnum1) {
        return YES;
    }
    return NO;
    
    
}
//{
//    //判断是不是纯数字
//    [NSCharacterSet decimalDigitCharacterSet];
//    if ([[strNum stringByTrimmingCharactersInSet: [NSCharacterSet decimalDigitCharacterSet]]trimming].length >0) {
//        DLog(@"不是纯数字");
//    }else{
//        DLog(@"纯数字！");
//    }
//    
//    
//}


    
    
    
    
    
    
    
    
//    NSString* str = @"1232343453453";
//    NSRange range = [strNum rangeOfString:@"[a-z][A-Z][0-9]"];
//    
//    
//    
//    NSString *regluar = @"[a-z][A-Z][0-9]";
//    
//    NSPredicate *preciate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regluar];
//    if (![preciate evaluateWithObject:strNum]) {
//    
//        NSLog(@"!");
//        
//    }
//    else
//    {
//        NSLog(@"?");
//
//    }
//    //^\w+$
//    
//    NSRegularExpression *regularexpression = [[NSRegularExpression alloc] initWithPattern:@"^(A-Z0-9a-z)$" options:NSRegularExpressionCaseInsensitive error:nil];
//    
//    
//    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:strNum options:NSMatchingReportProgress range:NSMakeRange(0, strNum.length)];
//    
//    if(numberofMatch > 0)
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
//    return NO;



+(BOOL) isFirstChr:(NSString *)str{
    NSString *regex = @"^([A-Z]|[a-z]){1}$";
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc] initWithPattern:regex options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];
    if(numberofMatch > 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
    return NO;
    
}


+ (BOOL) isCardNum:(NSString *)strNum
{
    strNum = [strNum uppercaseString];
    
    if([strNum length]!=15 && [strNum length]!=18)
        return false;
    
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc] initWithPattern:@"[0-9]{17}(x|X|[0-9]){1}$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:strNum options:NSMatchingReportProgress range:NSMakeRange(0, strNum.length)];
    if(numberofMatch > 0)
    {
        char szID[20] = {0};
        memcpy(szID, [strNum UTF8String], 18);
        int wi[17]={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2};
        char rs[12]={"10X98765432"};
        int iSum = 0;
        for(int i=0;i<17;i++)
        {
            iSum += (szID[i]-'0')*wi[i];
        }
        if(szID[17] == rs[iSum%11])
        {
            return YES;
        }
        return NO;
    }
    else
    {
        return NO;
    }
    return NO;
}
+ (BOOL) isEmail:(NSString*)email
{
    
    if( (0 != [email rangeOfString:@"@"].length) &&  (0 != [email rangeOfString:@"."].length) )
    {
        NSMutableCharacterSet *invalidCharSet = [[[NSCharacterSet alphanumericCharacterSet] invertedSet]mutableCopy];
        [invalidCharSet removeCharactersInString:@"_-"];
        
        NSRange range1 = [email rangeOfString:@"@" options:NSCaseInsensitiveSearch];
        
        // If username part contains any character other than "."  "_" "-"
        
        NSString *usernamePart = [email substringToIndex:range1.location];
        NSArray *stringsArray1 = [usernamePart componentsSeparatedByString:@"."];
        for (NSString *string in stringsArray1) {
            NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet: invalidCharSet];
            if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
                return NO;
        }
        
        NSString *domainPart = [email substringFromIndex:range1.location+1];
        NSArray *stringsArray2 = [domainPart componentsSeparatedByString:@"."];
        
        for (NSString *string in stringsArray2) {
            NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet:invalidCharSet];
            if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
                return NO;
        }
        
        return YES;
    }
    else // no ''@'' or ''.'' present
        return NO;
}



+ (UIColor *) getColorFromHex: (NSString *) hexColor
{
	unsigned int red, green, blue;
	NSRange range;
	range.length = 2;
	range.location = 0;
	[[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
	range.location = 2;
	[[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
	range.location = 4;
	[[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
	return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:1.0f];
}

//+ (UIImage *) getImageFromBundle:(NSString *)name
//{
//    return [UIImage imageWithContentsOfFile:[CommonUtil getAppBundleName:G_BUNLENAME withfileName:name]];
//}

+ (NSString*) getAppBundleName:(NSString*) budleName withfileName:(NSString*) fileName
{
    NSBundle * libBundle = GETBUNDLEWITHPATH(budleName) ;
    if ( libBundle && fileName )
    {
        NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : fileName];
        //NSLog ( @"%@" ,s);
        return s;
    }
    return nil ;
}


//+ (NSString*) getValueFromBundle:(NSString *)filename Key:(NSString *)key
//{
//    NSBundle * libBundle = GETBUNDLEWITHPATH(G_BUNLENAME) ;
//    if ( libBundle)
//    {
//        NSString *nsfile=[libBundle pathForResource:filename ofType:@"plist"];
//        NSDictionary *nsdir=[[NSDictionary alloc] initWithContentsOfFile:nsfile];
//        NSString * s=[nsdir objectForKey:key];
//        return s;
//    }
//    return nil ;
//}


+(NSString*) getHomeDir{
    return NSHomeDirectory();
}
+(NSString*) getDocumentDir{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}
+(NSString*) getCacheDir{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}
+(NSString*) getTmpDri{
    return NSTemporaryDirectory();
}


+(NSString*) getLishi:(NSString*)min {
    if(min==nil || [min length]<1)
        return @"未知";
    
    if([min isEqualToString:@"----"])
        return @"--";
    if(min.integerValue<=60)
        return [NSString stringWithFormat:@"历时%@分",min];
    
    int _hour =min.intValue/60;
    int _min  =min.intValue%60;
    NSString *result=[NSString stringWithFormat:@"历时%d小时%d分",_hour,_min];
    return result;
}

//票价
+(NSString*) getPrice:(NSString*)price Len:(NSInteger)len{
    if(price==nil || [price length]<2)
        return @"禁售";
    if([price hasPrefix:@"0"])
        price=[price substringFromIndex:1];
    
    NSString *price1=[price substringToIndex:price.length-len];
    NSString *price2=[price substringFromIndex:price.length-len];
    NSString *tmpprice=nil;
    if([price2 isEqualToString:@"0"])
        tmpprice=[NSString stringWithFormat:@"¥%@",price1];
    else
        tmpprice=[NSString stringWithFormat:@"¥%@.%@",price1,price2];
    return tmpprice;
}


//时间
+(NSString*) getTime:(NSString*)time{
    if([time length]!=4) return time;
    
    NSString *time1=[time substringToIndex:2];
    NSString *time2=[time substringFromIndex:2];
    return[NSString stringWithFormat:@"%@:%@",time1,time2];
}

//性别
+(NSString*) getSex:(NSString*)flag{
    if([flag isEqualToString:@"1"])
        return @"男";
    return @"女";
}
//获取取票截止时间20130820240000#  
+(NSString*) getLimit_Time:(NSString *)limit_time{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyyMMddHHmmss"];
    NSDate* date = [formater dateFromString:limit_time];

    if(date==nil)
        return limit_time;
    return [CommonUtil getCNMMDDHHMM:date];
}

+(NSString*) getDataInt:(NSInteger)num
{
   
    
    return [NSString stringWithFormat:@"%ld",(long)num];
    
}
+(NSString*)getStringWithLong:(long long)time Format:(NSString*)format{
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    dateFormatter.dateFormat = format;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time];
    
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr=nil;
    if(confromTimesp==nil)
        currentDateStr= [dateFormatter stringFromDate:[NSDate date]];
    else
        currentDateStr= [dateFormatter stringFromDate:confromTimesp];
    
    return currentDateStr;
 

}

//电话号码打****
+(NSString *)phonenumbel:(NSString *)num{
    if (num.length <11) {
        return  num;
    }

    NSMutableString *  str = [NSMutableString stringWithString:num];
    [str deleteCharactersInRange:NSMakeRange(2, 6)];
    [str insertString:@"******" atIndex:2];
    
    return str;
    
    
}
//身份号码打****
+(NSString *)Number:(NSString *)num{
    
    if (num.length <18) {
        return  num;
    }

    return [num stringByReplacingCharactersInRange:NSMakeRange(14, 4) withString:@"****"];
    
    
}
//车牌****
+(NSString *)carNumbel:(NSString *)num{
    if (num.length < 1) {
        return @"暂无车牌号";
    }
    if (num.length <3) {
        return  @"***";
    }
    
    NSMutableString *  str = [NSMutableString stringWithString:num];
    [str deleteCharactersInRange:NSMakeRange(num.length - 3, 3)];
    [str insertString:@"***" atIndex:num.length - 3];
    
    return str;
    
    
}
//是否是车牌号码
+(BOOL) isChePaiHao:(NSString *)cheNum
{
    NSString * regex = @"^[京津冀晋蒙辽吉桂黑陕黔秦新琼宁青港藏甘陇蜀云滇沪川粤渝贵台苏浙皖澳闽赣鲁豫鄂楚湘]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{5}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL result =  [predicate evaluateWithObject:cheNum];
    
    return result;
}

//是否是车挂号码
+(BOOL) isCheGuaHao:(NSString *)cheGuaNum
{
    NSString * regex = @"^[京津冀晋蒙辽吉桂黑陕黔秦新琼宁青港藏甘陇蜀云滇沪川粤渝贵台苏浙皖澳闽赣鲁豫鄂楚湘]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL result =  [predicate evaluateWithObject:cheGuaNum];
    
    return result;
}

//获取一个日期＋星期的字串15位长度yyyy年MM月dd日 星期五
+(NSString*)getNMMDDHHMM:(NSDate*)currdate{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat:@"MM月dd日 HH:mm"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr=nil;
    if(currdate==nil)
        currentDateStr= [dateFormatter stringFromDate:[NSDate date]];
    else
        currentDateStr= [dateFormatter stringFromDate:currdate];
    return currentDateStr;
}

+(NSAttributedString *)formatString:(NSString *)str textColor:(UIColor *)acolor font:(UIFont *)afont image:(UIImage *)image{
    NSDictionary * attribute = @{NSFontAttributeName: afont,NSForegroundColorAttributeName:acolor};
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = image;
    textAttachment.bounds = CGRectMake(0, -4, image.size.width, image.size.height);
    NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
    NSMutableAttributedString * attString= [[NSMutableAttributedString alloc]initWithString:str];
    [attString insertAttributedString:imageStr atIndex:0];
    [attString addAttributes:attribute range:NSMakeRange(0, attString.length)];
    return attString;
}
+(NSString*)daysAgoAgainst:(long long)time{
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time ];
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    
    
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSCalendar *cal=[NSCalendar currentCalendar];
    
    
    unsigned int unitFlags=NSYearCalendarUnit| NSMonthCalendarUnit| NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
    
    NSDateComponents *d = [cal components:unitFlags fromDate:confromTimesp toDate:dat options:0];
    //  NSLog(@"%d天%d小时%d分钟%d秒",[d day],[d hour],[d minute],[d second]);
    
    if ([d day]) {
        return [NSString stringWithFormat:@"%d天前",[d day]];
    }
    else if([d hour])
    {
        return [NSString stringWithFormat:@"%d小时前",[d hour]];
        
    }
    else if([d minute]){
        return [NSString stringWithFormat:@"%d分钟前",[d minute]];
        
    }
    else
    {
        return [NSString stringWithFormat:@"%d秒前",[d second]];
    }
    
    
    
    return @"未知";
}

@end
