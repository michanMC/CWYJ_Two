//
//  AllPalyViewController.h
//  MCCWYJ
//
//  Created by MC on 16/5/8.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "BaseViewController.h"
#import "MCplayViewController.h"
@interface AllPalyViewController : BaseViewController
@property(nonatomic,weak)MCplayViewController * delegate;

-(void)selectAlldic:(NSDictionary*)dic;


@end
