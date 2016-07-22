//
//  MCIucencyView.m
//  Hair
//
//  Created by michan on 15/5/26.
//  Copyright (c) 2015年 MC. All rights reserved.
//

#import "MCIucencyView.h"
#import <Accelerate/Accelerate.h>
//两次提示的默认间隔
static const CGFloat kDefaultPlaySoundInterval = 3.0;

@implementation MCIucencyView


-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];

    }
    return self;
}
-(void)prepareUI{
    self.backgroundColor = [UIColor clearColor];
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _bgView.backgroundColor = [UIColor blackColor];
    _bgView.alpha = 0.5;
    [self addSubview:_bgView];
    
    
}
-(void)setBgViewColor:(UIColor *)Color
{
    _bgView.backgroundColor = Color;
}
-(void)setBgViewAlpha:(CGFloat)bgViewAlpha
{
    _bgView.alpha = bgViewAlpha;
}
-(void)setGrade:(NSInteger)page{
    //_bgView.backgroundColor = [UIColor clearColor];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = 13;
    CGFloat height = 13;
    for (int i = 0 ; i < 5; i++) {
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        imgView.image = [UIImage imageNamed:@"star_dark_single"];
        [self addSubview:imgView];
        imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        imgView.image = [UIImage imageNamed:@"star_light_single"];
        imgView.tag = i;
        [self addSubview:imgView];

        
        x += width;
    }
    for (int j = 0; j < 5; j++) {
        if (j >= page) {
            UIImageView *img = (UIImageView*)[self viewWithTag:j];
            img.hidden = YES;
        }
    }
    
}
-(void)setGradeMax:(NSInteger)page{
    _bgView.backgroundColor = [UIColor clearColor];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = 18;
    CGFloat height = 18;
    if (page == 0) {
        
    for (int i = 0 ; i < 5; i++) {
            UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
            imgView.image = [UIImage imageNamed:@"order_icon_star_nomal"];
           // [self addSubview:imgView];
        imgView.userInteractionEnabled = YES;
            x += width;
        }
        return;
        
    }

    for (int i = 0 ; i < 5; i++) {
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        imgView.image = [UIImage imageNamed:@"order_icon_star_nomal"];
      //  [self addSubview:imgView];
        imgView.userInteractionEnabled = YES;

        imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        imgView.image = [UIImage imageNamed:@"order_icon_star_press"];
        imgView.tag = i;
        [self addSubview:imgView];
        imgView.userInteractionEnabled = YES;

        
        x += width - 3;
    }
    for (int j = 0; j < 5; j++) {
        if (j >= page) {
            UIImageView *img = (UIImageView*)[self viewWithTag:j];
            img.hidden = YES;
        }
    }
    
    
    
    
}

-(void)setGradeR:(NSInteger)page{
    //_bgView.backgroundColor = [UIColor clearColor];
    CGFloat x = 0;
    CGFloat y = 3;
    CGFloat width = 17;
    CGFloat height = 17;
    x = self.frame.size.width - width * page;
    
    
    
    for (int i = 0 ; i < page; i++) {
    UIImageView* imgView = [[UIImageView alloc]initWithFrame:CGRectMake( x, y, width, height)];
        imgView.image = [UIImage imageNamed:@"order_icon_star_press"];
        imgView.tag = i;
        [self addSubview:imgView];
        
        
        x += width - 3;
    }
}



