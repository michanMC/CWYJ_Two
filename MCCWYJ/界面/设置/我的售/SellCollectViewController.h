//
//  SellCollectViewController.h
//  MCCWYJ
//
//  Created by MC on 16/6/3.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "BaseViewController.h"
#import "MySellViewController.h"
@interface SellCollectViewController : BaseViewController
-(void)actionEdit;
@property(nonatomic,weak)MySellViewController * delegate;

@end
