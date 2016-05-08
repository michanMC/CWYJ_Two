//
//  HomeHeaderCollectionReusableView.h
//  MCCWYJ
//
//  Created by MC on 16/5/7.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZCarousel.h"

@interface HomeHeaderCollectionReusableView : UICollectionReusableView <ZZCarouselDelegate>


@property(nonatomic,strong)ZZCarousel* adView;

-(void)prepareADUI;

-(void)prepareUI:(NSString*)str;


@property(nonatomic,strong)UIButton*modeBtn;
-(void)prepareMeUI:(NSString*)str;


@end
