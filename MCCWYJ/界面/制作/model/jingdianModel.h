//
//  jingdianModel.h
//  CWYouJi
//
//  Created by MC on 15/11/21.
//  Copyright © 2015年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface jingdianModel : NSObject
@property(nonatomic,copy)NSString * address;
@property(nonatomic,copy)NSString * city;
@property(nonatomic,copy)NSString * country;
@property(nonatomic,copy)NSString * countryId;
@property(nonatomic,copy)NSString * createDate;
@property(nonatomic,copy)NSString * descEN;
@property(nonatomic,copy)NSString * descZh;
@property(nonatomic,copy)NSString * favCount;
@property(nonatomic,copy)NSString * id;
@property(nonatomic,copy)NSString * locGeo;
@property(nonatomic,copy)NSString * locLat;
@property(nonatomic,copy)NSString * locLng;

@property(nonatomic,copy)NSString * modifyDate;
@property(nonatomic,copy)NSString * nameCH;
@property(nonatomic,copy)NSString * nameEn;
@property(nonatomic,copy)NSString * parentId;
@property(nonatomic,copy)NSString * picture;
@property(nonatomic,copy)NSString * province;
@property(nonatomic,copy)NSString * searchCount;
@property(nonatomic,copy)NSString * sourceMap;
@property(nonatomic,copy)NSString * stampCount;

@property(nonatomic,copy)NSString * originalGrade;
@property(nonatomic,assign)NSInteger  trend;
@property(nonatomic,copy)NSString * currentGrade;



@property(nonatomic,copy)NSString * nameChs;
//@property(nonatomic,copy)NSString * nameEn;
@property(nonatomic,copy)NSString * status;


@end
