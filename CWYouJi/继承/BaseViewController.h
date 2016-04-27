

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "NetworkManager.h"
#import <ShareSDK/ShareSDK.h>
typedef void(^BarButtonItemActionBlock)(void);

typedef NS_ENUM(NSInteger, BarbuttonItemStyle) {
    BarbuttonItemStyleSetting = 0,
    BarbuttonItemStyleMore,
    BarbuttonItemStyleCamera,
};

@interface BaseViewController : UIViewController
//{
//   
//}
@property (nonatomic,strong) NetworkManager *requestManager;
@property (nonatomic , strong)NSDictionary * classifyDic;
/**
 用户语言
 */
@property(nonatomic,assign)BOOL AppleLanguages;//1为zh-Hans-US，其他都是英语

/**
 用户id
 */
@property(nonatomic,copy)NSString*  userid;//用户账号
/**
 用户手机号
 */
@property(nonatomic,copy)NSString*  userphone;//

/**
 用户sessionId
 */
@property(nonatomic,copy)NSString*  userSessionId;//

/**
 用户expire
 */
@property(nonatomic,copy)NSString*  userExpire;//
/**
 用户nickname
 */
@property(nonatomic,copy)NSString*  userNickname;//
/**
 用户sex
 */
@property(nonatomic,copy)NSString*  userSex;//


/**
 用户thumbnail
 */
@property(nonatomic,copy)NSString*  userThumbnail;//




-(void)ColorNavigation;

/**
 *  统一设置背景图片
 *
 *  @param backgroundImage 目标背景图片
 */
- (void)setupBackgroundImage:(UIImage *)backgroundImage;

/**
 *  push新的控制器到导航控制器
 *
 *  @param newViewController 目标新的控制器对象
 */
- (void)pushNewViewController:(UIViewController *)newViewController;

/**
 *  显示加载的loading，没有文字的
 */
- (void)showLoading;
/**
 *  显示带有某个文本加载的loading
 *
 *  @param text 目标文本
 */
- (void)showLoading:(BOOL)show AndText:(NSString *)text;

- (void)showAllTextDialog:(NSString *)title;

/**
 *  显示成功的HUD
 */
- (void)showSuccess;
/**
 *  显示错误的HUD
 */
- (void)showError;
-(void)stopshowLoading;
- (void)configureBarbuttonItemStyle:(BarbuttonItemStyle)style action:(BarButtonItemActionBlock)action;
/**
 *  分享
 */
-(void)actionFenxian:(SSDKPlatformType)PlatformType PopToRoot:(BOOL)isPopToRoot SsDic:(NSMutableDictionary*)ssdic;
@end
