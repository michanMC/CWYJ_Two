//
//  LocationsModel.m
//  MCCWYJ
//
//  Created by MC on 16/6/30.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "LocationsModel.h"
@implementation CityModel
-(instancetype)init
{
    self = [super init];
    if (self) {
        _RegionArray = [NSMutableArray array];
    }
    return self;
}


@end
@implementation RegionModel

@end

@implementation LocationsModel

-(instancetype)init
{
    self = [super init];
    if (self) {
        _CityArray = [NSMutableArray array];
    }
    return self;
}


@end