-(void)PaomaView:(NSString*)str{
    
    _PaomaView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width - 50, self.frame.size.height)];
    [self addSubview:_PaomaView];
    //view.backgroundColor = [UIColor yellowColor];
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _PaomaView.frame.size.width - 50, _PaomaView.frame.size.height)];
    
    lbl.text = str;
   CGFloat width = [MCIucencyView widthForString:lbl andheight:self.frame.size.height];
    
    lbl.frame = CGRectMake(0, 0, width, _PaomaView.frame.size.height);
    lbl.textColor = [UIColor grayColor];
    lbl.font = [UIFont systemFontOfSize:14];
    [_PaomaView addSubview:lbl];
    CGRect  frame =  lbl.frame;
    frame.origin.x = width + self.frame.size.width-120 - 50;
    lbl.frame = frame;
    
    [UIView beginAnimations:@"testAnimation" context:NULL];
    [UIView setAnimationDuration:15.0f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationRepeatCount:999999];
    
    frame = lbl.frame;
    frame.origin.x = -width;
    lbl.frame = frame;
    [UIView commitAnimations];
    
}
+(CGFloat) widthForString:(UILabel *)textView andheight:(CGFloat)height
{
    CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(CGFLOAT_MAX, height)];
    return sizeToFit.width;
}
+ (CGFloat) heightForString:(UILabel *)textView andWidth:(CGFloat)width
{
    CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    
    
    return sizeToFit.height;
}
/**
 ios7.0之前适用----
 @method 获取指定宽度width,字体大小fontSize,字符串value的高度
 @param value 待计算的字符串
 @param fontSize 字体的大小
 @param Width 限制字符串显示区域的宽度
 @result float 返回的高度
 */
+ (CGFloat) heightForString:(NSString *)value fontSize:(CGFloat)fontSize andWidth:(CGFloat)width
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize]
                         constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                             lineBreakMode:NSLineBreakByWordWrapping];
    //此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit.height;
}
/**
 @method 获取指定宽度width,字体大小fontSize,字符串value的高度
 @param value 待计算的字符串
 @param fontSize 字体的大小
 @param Width 限制字符串显示区域的宽度
 @result float 返回的高度
 */
+ (CGFloat) heightforString:(NSString *)value andWidth:(CGFloat)width fontSize:(CGFloat)fontSize{
    return [value boundingRectWithSize:CGSizeMake(width, 1000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil].size.height;

}
+ (CGFloat) heightforString:(NSString *)value andHeight:(CGFloat)height fontSize:(CGFloat)fontSize{
    return [value boundingRectWithSize:CGSizeMake(100000, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil].size.width;
    
}
//加模糊效果，image是图片，blur是模糊度
+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    
    
    //模糊度,
    if ((blur < 0.1f) || (blur > 2.0f)) {
        blur = 0.5f;
    }
    
    //boxSize必须大于0
    int boxSize = (int)(blur * 100);
    boxSize -= (boxSize % 2) + 1;
    boxSize = 45;
    NSLog(@"boxSize:%i",boxSize);//45
    //图像处理
    CGImageRef img = image.CGImage;
    //需要引入
    /*
     This document describes the Accelerate Framework, which contains C APIs for vector and matrix math, digital signal processing, large number handling, and image processing.
     本文档介绍了Accelerate Framework，其中包含C语言应用程序接口（API）的向量和矩阵数学，数字信号处理，大量处理和图像处理。
     */
    
    //图像缓存,输入缓存，输出缓存
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    //像素缓存
    void *pixelBuffer;
    
    //数据源提供者，Defines an opaque type that supplies Quartz with data.
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    // provider’s data.
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    //宽，高，字节/行，data
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    //像数缓存，字节行*图片高
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    
    // 第三个中间的缓存区,抗锯齿的效果
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    
    //Convolves a region of interest within an ARGB8888 source image by an implicit M x N kernel that has the effect of a box filter.
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    //    NSLog(@"字节组成部分：%zu",CGImageGetBitsPerComponent(img));
    //颜色空间DeviceRGB
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //用图片创建上下文,CGImageGetBitsPerComponent(img),7,8
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(image.CGImage));
    
    //根据上下文，处理过的图片，重新组件
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}


/**
 消除所有红点
 */
