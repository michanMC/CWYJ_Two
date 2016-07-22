//
//  zuopinQxTableViewCell.h
//  CWYouJi
//
//  Created by MC on 15/11/7.
//  Copyright © 2015年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MCbackButton;
@interface zuopinQxTableViewCell : UITableViewCell
@property(nonatomic,strong)MCbackButton *shouchangBtn;
@property(nonatomic,strong) UIButton *headimgBtn;

@property(nonatomic,assign)BOOL ishiddenShouC;

@property(nonatomic,copy)NSString *titleStr;
@property(nonatomic,copy)NSString *subTitleStr;
@property(nonatomic,copy)NSString *dingweiStr;
@property(nonatomic,copy)NSString *timeStr;
@property(nonatomic,copy)NSString *keyImgStr;
@property(nonatomic,copy)NSString *tuijanImgStr;
@property(nonatomic,copy)NSString *dataStr;
@property(nonatomic,copy)NSString *headimgStr;
@property(nonatomic,copy)NSString *nameLStr;
@property(nonatomic,strong)UIButton * gengduoBtn;
@property(nonatomic,assign)BOOL isgengduan;
@property(nonatomic,strong) UIImageView *gengimg;
;
@property(nonatomic,assign)BOOL isshouchang;

@end
