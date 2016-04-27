//
//  WMLabelAlertView.m
//  微秘
//
//  Created by apple on 14-8-28.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "WMLabelAlertView.h"
//#import "WMColorManager.h"

@interface WMLabelAlertView (){
    __weak UIView *contentView;
}

@end

@implementation WMLabelAlertView
@synthesize titleLabel;
@synthesize lineLabel;
@synthesize contentLabel;
@synthesize leftButton;
@synthesize rightButton;
@synthesize propertyLabel;

-(id)initWithTitle:(NSString *)title content:(NSString *)content sureButtonTitle:(NSString *)buttonTitle{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"WMLabelAlertView" owner:nil options:nil];
    self = [array objectAtIndex:0];
    propertyLabel.hidden = YES;
    titleLabel.text = title;
    //lineLabel.backgroundColor = [WMColorManager getCellLineColor];
    contentLabel.text = content;
    [rightButton setTitle:buttonTitle forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchUpInside];
    return self;
}

-(id)initWithTitle:(NSString *)title contentView:(UIView *)cacheContentView sureButtonTitle:(NSString *)buttonTitle{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"WMLabelAlertView" owner:nil options:nil];
    self = [array objectAtIndex:0];
    CGRect Frame = titleLabel.frame;
    Frame.origin.x = propertyLabel.frame.size.width + propertyLabel.frame.origin.x;
    Frame.size.width = Frame.size.width - Frame.origin.x;
    titleLabel.frame = Frame;
    titleLabel.text = title;
    //lineLabel.backgroundColor = [WMColorManager getCellLineColor];
    contentLabel.hidden = YES;
    [rightButton setTitle:buttonTitle forState:UIControlStateNormal];
    
    contentView = cacheContentView ;
    [self reloadContentAlertView];
    return self;
}

-(id)initWithTitle:(NSString *)title contentView:(UIView *)cacheContentView{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"WMLabelAlertView" owner:nil options:nil];
    self = [array objectAtIndex:0];
    propertyLabel.hidden = YES;
    titleLabel.textColor = [UIColor lightGrayColor];
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    //lineLabel.backgroundColor = [WMColorManager getCellLineColor];
    contentLabel.hidden = YES;
    [rightButton setTitle:@"确定" forState:UIControlStateNormal];
    contentView = cacheContentView ;
    [self reloadContentAlertView];
    return self;
}


-(void)reloadContentAlertView{
    contentView.frame = CGRectMake((self.frame.size.width - contentView.frame.size.width)/2, lineLabel.frame.size.height + lineLabel.frame.origin.y, contentView.frame.size.width, contentView.frame.size.height);
    
    [self addSubview:contentView];
    if ([contentView isKindOfClass:[UITableView class]]) {
        UITableView *table = (UITableView *)contentView;
        [table reloadData];
    }
    //contentView.userInteractionEnabled = NO;
    CGRect leftFrame = leftButton.frame;
    leftFrame.origin.y = contentView.frame.origin.y + contentView.frame.size.height;
    leftButton.frame = leftFrame;
    CGRect rightFrame = rightButton.frame;
    rightFrame.origin.y = contentView.frame.origin.y + contentView.frame.size.height;
    rightButton.frame = rightFrame;
    
    [leftButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchUpInside];
    self.frame = CGRectMake(0, 0, self.frame.size.width, leftFrame.origin.y + leftFrame.size.height);
}

-(void)dealloc {
    [contentView removeFromSuperview];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)setCacheContentView:(UIView *)cacheContentView
{
    contentView = cacheContentView ;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
