//
//  MyshouchangViewController.h
//  CWYouJi
//
//  Created by MC on 15/11/1.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "BaseViewController.h"

@interface MyshouchangViewController : BaseViewController
@property(nonatomic,assign)BOOL isquanxuan;
@property(nonatomic,strong)UIButton * deleteBtn;
@property(nonatomic,strong)NSMutableArray * deleArray;

-(void)actionBianji;
@end
