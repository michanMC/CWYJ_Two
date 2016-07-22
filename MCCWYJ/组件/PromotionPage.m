//
//  PromotionPage.m
//  ZFPromotionPage
//
//  Created by 张锋 on 16/6/23.
//  Copyright © 2016年 张锋. All rights reserved.
//

#import "PromotionPage.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"

#define kS_W [UIScreen mainScreen].bounds.size.width
#define kS_H [UIScreen mainScreen].bounds.size.height

static NSInteger tapCount = 0;
static CGFloat const logoH = 150.0f; // logo图片高度

@interface PromotionPage ()
@property (nonatomic, strong) UIDynamicAnimator *ani;
@property (nonatomic, strong) UIGravityBehavior *gra;
@property (nonatomic, strong) UICollisionBehavior *col;
@property (nonatomic, strong) UIImageView *logoImgView;
@property (nonatomic, strong) UIImageView *proImgView;

/** 广告URL地址 */
@property (nonatomic, strong) NSURL *proURL;

/** 下边的APP或者公司Logo图片 */
@property (nonatomic, strong) UIImage *logoImg;

@property (nonatomic, strong) UIButton *jumpBtn;

@end

@implementation PromotionPage

+ (instancetype)promotionPageWithLoginImage:(UIImage *)logoImage promotionURL:(NSURL *)promotionURL
{
    return [[self alloc] initWithImage:(UIImage *)logoImage promotionURL:(NSURL *)promotionURL];
}

- (instancetype)initWithImage:(UIImage *)logoImage promotionURL:(NSURL *)promotionURL
{
    CGRect frame = CGRectMake(0, 0, kS_W, kS_H);
    self = [super initWithFrame:frame];
    if (self) {
        _proURL = promotionURL;
        _logoImg = logoImage;
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews
{
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    BOOL isExist = [mgr cachedImageExistsForURL:self.proURL];
    if (isExist) {
        NSLog(@"图片存在");
        [self showPromotionPage];
    }else {
        [self hidePromotionPage];
        // 如果是wifi环境则下载推广图片，否则不下载
            NSLog(@"图片不存在，即将下载");
        [mgr downloadImageWithURL:self.proURL options:SDWebImageTransformAnimatedImage progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            
            NSLog(@"图片下载完成");

        }];
        
    }
}

- (UIImageView *)logoImgView
{
    if (!_logoImgView) {
        _logoImgView = [[UIImageView alloc] init];
        _logoImgView.userInteractionEnabled = YES;
        _logoImgView.frame = CGRectMake(0, kS_H-logoH, kS_W, logoH);
        _logoImgView.image = self.logoImg;
    }
    return _logoImgView;
}

- (UIImageView *)proImgView
{
    if (!_proImgView) {
        _proImgView = [[UIImageView alloc] init];
        _proImgView.frame = CGRectMake(0, -(kS_H), kS_W, kS_H);
        [_proImgView sd_setImageWithURL:self.proURL];
    }
    return _proImgView;
}

- (UIButton *)jumpBtn
{
    if (!_jumpBtn) {
        _jumpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _jumpBtn.backgroundColor = [UIColor orangeColor];
        _jumpBtn.frame = CGRectMake(kS_W - 75, 110, 60, 30);
        _jumpBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [_jumpBtn addTarget:self action:@selector(startCountDown) forControlEvents:UIControlEventTouchUpInside];
        [_jumpBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    return _jumpBtn;
}

- (void)startCountDown
{
    tapCount ++;
    if (tapCount >= 2) {
        [self animationWillFinishLoad];
        return;
    }
    
#pragma mark - 在这里修改广告时间
    __block int timeout = 4;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self animationWillFinishLoad];
            });
            
        }else{
            NSString *strTime = [NSString stringWithFormat:@"%d", timeout];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.jumpBtn setTitle:[NSString stringWithFormat:@"%@ | 跳过",strTime] forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

- (void)animationWillFinishLoad
{
    [self hidePromotionPage];
    
    if (self.finishBlock) {
        self.finishBlock();
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(promotionPageHasFinishLaunch)]) {
        [self.delegate promotionPageHasFinishLaunch];
    }
}

- (void)hidePromotionPage
{
    [UIView animateWithDuration:1.0f animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - 如果推广图片存在，那么加载推广页
- (void)showPromotionPage
{
//    [self addSubview:self.logoImgView];
    [self addSubview:self.proImgView];
    [self.logoImgView addSubview:self.jumpBtn];
    
    self.ani = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    NSArray *obj = @[self.proImgView];
    
    self.gra = [[UIGravityBehavior alloc] initWithItems:obj];
    self.gra.magnitude = 6.0f;
    
    self.col = [[UICollisionBehavior alloc] initWithItems:obj];
    [self.col addBoundaryWithIdentifier:@"boundaryLine" fromPoint:CGPointMake(0, kS_H) toPoint:CGPointMake(kS_W, kS_H)];
    
    UIDynamicItemBehavior *hav = [[UIDynamicItemBehavior alloc] initWithItems:obj];
    [hav setElasticity:0.5f];
    
    [self.ani addBehavior:self.gra];
    [self.ani addBehavior:self.col];
    [self.ani addBehavior:hav];
}

@end
