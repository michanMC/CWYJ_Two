//
//  MCIucencyView.h
//  Hair
//
//  Created by michan on 15/5/26.
//  Copyright (c) 2015年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCIucencyView : UIView
@property (strong, nonatomic) NSDate *lastPlaySoundDate;

@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIView*PaomaView;
/**
 背景颜色
 */
-(void)setBgViewColor:(UIColor*)Color;
/**
 背景透明度
 */
-(void)setBgViewAlpha:(CGFloat)bgViewAlpha;
/**
 星星个数
 */
-(void)setGrade:(NSInteger)page;
/**
 星星个数(大)
 */
-(void)setGradeMax:(NSInteger)page;
/**
 星星个数(右边)
 */
-(void)setGradeR:(NSInteger)page;
/**
 跑马灯
 */
-(void)PaomaView:(NSString*)str;
/**
 UILabel的height
 */
+ (CGFloat) heightForString:(UILabel *)textView andWidth:(CGFloat)width;
/**
 UILabel的width
 */
+ (CGFloat) widthForString:(UILabel *)textView andheight:(CGFloat)height;

/**
 @method 获取指定宽度width,字体大小fontSize,字符串value的高度
 @param value 待计算的字符串
 @param fontSize 字体的大小
 @param Width 限制字符串显示区域的宽度
 @result float 返回的宽度
 */
+ (CGFloat) heightforString:(NSString *)value andHeight:(CGFloat)height fontSize:(CGFloat)fontSize;

/**
 ios7.0之前适用----
 @method 获取指定宽度width,字体大小fontSize,字符串value的高度
 @param value 待计算的字符串
 @param fontSize 字体的大小
 @param Width 限制字符串显示区域的宽度
 @result float 返回的高度
 */
+ (CGFloat) heightForString:(NSString *)value fontSize:(CGFloat)fontSize andWidth:(CGFloat)width;
/**
 ios7.0之后适用
 @method 获取指定宽度width,字体大小fontSize,字符串value的高度
 @param value 待计算的字符串
 @param fontSize 字体的大小
 @param Width 限制字符串显示区域的宽度
 @result float 返回的高度
 */
+ (CGFloat) heightforString:(NSString *)value andWidth:(CGFloat)width fontSize:(CGFloat)fontSize;




/**
 图片模糊化
 */
//加模糊效果，image是图片，blur是模糊度
+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur ;


/**
 检测首页头像红点
 */
+ (BOOL)HomeRemind;
/**
 检测通讯录红点
 */
+ (BOOL)addressBookRemind;
/**
 检测游记红点
 */
+ (BOOL)travelRemind;
/**
 检测晒红点
 */
+ (BOOL)showRemind;
/**
 检测代购红点
 */
+ (BOOL)pickRemind;
/**
 检测售红点
 */
+ (BOOL)sellRemind;

/**
 获取游记数组
 */

+ (NSMutableArray*)travelRemindArray;

/**
 浏览游记
 */
+(void)travelStr:(NSString*)travelID;


/**
 获取晒数组
 */

+ (NSMutableArray*)showRemindArray;

/**
 浏览晒
 */
+(void)showStr:(NSString*)showlID;

/**
 获取求数组
 */

+ (NSMutableArray*)pickRemindArray;

/**
 浏览求
 */
+(void)pickStr:(NSString*)picklID;


/**
 获取售数组
 */

+ (NSMutableArray*)sellRemindArray;
/**
 浏览售
 */
+(void)sellStr:(NSString*)picklID;

/**
 收到消息时，播放音频
 */
+ (void)playSoundAndVibration;
/**
 消除所有红点
 */
+(void)remRemind;
@end
