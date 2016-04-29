//
//  ZZCarousel.m
//  Ace
//
//  Created by AceZZ on 15/9/7.
//  Copyright (c) 2015年 cscmh. All rights reserved.
//

#import "ZZCarousel.h"
/*
 *  UICollectionViewCell
 */
@implementation ZZCarouselView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        //_imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imageView];
        
//        _title = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height - 20, frame.size.width, 20)];
//        _title.backgroundColor = [UIColor blackColor];
//        _title.alpha = 0.7;
//        _title.textColor = [UIColor whiteColor];
//        [self.contentView addSubview:_title];
    }
    return self;
}

@end

@implementation ZZCarouselPageControlOfNumber

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _pageControl = [[UILabel alloc]initWithFrame:CGRectMake(5, 3, self.frame.size.width - 10, self.frame.size.height - 6)];
        _pageControl.backgroundColor = [UIColor clearColor];
        _pageControl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_pageControl];
    }
    return self;
}

@end


/*
 *  轮播
 */

#define DY 1000

@interface ZZCarousel()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *carousel;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UIPageControl *pageControl;
//自定义 UIPageControl
@property (nonatomic, strong) ZZCarouselPageControlOfNumber *pageControlOfNumber;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger realItems;
@end

@implementation ZZCarousel

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        // 创建UI 方法
        
        [self createCarouselUI];
        
        //重用 UICollectionView
    }
    return self;
}

/*
 *  创建View 中 UI
 */
-(void)createCarouselUI
{
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = (CGSize){self.frame.size.width,self.frame.size.height};
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _carousel = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:_flowLayout];
    _carousel.backgroundColor = [UIColor clearColor];
    _carousel.pagingEnabled = YES;
    _carousel.scrollEnabled = YES;
    _carousel.showsHorizontalScrollIndicator = NO;
    _carousel.showsVerticalScrollIndicator = NO;
    [_carousel registerClass:[ZZCarouselView class] forCellWithReuseIdentifier:@"ZZWheelCell"];
    _carousel.dataSource = self;
    _carousel.delegate = self;
    [self addSubview:_carousel];
    
}


/*
 *  当使用时候执行pageControlFrame 属性时则 创建 UIPageControl 指示器
    并添加到ZZCarousel显示
 */

-(void)setPageControlFrame:(CGRect)pageControlFrame
{
    //创建指示器
    if (_pageType == 0) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.frame = pageControlFrame;
        _pageControl.currentPage = 0;
        [self addSubview:_pageControl];
    }else if (_pageType == 1){
        _pageControlOfNumber = [[ZZCarouselPageControlOfNumber alloc]initWithFrame:pageControlFrame];
        _pageControlOfNumber.currentPage = 0;
        [self addSubview:_pageControlOfNumber];
        
    }
    
}
-(void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
{
    _pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
}
-(void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor
{
    _pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}
-(void)setPageControlBackGroundColor:(UIColor *)pageControlBackGroundColor
{
    if (_pageType == 0) {
        _pageControl.backgroundColor = [UIColor clearColor];
    }else if (_pageType == 1){
        _pageControlOfNumber.backgroundColor = pageControlBackGroundColor;
    }
    
}
-(void)setPageControlOfNumberFont:(UIFont *)pageControlOfNumberFont
{
    _pageControlOfNumber.pageControl.font = pageControlOfNumberFont;
}
-(void)setPageContolOfNumberFontColor:(UIColor *)pageContolOfNumberFontColor
{
    _pageControlOfNumber.pageControl.textColor = pageContolOfNumberFontColor;
}



-(void)reloadData
{
    if (_isAutoScroll == YES) {
        [self createTimer];
    }
    
    if (_pageType == 0) {
        _pageControl.numberOfPages = [_delegate numberOfZZCarousel:self];
    }else if(_pageType == 1){
        _pageControlOfNumberCurrentTotal = [_delegate numberOfZZCarousel:self];
        _pageControlOfNumber.pageControl.text = [NSString stringWithFormat:@"%d / %ld",1,_pageControlOfNumberCurrentTotal];
    }
    
    _numberOfItems = [_delegate numberOfZZCarousel:self];
    
    _realItems = _numberOfItems *DY;
    
    [self.carousel reloadData];
    
    if (_carousel.contentOffset.x == 0 &&  _realItems) {
        [_carousel scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_realItems * 0.5 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _realItems;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger itemIndex = indexPath.row % _numberOfItems;
    return [_delegate zzcarousel:collectionView viewForItemAtIndex:indexPath itemsIndex:itemIndex identifire:@"ZZWheelCell" ZZCarousel:self];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)index
{
    if ([self.delegate respondsToSelector:@selector(zzcarouselScrollView:didSelectItemAtIndex:)]) {
        [self.delegate zzcarouselScrollView:self didSelectItemAtIndex:index.row % _numberOfItems];
    }
}


/*
 *  创建定时器
 */

- (void)createTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:_carouseScrollTimeInterval target:self selector:@selector(autoCarouselScroll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

/*
 * 执行定时器方法
 */

- (void)autoCarouselScroll
{
    if (0 == _realItems) return;
    int currentIndex = _carousel.contentOffset.x / _flowLayout.itemSize.width;
    int startIndex = currentIndex + 1;
    if (startIndex == _realItems) {
        startIndex = _realItems * 0.5;
        [_carousel scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:startIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    [_carousel scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:startIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    int itemIndex = (scrollView.contentOffset.x + self.carousel.frame.size.width * 0.5) / self.carousel.frame.size.width;
    if (!self.numberOfItems) return;
    int indexOnPageControl = itemIndex % self.numberOfItems;
    
    if (_pageType == 0) {
        _pageControl.currentPage = indexOnPageControl;
    }else if (_pageType == 1){
        _pageControlOfNumber.pageControl.text = [NSString stringWithFormat:@"%d / %ld",indexOnPageControl+1,_pageControlOfNumberCurrentTotal];
        self.pageControlOfNumber.currentPage = indexOnPageControl;
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer invalidate];
    _timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self createTimer];
}


@end
