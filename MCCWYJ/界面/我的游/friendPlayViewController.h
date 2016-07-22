//
//  friendPlayViewController.h
//  MCCWYJ
//
//  Created by MC on 16/5/8.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "BaseViewController.h"
#import "MCplayViewController.h"
@interface friendPlayViewController : BaseViewController
@property(nonatomic,weak)MCplayViewController * delegate;
-(void)selectfridic:(NSDictionary*)dic;

@end