+(void)remRemind{
    //加好友
    NSString * home = @"addfriend";
    [MCUserDefaults setObject:@"" forKey:home];
    
    
    home = @"travel";
    [MCUserDefaults setObject:@"" forKey:home];
    home = @"show";
    [MCUserDefaults setObject:@"" forKey:home];
     home = @"pick";
    [MCUserDefaults setObject:@"" forKey:home];
    home = @"sell";
    [MCUserDefaults setObject:@"" forKey:home];

    home = @"travelArrayID";
    [MCUserDefaults setObject:@"" forKey:home];
    home = @"showArrayID";
    [MCUserDefaults setObject:@"" forKey:home];
    home = @"pickArrayID";
    [MCUserDefaults setObject:@"" forKey:home];
    home = @"sellArrayID";
    [MCUserDefaults setObject:@"" forKey:home];

}

/**
 检测首页头像红点
 */
+ (BOOL)HomeRemind{
    //加好友
    NSString * home = @"addfriend";
    NSInteger index = [[MCUserDefaults objectForKey:home] integerValue];
        
//   NSString* newMessage = @"newMessage";
//   NSInteger index2 = [[MCUserDefaults objectForKey:newMessage] integerValue];
    
    NSInteger index2 =  [MCIucencyView setupUnreadMessageCount];//聊天
    
    NSInteger index3 =  [MCIucencyView travelRemind];//yoji
    NSInteger index4 =  [MCIucencyView showRemind];//晒
    NSInteger index5 =  [MCIucencyView pickRemind];//代购
    NSInteger index6 =  [MCIucencyView sellRemind];//shou

    
//是否隐藏
    if (index||index2||!index3||!index4||!index5||!index6) {
        return NO;
    }
    else
    {
        return YES;
    }
    
}
/**
 检测通讯录红点
 */
+ (BOOL)addressBookRemind{
    //加好友
    NSString * home = @"addfriend";
    NSInteger index = [[MCUserDefaults objectForKey:home] integerValue];
    
//    NSString* newMessage = @"newMessage";
//    NSInteger index2 = [[MCUserDefaults objectForKey:newMessage] integerValue];
   NSInteger index2 =  [MCIucencyView setupUnreadMessageCount];
    //是否隐藏
    if (index||index2) {
        return NO;
    }
    else
    {
        return YES;
    }
    
}
/**
 检测游记红点
 */
+ (BOOL)travelRemind{
    
    NSString * home = @"travel";
    NSInteger index = [[MCUserDefaults objectForKey:home] integerValue];
    if (index) {
        NSLog(@"MCtravel");
        return NO;
    }
    else
    {
        return YES;
    }
    
}

/**
 获取游记数组
 */

+ (NSMutableArray*)travelRemindArray{
    
    NSString * home = @"travelArrayID";
    
    
    NSString * _travelArrayStr = [MCUserDefaults objectForKey:home];
    NSMutableArray * _travelArrayID = [NSMutableArray array];
    NSArray * arra   = [_travelArrayStr componentsSeparatedByString:@","];
    
    for (NSString * str in arra) {
        [_travelArrayID addObject:str];
    }
    
    
    if (_travelArrayID) {
        
        return _travelArrayID;
    }
    return [NSMutableArray array];
    
}
/**
 浏览游记
 */
+(void)travelStr:(NSString*)travelID{
    NSMutableArray *srray =[MCIucencyView travelRemindArray];
    [srray removeAllObjects];
    
    NSString * ss = [srray componentsJoinedByString:@","];
    
    [MCUserDefaults setObject:ss forKey:@"travelArrayID"];

    NSString * home = @"travel";
    [MCUserDefaults setObject:@"0" forKey:home];
}




/**
 检测晒红点
 */
+ (BOOL)showRemind{
    NSString * home = @"show";
    NSInteger index = [[MCUserDefaults objectForKey:home] integerValue];
    if (index) {
        NSLog(@"MCshow");

        return NO;
    }
    else
    {
        return YES;
    }
 
    
    
}
/**
 获取晒数组
 */

+ (NSMutableArray*)showRemindArray{
    
    NSString * home = @"showArrayID";
    
    NSString * _travelArrayStr = [MCUserDefaults objectForKey:home];
    
    NSMutableArray * _travelArrayID = [NSMutableArray array];
    NSArray * arra   = [_travelArrayStr componentsSeparatedByString:@","];
    
    for (NSString * str in arra) {
        [_travelArrayID addObject:str];
    }
    
    
    if (_travelArrayID) {
        
        return _travelArrayID;
    }
    return [NSMutableArray array];
    
}
/**
 浏览晒
 */
