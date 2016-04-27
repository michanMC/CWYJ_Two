//
//  WMLabelAlertView.h
//  微秘
//
//  Created by apple on 14-8-28.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "WMAlertView.h"
@interface WMLabelAlertView : WMAlertView
@property (nonatomic,weak) IBOutlet UILabel *titleLabel;
@property (nonatomic,weak) IBOutlet UILabel *lineLabel;
@property (nonatomic,weak) IBOutlet UILabel *contentLabel;
@property (nonatomic,weak) IBOutlet UIButton *leftButton;
@property (nonatomic,weak) IBOutlet UIButton *rightButton;
@property (nonatomic,weak) IBOutlet UILabel *propertyLabel;
@property (nonatomic,strong) UIView * cacheContentView;

-(id)initWithTitle:(NSString *)title content:(NSString *)content sureButtonTitle:(NSString *)buttonTitle;
-(id)initWithTitle:(NSString *)title contentView:(UIView *)contentView sureButtonTitle:(NSString *)buttonTitle;

-(id)initWithTitle:(NSString *)title contentView:(UIView *)cacheContentView;
-(void)cancel:(id)sender;
@end
