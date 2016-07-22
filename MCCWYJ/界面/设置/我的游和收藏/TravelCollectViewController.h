//
//  TravelCollectViewController.h
//  MCCWYJ
//
//  Created by MC on 16/6/2.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "BaseViewController.h"
#import "MyTravelViewController.h"
@interface TravelCollectViewController : BaseViewController
-(void)actionEdit;
@property(nonatomic,weak)MyTravelViewController * delegate;


@end
