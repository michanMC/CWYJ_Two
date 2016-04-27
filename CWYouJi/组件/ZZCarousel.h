//
//  ZZCarousel.h
//  Ace
//
//  Created by AceZZ on 15/9/7.
//  Copyright (c) 2015年 cscmh. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 *  用于显示轮播中内容的View
 */

@interface ZZCarouselView : UICollectionViewCell

@property (strong, nonatomic) UIImageView *imageView;
//@property (strong, nonatomic) UILabel *title;

@end

@interface ZZCarouselPageControlOfNumber : UIView

@property (assign,nonatomic) NSInteger currentPage;
@property (strong,nonatomic) UILabel *pageControl;

@end


/*
 *  delegate
 */
@class ZZCarousel;

@protocol ZZCarouselDelegate <NSObject>

@required
/*
 *  此方法为 ZZCarousel 轮播内容的数量
 */
- (NSInteger)numberOfZZCarousel:(ZZCarousel *)wheel;
/*
 *  此方法为 用于ZZCarousel 轮播内容的显示
 */
- (ZZCarouselView *)zzcarousel:(UICollectionView *)zzcarousel  viewForItemAtIndex:(NSIndexPath*)index itemsIndex:(NSInteger)itemsIndex identifire:(NSString *)identifire ZZCarousel:(ZZCarousel*)zZCarousel;
@optional
/*
 *  此方法为 用于ZZCarousel 轮播的点击方法
 */
- (void)zzcarouselScrollView:(ZZCarousel *)zzcarouselScrollView didSelectItemAtIndex:(NSInteger)index;

@end

typedef NS_ENUM(NSInteger, ZZCarouselPageType)
{
    ZZCarouselPageTypeOfNone,               //默认系统 UIPageControl 样式
    ZZCarouselPageTypeOfNumber,             //自定义熟数字样式 PageControl
};



@interface ZZCarousel : UIView

@property (nonatomic, weak) id<ZZCarouselDelegate> delegate;
@property (nonatomic, assign) CGFloat carouseScrollTimeInterval;
@property (nonatomic, readonly) NSInteger numberOfItems;

/*
 *  设置系统默认 UIPageControl 的位置、 背景颜色 、指示器顶层颜色 、指示器底层颜色
 */
@property (nonatomic, assign) CGRect pageControlFrame;
//两种样式的PageControl 共用背景颜色的属性
@property (nonatomic, strong) UIColor *pageControlBackGroundColor;
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;
@property (nonatomic, assign) NSInteger pageControlOfNumberCurrentTotal;

/*
 *  当PageControl 为显示数字类型时 有如下属性
 */

//设置数字类型 PageControl 的字体
@property (nonatomic, strong) UIFont *pageControlOfNumberFont;
@property (nonatomic, strong) UIColor *pageContolOfNumberFontColor;


//设置是否使用自动滚动
@property (nonatomic, assign) BOOL isAutoScroll;

@property (nonatomic, assign) ZZCarouselPageType pageType;


/*
 *  重用方法
 */
-(void)reloadData;

@end
