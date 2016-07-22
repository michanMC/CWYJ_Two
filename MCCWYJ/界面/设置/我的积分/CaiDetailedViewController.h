//
//  CaiDetailedViewController.h
//  MCCWYJ
//
//  Created by MC on 16/5/27.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "BaseViewController.h"

@interface CaiDetailedViewController : BaseViewController
@property(nonatomic,weak)BaseViewController*deleGate;
@property(nonatomic,assign)NSInteger seleIndex;
@property(nonatomic,copy)NSString* startTime;
@property(nonatomic,copy)NSString* endTime;
-(void)loadData2;
-(void)RefreshHeader;

@end
