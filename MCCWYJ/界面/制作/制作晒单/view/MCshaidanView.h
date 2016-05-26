//
//  MCshaidanView.h
//  MCCWYJ
//
//  Created by MC on 16/5/25.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MakeshaidanViewController.h"
@interface MCshaidanView : UIView

@property(nonatomic,weak)MakeshaidanViewController *delegate;


- (void)showInWindow;

@end
