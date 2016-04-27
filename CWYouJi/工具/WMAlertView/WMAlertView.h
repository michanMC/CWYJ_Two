//
//  WMAlertView.h
//  微秘
//
//  Created by apple on 14-8-28.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WMAlertView;
@protocol WMAlertViewDelegate <NSObject>

@optional
-(void)alertViewDidClickCancleButton:(WMAlertView *)alertView;

-(BOOL)alertViewWillClickSureButtonIsClose:(WMAlertView *)alertView;

-(void)alertViewDidClickSureButton:(WMAlertView *)alertView;

@end

@interface WMAlertView : UIView
@property (nonatomic,weak) id <WMAlertViewDelegate>delegate;
@property (nonatomic,strong) UIView *alertView;
-(void)show;
-(void)showInView:(UIView *)view;
-(void)cancel:(id)sender;
-(void)sure:(id)sender;
-(void)setNotificationKeyBoard;
@end
