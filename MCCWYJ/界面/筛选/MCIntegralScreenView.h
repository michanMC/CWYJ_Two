//
//  MCIntegralScreenView.h
//  MCCWYJ
//
//  Created by MC on 16/6/1.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCscreenView.h"
@interface MCIntegralScreenView : UIView
@property(nonatomic,weak)id<MCscreenViewDelegate>delegate;
@property(nonatomic,assign)NSInteger seleIndex;
@property(nonatomic,copy)NSString* startTime;
@property(nonatomic,copy)NSString* endTime;
@end
