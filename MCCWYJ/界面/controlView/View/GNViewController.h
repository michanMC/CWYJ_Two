//
//  GNViewController.h
//  CWYouJi
//
//  Created by MC on 16/1/15.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "BaseViewController.h"
#import "MCfenxianView.h"

@interface GNViewController : BaseViewController
@property(nonatomic,copy)NSString * adlinkurl;//国内
@property(nonatomic,strong) MCfenxianView * fenxianView;
@property(nonatomic,copy)NSString * uidStr;//

@end
