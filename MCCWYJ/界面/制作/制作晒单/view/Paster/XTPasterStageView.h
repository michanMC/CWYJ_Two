//
//  XTPasterStageView.h
//  XTPasterManager
//
//  Created by apple on 15/7/8.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MakeshaidanViewController.h"
@interface XTPasterStageView : UIView

@property (nonatomic,strong) UIImage *originImage ;
@property (nonatomic,weak)MakeshaidanViewController *delegate;
- (instancetype)initWithFrame:(CGRect)frame ;
- (void)addPasterWithImg:(UIImage *)imgP ;
- (UIImage *)doneEdit ;

-(void)clearAllOnFirst;//    [self clearAllOnFirst] ;



@property(nonatomic,assign)BOOL isLbl;

@end
