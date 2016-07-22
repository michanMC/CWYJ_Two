//
//  MCScanViewController.h
//  MCCWYJ
//
//  Created by MC on 16/6/29.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "BaseViewController.h"

@protocol MCScanViewDelegate <NSObject>

-(void)MCScanViewStr:(NSString*)ScanStr;

@end


@interface MCScanViewController : BaseViewController
@property(weak,nonatomic)id<MCScanViewDelegate>delegate;
@property(nonatomic,copy)NSString * teypIndex;//1快递
@end
