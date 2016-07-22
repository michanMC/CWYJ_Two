//
//  ContactListViewController.h
//  MCCWYJ
//
//  Created by MC on 16/6/7.
//  Copyright © 2016年 MC. All rights reserved.
//通讯录

#import "EaseUsersListViewController.h"
#import "ApplyViewController.h"

@interface ContactListViewController : BaseViewController

@property(nonatomic,assign)BOOL isSelect;
@property(nonatomic,strong)YJUserModel* userDatamodle;
@property(nonatomic,assign)BOOL issfabu;

@property(nonatomic,assign)  NSMutableArray *seleFirIDArray;

//好友请求变化时，更新好友请求未处理的个数
- (void)reloadApplyView;
//好友个数变化时，重新获取数据
- (void)reloadDataSource;

//添加好友的操作被触发
- (void)addFriendAction;

@end
