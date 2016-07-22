//
//  friendslistModel.h
//  MCCWYJ
//
//  Created by MC on 16/6/7.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "homeYJModel.h"
@interface friendslistModel : NSObject

@property(nonatomic,strong)YJUserModel * userModel;
@property(nonatomic,copy)NSString*friendUid;
@property(nonatomic,copy)NSString*createDate;
@property(nonatomic,copy)NSString*id;
@property(nonatomic,copy)NSString*status;
@property(nonatomic,strong)NSDictionary*friend;
@property(nonatomic,strong)NSString*nameKey;
@property(nonatomic,strong)NSString*hid;

//recommendFriend.json
@property(nonatomic,strong)NSString*thumbnail;
@property(nonatomic,strong)NSString*nickname;
@property(nonatomic,strong)NSString*uid;
@property(nonatomic,strong)NSString*desc;
@property(nonatomic,strong)NSString*isApply;
@property(nonatomic,assign)BOOL isSele;

@end

