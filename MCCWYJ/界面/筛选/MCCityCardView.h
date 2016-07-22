//
//  MCCityCardView.h
//  MCCWYJ
//
//  Created by MC on 16/6/8.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCCityCardView : UIView

@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,copy)NSString *Citystr;

- (void)showInWindow;

@end
