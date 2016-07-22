//
//  homeYJModel.m
//  CWYouJi
//
//  Created by MC on 15/11/17.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "homeYJModel.h"
@implementation YJUserModel

@end
@implementation YJphotoModel

@end
@implementation YJoptsModel

@end

@implementation homeYJModel

-(instancetype)init
{
    self = [super init];
    if (self) {
        _YJphotos = [NSMutableArray array];
        _YJoptsArray = [NSMutableArray array];
    }
    return self;
}
@end
