//
//  HYViewController.h
//  自定义导航控制器
//
//  Created by Sekorm on 16/4/22.
//  Copyright © 2016年 HelloYeah. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HYViewController : BaseViewController

- (void)setKeyScrollView:(UIScrollView * )keyScrollView scrolOffsetY:(CGFloat)scrolOffsetY options:(HYHidenControlOptions)options;

@end
