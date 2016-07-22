//
//  LocationsModel.h
//  MCCWYJ
//
//  Created by MC on 16/6/30.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegionModel : NSObject

@property(nonatomic,copy)NSString*Name;
@property(nonatomic,copy)NSString*id;
@property(nonatomic,copy)NSString*FullName;


@end

@interface CityModel : NSObject
@property(nonatomic,copy)NSString*Name;
@property(nonatomic,copy)NSString*id;
@property(nonatomic,copy)NSString*FullName;
@property(nonatomic,strong)NSArray*Region;
@property(nonatomic,strong)RegionModel*Region_Model;

@property(nonatomic,strong)NSMutableArray*RegionArray;

@end


@interface LocationsModel : NSObject
@property(nonatomic,copy)NSString*Name;
@property(nonatomic,copy)NSString*id;
@property(nonatomic,copy)NSString*FullName;
@property(nonatomic,strong)NSArray*City;
@property(nonatomic,strong)CityModel*City_modle;

@property(nonatomic,strong)NSMutableArray*CityArray;


@end
