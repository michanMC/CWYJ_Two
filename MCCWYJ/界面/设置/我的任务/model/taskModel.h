//
//  taskModel.h
//  MCCWYJ
//
//  Created by MC on 16/6/13.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface taskModel : NSObject
@property(nonatomic,copy)NSString*askTimes;
@property(nonatomic,copy)NSString*complete;
@property(nonatomic,copy)NSString*createDate;
@property(nonatomic,copy)NSString*id;
@property(nonatomic,copy)NSString*modifyDate;
@property(nonatomic,copy)NSString*times;
// * 0、绑定手机，1、分享给朋友赚积分；2、首次发布游记；3、发布游记；4、首次发布代购单；5、首次完成购买；6、首次晒单；7、首次完成接单；8、首次发布售卖单

@property(nonatomic,copy)NSString*type;
@property(nonatomic,copy)NSString*uid;


@end
