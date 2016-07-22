//
//  liulanViewController.h
//  CWYouJi
//
//  Created by MC on 15/11/9.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "BaseViewController.h"

@interface liulanViewController : BaseViewController
@property(nonatomic,strong) NSArray* imgViewArray;
@property(nonatomic,copy)NSString * titleStr;//标题
@property(nonatomic,copy)NSString * title2Str;//内容
@property(nonatomic,copy)NSString * timeStr;//时间
@property(nonatomic,copy)NSString * KeyStr;//类型
@property(nonatomic,copy)NSString * jingdianStr;//景点
@property(nonatomic,strong)NSMutableDictionary * dataDic;
@end
