//
//  pinglunModel.h
//  CWYouJi
//
//  Created by MC on 15/11/18.
//  Copyright © 2015年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "homeYJModel.h"
@interface pinglunModel : NSObject
@property(nonatomic,copy)NSString * content;
@property(nonatomic,copy)NSString * createDate;
@property(nonatomic,copy)NSString * id;
@property(nonatomic,copy)NSString * isRemindAuthor;
@property(nonatomic,copy)NSString * modifyDate;
@property(nonatomic,copy)NSString * status;
@property(nonatomic,copy)NSString * targetId;
@property(nonatomic,copy)NSString * uid;
@property(nonatomic,strong)NSDictionary * user;

@property(nonatomic,strong)YJUserModel *userModel;
@end