+(void)showStr:(NSString*)showlID{
    NSMutableArray *srray =[MCIucencyView showRemindArray];
    [srray removeAllObjects];
    
    NSString * ss = [srray componentsJoinedByString:@","];
    
    [MCUserDefaults setObject:ss forKey:@"showArrayID"];
    

    
    NSString * home = @"show";
    [MCUserDefaults setObject:@"0" forKey:home];
}




/**
 检测代购红点
 */
+ (BOOL)pickRemind{
    
    NSString * home = @"pick";
    NSInteger index = [[MCUserDefaults objectForKey:home] integerValue];
    if (index) {
        NSLog(@"MCpick");

        return NO;
    }
    else
    {
        return YES;
    }

    
}
/**
 获取求数组
 */

+ (NSMutableArray*)pickRemindArray{
    
    NSString * home = @"pickArrayID";
    
    NSString * _travelArrayStr = [MCUserDefaults objectForKey:home];
    
    NSMutableArray * _travelArrayID = [NSMutableArray array];
    NSArray * arra   = [_travelArrayStr componentsSeparatedByString:@","];
    
    for (NSString * str in arra) {
        [_travelArrayID addObject:str];
    }
    
    
    if (_travelArrayID) {
        
        return _travelArrayID;
    }
    return [NSMutableArray array];
    
}
/**
 浏览求
 */
+(void)pickStr:(NSString*)picklID{
    NSMutableArray *srray =[MCIucencyView pickRemindArray];
    [srray removeAllObjects];
    
    NSString * ss = [srray componentsJoinedByString:@","];
    
    [MCUserDefaults setObject:ss forKey:@"pickArrayID"];
    
    
    
    NSString * home = @"pick";
    [MCUserDefaults setObject:@"0" forKey:home];
}









/**
 检测售红点
 */
+ (BOOL)sellRemind{
    NSString * home = @"sell";
    NSInteger index = [[MCUserDefaults objectForKey:home] integerValue];
    if (index) {
        NSLog(@"MCsell");

        return NO;
    }
    else
    {
        return YES;
    }

    
}
/**
 获取售数组
 */

+ (NSMutableArray*)sellRemindArray{
    
    NSString * home = @"sellArrayID";
    
    NSString * _travelArrayStr = [MCUserDefaults objectForKey:home];
    
    NSMutableArray * _travelArrayID = [NSMutableArray array];
    NSArray * arra   = [_travelArrayStr componentsSeparatedByString:@","];
    
    for (NSString * str in arra) {
        [_travelArrayID addObject:str];
    }
    
    
    if (_travelArrayID) {
        
        return _travelArrayID;
    }
    return [NSMutableArray array];
    
}
/**
 浏览售
 */
+(void)sellStr:(NSString*)picklID{
    NSMutableArray *srray =[MCIucencyView pickRemindArray];
    [srray removeAllObjects];
    
    NSString * ss = [srray componentsJoinedByString:@","];
    
    [MCUserDefaults setObject:ss forKey:@"sellArrayID"];
    
    
    
    NSString * home = @"sell";
    [MCUserDefaults setObject:@"0" forKey:home];
}




// 统计未读消息数
+(NSInteger)setupUnreadMessageCount
{
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    NSInteger unreadCount = 0;
    for (EMConversation *conversation in conversations) {
        unreadCount += conversation.unreadMessagesCount;
        NSLog(@"conversationId == %@",conversation.conversationId);
    }
    
    return unreadCount;

}

/**
 收到消息时，播放音频
 */
+ (void)playSoundAndVibration
{
    // 收到消息时，播放音频
    [[EMCDDeviceManager sharedInstance] playNewMessageSound];
    // 收到消息时，震动
    [[EMCDDeviceManager sharedInstance] playVibration];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
