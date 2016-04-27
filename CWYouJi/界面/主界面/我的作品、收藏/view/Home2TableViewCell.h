//
//  HomeTableViewCell.h
//  CWYouJi
//
//  Created by MC on 15/10/31.
//  Copyright © 2015年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Home2TableViewCell : UITableViewCell

@property(nonatomic,assign)BOOL isEit;
@property(nonatomic,strong)UIButton * deleteBtn;
@property(nonatomic,strong)UIImageView *tuijianView;
;

@property(nonatomic,copy)NSString * imgViewStr;
@property(nonatomic,copy)NSString * headimgStr;
@property(nonatomic,copy)NSString * leixingStr;
@property(nonatomic,assign)BOOL  istuijian;
@property(nonatomic,copy)NSString * titleStr;
@property(nonatomic,copy)NSString * title2Str;
@property(nonatomic,copy)NSString * dingweiStr;
@property(nonatomic,copy)NSString * badgeStr;
@property(nonatomic,copy)NSString * nameStr;
@property(nonatomic,copy)NSString * neirongStr;
@property(nonatomic,copy)NSString * timeStr;
@property(nonatomic,copy)NSString * jlStr;



@end
