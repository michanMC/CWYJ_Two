//
//  travelModel.h
//  CWYouJi
//
//  Created by MC on 15/11/18.
//  Copyright © 2015年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "homeYJModel.h"
@interface travelModel : NSObject
@property(nonatomic,copy)NSString * createDate;
@property(nonatomic,copy)NSString * id;
@property(nonatomic,copy)NSString * uid;

@property(nonatomic,copy)NSString * targetId;
@property(nonatomic,strong)NSDictionary * travel;
@property(nonatomic,strong)homeYJModel *homeModel;

@property(nonatomic,assign)BOOL isselect;


@end
