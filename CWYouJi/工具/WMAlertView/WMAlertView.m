//
//  WMAlertView.m
//  微秘
//
//  Created by apple on 14-8-28.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "WMAlertView.h"
//#import "OftenUseMethondsClass.h"
@interface WMAlertView (){
    UIView *backtView;

}

@end

@implementation WMAlertView
@synthesize alertView,delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)cancel:(id)sender{
    [self animateOut];
    if([delegate respondsToSelector:@selector(alertViewDidClickCancleButton:)])
        [delegate alertViewDidClickCancleButton:self];
}
-(void)sure:(id)sender{
    if([delegate respondsToSelector:@selector(alertViewWillClickSureButtonIsClose:)]){
        BOOL isClose = [delegate alertViewWillClickSureButtonIsClose:self];
        if(!isClose){
            return;
        }
    }
    [self animateOut];
    if([delegate respondsToSelector:@selector(alertViewDidClickSureButton:)])
        [delegate alertViewDidClickSureButton:self];
}

-(void)animateOut
{
	[UIView animateWithDuration:1.0/7.5 animations:^{
		self.transform = CGAffineTransformMakeScale(0.9, 0.9);
	} completion:^(BOOL finished) {
		[UIView animateWithDuration:1.0/15.0 animations:^{
			self.transform = CGAffineTransformMakeScale(1.1, 1.1);
		} completion:^(BOOL finished) {
			[UIView animateWithDuration:0.3 animations:^{
				self.transform = CGAffineTransformMakeScale(0.01, 0.01);
			} completion:^(BOOL finished){
				// table alert not shown anymore
                [self removeFromSuperview];
                [backtView removeFromSuperview];
                backtView = nil;
                [[NSNotificationCenter defaultCenter] removeObserver:self];
			}];
		}];
	}];
}

#define SreenWidth [[UIScreen mainScreen] bounds].size.width
#define SreenHeight [[UIScreen mainScreen] bounds].size.height

-(void)show{
     //[OftenUseMethondsClass downApplicationAllKeyboard];
    backtView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SreenWidth, SreenHeight)];
    backtView.backgroundColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.5];
    self.center = CGPointMake(SreenWidth/2, SreenHeight/2);
    self.backgroundColor = [UIColor whiteColor];
    
    UIWindow *appWindow = nil;
    if([[[UIApplication sharedApplication] windows] count] >0){
        appWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    }
    [appWindow addSubview:backtView];
    [appWindow addSubview:self];
    
	self.transform = CGAffineTransformMakeScale(0.6, 0.6);
	[UIView animateWithDuration:0.2 animations:^{
		self.transform = CGAffineTransformMakeScale(1.1, 1.1);
	} completion:^(BOOL finished){
		[UIView animateWithDuration:1.0/15.0 animations:^{
			self.transform = CGAffineTransformMakeScale(0.9, 0.9);
		} completion:^(BOOL finished){
			[UIView animateWithDuration:1.0/7.5 animations:^{
				self.transform = CGAffineTransformIdentity;
			}];
		}];
	}];
}

-(void)showInView:(UIView *)view{
    //[OftenUseMethondsClass downApplicationAllKeyboard];
    backtView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SreenWidth, SreenHeight)];
    backtView.backgroundColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.5];
    [view addSubview:backtView];
    self.center = CGPointMake(SreenWidth/2, SreenHeight/2);
    self.backgroundColor = [UIColor whiteColor];
    [view addSubview:self];
    self.transform = CGAffineTransformMakeScale(0.6, 0.6);
    [UIView animateWithDuration:0.2 animations:^{
        self.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished){
        [UIView animateWithDuration:1.0/15.0 animations:^{
            self.transform = CGAffineTransformMakeScale(0.9, 0.9);
        } completion:^(BOOL finished){
            [UIView animateWithDuration:1.0/7.5 animations:^{
                self.transform = CGAffineTransformIdentity;
            }];
        }];
    }];
    
}


-(void)setNotificationKeyBoard{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // 键盘高度变化通知，ios5.0新增的
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 5.0) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    //NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    //CGRect keyboardRect = [aValue CGRectValue];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    //float height = keyboardRect.size.height;
    CGRect filedRect = self.frame;
//    if(SystemVersion >= 7.0){
//        filedRect.origin.y = SCREEN_HEIGHT - height - self.frame.size.height;
//    }else {
//        filedRect.origin.y = SCREEN_HEIGHT - height - self.frame.size.height - 22;
//    }
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.frame = filedRect;
                     } completion:nil];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary* userInfo = [notification userInfo];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.center = CGPointMake(SreenWidth/2, SreenHeight/2);
                     } completion:nil];
}



@end
