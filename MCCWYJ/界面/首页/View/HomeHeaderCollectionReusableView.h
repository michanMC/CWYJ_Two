//
//  HomeHeaderCollectionReusableView.h
//  MCCWYJ
//
//  Created by MC on 16/5/7.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZCarousel.h"
#import "MChomeViewController.h"

@interface HomeHeaderCollectionReusableView : UICollectionViewCell <ZZCarouselDelegate>

-(instancetype)initWithFrame:(CGRect)frame Str:(NSString*)str;



@property(nonatomic,weak)MChomeViewController * delgateSelf;

@property(nonatomic,strong)ZZCarousel* adView;

-(void)prepareADUI:(NSMutableArray*)array;

-(void)prepareUI:(NSString*)str;
-(void)prepareREMUI;

@property(nonatomic,strong)UIButton*modeBtn;
-(void)prepareMeUI:(NSString*)str;


@end
