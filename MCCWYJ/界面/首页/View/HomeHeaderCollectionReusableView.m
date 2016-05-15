//
//  HomeHeaderCollectionReusableView.m
//  MCCWYJ
//
//  Created by MC on 16/5/7.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "HomeHeaderCollectionReusableView.h"

@implementation HomeHeaderCollectionReusableView


-(void)prepareADUI{
//    self.backgroundColor = [UIColor whiteColor];
    for (UIView* obj in self.subviews)
        [obj removeFromSuperview];

    _adView  = [[ZZCarousel alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 150*MCHeightScale)];
    /*
     *   carouseScrollTimeInterval  ---  此属性为设置轮播多长时间滚动到下一张
     */
    _adView.carouseScrollTimeInterval = 5.0f;
    
    
    
    // 代理
    _adView.delegate = self;
    
    /*
     *   isAutoScroll  ---  默认为NO，当为YES时 才能使轮播进行滚动
     */
    _adView.isAutoScroll = YES;
    
    /*
     *   pageType  ---  设置轮播样式 默认为系统样式。ZZCarousel 中封装了 两种样式，另外一种为数字样式
     */
    _adView.pageType = ZZCarouselPageTypeOfNone;
    
    /*
     *   设置UIPageControl 在轮播中的位置、系统默认的UIPageControl 的顶层颜色 和底层颜色已经背景颜色
     */
    _adView.pageControlFrame = CGRectMake((Main_Screen_Width - 60 ) / 2, _adView.frame.size.height - 20, 60, 10);
    
    
    _adView.pageIndicatorTintColor = RGBCOLOR(250, 150, 110);//[UIColor whiteColor];
    _adView.currentPageIndicatorTintColor = RGBCOLOR(251, 78, 9);
    _adView.pageControlBackGroundColor = [UIColor whiteColor];
    
    /*
     *   设置数字样式的 UIPageControl 中的字体和字体颜色。 背景颜色仍然按照上面pageControlBackGroundColor属性来设置
     */
    _adView.pageControlOfNumberFont = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    _adView.pageContolOfNumberFontColor = [UIColor whiteColor];
    
    [self addSubview:_adView];
    [_adView reloadData];

    
    
    
    
}
#pragma mark --- ZZCarouselDelegate


-(NSInteger)numberOfZZCarousel:(ZZCarousel *)wheel
{
//    if (_bannerArray.count) {
//        return _bannerArray.count;
//    }
    return 3;
}
-(ZZCarouselView *)zzcarousel:(UICollectionView *)zzcarousel viewForItemAtIndex:(NSIndexPath *)index itemsIndex:(NSInteger)itemsIndex identifire:(NSString *)identifire ZZCarousel:(ZZCarousel *)zZCarousel
{
    /*
     *  index参数         ※ 注意
     */
    ZZCarouselView *cell = [zzcarousel dequeueReusableCellWithReuseIdentifier:identifire forIndexPath:index];
    
    if (!cell) {
        cell = [[ZZCarouselView alloc]init];
    }
    //    cell.title.text = [_imagesGroup objectAtIndex:indexPath.row];
    //    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:@"图片地址"]];
    
    /*
     *  itemsIndex 参数   ※ 注意
     */
//    if (_bannerArray.count) {
//        NSDictionary * model = [_bannerArray objectAtIndex:itemsIndex];
//        
//        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model[@"image"]] placeholderImage:[UIImage imageNamed:@"home_banner_default-chart"]];
//    }
//    else
    
        cell.imageView.image = [UIImage imageNamed:@"home_banner"];
    //
    
    return cell;
}

//点击方法

-(void)zzcarouselScrollView:(ZZCarousel *)zzcarouselScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    //[self showAllTextDialog:[NSString stringWithFormat:@"点击了 第%ld张",(long)index]];
    //    if(_bannerArray.count > index ){
    //        NSDictionary * model = [_bannerArray objectAtIndex:index];
    //
    //        Home_LunBoGuangGao_Web *vc = [[Home_LunBoGuangGao_Web alloc]init];
    //        vc.adlinkurl = model[@"link"];
    //        [self pushNewViewController:vc];
    //        
    //    }
}



-(void)prepareMeUI:(NSString*)str{
    for (UIView* obj in self.subviews)
        [obj removeFromSuperview];
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, Main_Screen_Width - 10, 40)];
    lbl.text = str;
    lbl.font = AppFont;
    lbl.textColor = AppCOLOR;
    [self addSubview:lbl];
    _modeBtn = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width - 10 - 30 , 5, 30, 30)];
    [_modeBtn setImage:[UIImage imageNamed:@"home_icon_more"] forState:0];
    [self addSubview:_modeBtn];

    
}

-(void)prepareUI:(NSString*)str{
    for (UIView* obj in self.subviews)
        [obj removeFromSuperview];
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 4, 20)];
    lineView.backgroundColor = AppCOLOR;
    ViewRadius(lineView, 2);
    [self addSubview:lineView];

    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(10+4 + 10, 0, 200, 40)];
    lbl.text = str;
   lbl.font = [UIFont systemFontOfSize:16];
    lbl.textColor = [UIColor darkTextColor];
    [self addSubview:lbl];

    
    
}










@end
