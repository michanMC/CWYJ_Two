//
//  MCMApManager.m
//  MCCWYJ
//
//  Created by MC on 16/4/29.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MCMApManager.h"
#import <AMapSearchKit/AMapSearchAPI.h>
#import <AMapSearchKit/AMapSearchObj.h>
#import <AMapSearchKit/AMapCommonObj.h>
#import <MAMapKit/MAMapKit.h>
#import "AppDelegate.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import "LCTabBarController.h"
@interface MCMApManager ()<MAMapViewDelegate,AMapSearchDelegate>
{
    BaseViewController *_ctlView;
    
}
@property (nonatomic,strong)MAMapView *mapView;
@property (nonatomic,strong)AMapSearchAPI *bmksearch;

@end

@implementation MCMApManager


+ (MCMApManager *)sharedInstance
{
    static dispatch_once_t  onceToken;
    static MCMApManager * sSharedInstance;
     [MAMapServices sharedServices].apiKey = @"341b28fd4e63a240fd2ef4feafc9b2aa";
    //配置用户Key
    [AMapSearchServices sharedServices].apiKey = @"341b28fd4e63a240fd2ef4feafc9b2aa";
    dispatch_once(&onceToken, ^{
        sSharedInstance = [[MCMApManager alloc] init];


        
       sSharedInstance.mapView = [[MAMapView alloc] init];
        sSharedInstance.mapView.delegate = sSharedInstance;
        sSharedInstance.mapView.showsUserLocation = NO; //YES 为打开定位，NO为关闭定位
        sSharedInstance.mapView.userTrackingMode = MAUserTrackingModeNone;
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

        [appDelegate.window addSubview:sSharedInstance.mapView];
        sSharedInstance.bmksearch = [[AMapSearchAPI alloc]init];
        sSharedInstance.bmksearch.delegate = sSharedInstance;
        
        
    });
    return sSharedInstance;
}
-(void)Isdingwei:(BOOL)isdingwei CtlView:(BaseViewController*)ctlView;
{
    _city = nil;
    _ctlView =ctlView;
    _isdingwei =isdingwei;
    _mapView.showsUserLocation = isdingwei; //YES 为打开定位，NO为关闭定位

    
}
#pragma mark - MAMapViewDelegate 取出当前位置的坐标
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        
        AMapReGeocodeSearchRequest * regeo = [[AMapReGeocodeSearchRequest alloc]init];
        
//        regeo.searchType = AMapSearchType_ReGeocode;
        
        regeo.location        = [AMapGeoPoint locationWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
        
        _la =userLocation.coordinate.latitude;
        
        _lo =userLocation.coordinate.longitude;
        regeo.requireExtension            = YES;
        regeo.radius = 1000;
        
        if (!_city || !_city.length)
            [_bmksearch AMapReGoecodeSearch:regeo];
        
    }
}
/* 逆地理编码回调. */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{
    
    
    if (response.regeocode != nil) {
        if (!_city.length) {
            _city =response.regeocode.addressComponent.city;
            NSLog(@">>>>>>%@",_city);
                [self backCity:_city];
            
        }

    }
    
    
}
#pragma mark-定位回调
-(void)backCity:(NSString *)city
{
    if (![MCMApManager sharedInstance].lo || ![MCMApManager sharedInstance].la) {
        return;
    }
    

    NSDictionary * Parameterdic = @{
                                    @"lat":@([MCMApManager sharedInstance].la),
                                    @"lng":@([MCMApManager sharedInstance].lo)                                    };
    
    

    [_ctlView.requestManager postWithUrl:@"api/user/profiles/updateLocation.json" refreshCache:NO params:Parameterdic success:^(id resultDic) {
        
        NSLog(@"上传地址成功");
        NSLog(@"返回==%@",resultDic);
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        NSLog(@"失败%@",description);
        
    }];
    
    
}

@end
