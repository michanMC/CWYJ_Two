//
//  MCDrawBackViewController.h
//  MCCWYJ
//
//  Created by MC on 16/7/14.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "BaseViewController.h"
#import "MCBuyModlel.h"
@interface MCDrawBackViewController : BaseViewController
@property(nonatomic,copy)NSString *awardid;
@property(nonatomic,copy)NSString *orderId;
@property(nonatomic,copy)NSString *priceStr;

-(void)deletearray:(NSMutableArray*)arr;

@end
