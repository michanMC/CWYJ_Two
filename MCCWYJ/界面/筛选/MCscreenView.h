//
//  MCscreenView.h
//  MCCWYJ
//
//  Created by MC on 16/5/23.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCscreenViewDelegate <NSObject>

-(void)MCscreenselsctDic:(NSMutableDictionary*)selectDic;
-(void)MCscreenhidden;

@end



@interface MCscreenView : UIView
@property(nonatomic,weak)id<MCscreenViewDelegate>delegate;

-(void)IsMYBuy:(BOOL)isMYBuy DataDic:(NSDictionary*)dic;


- (void)showInWindow;

@end
