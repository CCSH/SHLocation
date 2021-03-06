//
//  SHLocationManager.m
//  SHLocationExample
//
//  Created by CSH on 2019/3/29.
//  Copyright © 2019 CSH. All rights reserved.
//

#import "SHLocationManager.h"
#import <UIKit/UIKit.h>

@interface SHLocationManager ()<CLLocationManagerDelegate>

//获取当前经纬度block
@property (nonatomic, copy) CoordinateBlock coordinateBlock;
//定位
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation SHLocationManager

+ (SHLocationManager *)shareInstance{
    
    static SHLocationManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 100.0f;
    }
    return _locationManager;
}

#pragma mark 获取定位权限
+ (void)getLocPermissions{
    
    //判断定位用户权限
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways://一直获取
            
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse://使用期间
            
            break;
        case kCLAuthorizationStatusDenied://用户禁止
        {
            
            return;
        }
            break;
        case kCLAuthorizationStatusNotDetermined://未做决定
        {
            //使用期间使用 NSLocationWhenInUseUsageDescription
            [[self shareInstance].locationManager requestWhenInUseAuthorization];
        }
            break;
        case kCLAuthorizationStatusRestricted://受限制
        {
            
            return;
        }
            break;
        default:
            break;
    }
    
    [[self shareInstance].locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    CLLocation *location = [locations firstObject];
    if (self.coordinateBlock) {
        self.coordinateBlock(location.coordinate);
    }
}

#pragma mark - 公共方法
#pragma mark 打开APP设置页面
+ (void)openAppSetting{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

#pragma mark 获取位置权限状态
+ (SHLocationType)getLocAuthorizationStatus{
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            return SHLocationType_use;
        }
            break;
        case kCLAuthorizationStatusNotDetermined:
        {
            return SHLocationType_not_determined;
        }
            break;
        default:
            break;
    }
    
    return SHLocationType_no_use;
}

#pragma mark 获取定位权限
+ (void)getLocAuthorizationWithIsAlways:(BOOL)isAlways{
    
    switch ([SHLocationManager getLocAuthorizationStatus]) {
        case SHLocationType_not_determined://未做决定
        {
            if (isAlways) {
                //始终允许 NSLocationAlwaysAndWhenInUseUsageDescription
                [[self shareInstance].locationManager requestAlwaysAuthorization];
            }else{
                 //使用期间使用 NSLocationWhenInUseUsageDescription
                [[self shareInstance].locationManager requestWhenInUseAuthorization];
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark 获取经纬度
+ (void)getCoordinateWithBlock:(CoordinateBlock)block{
    
    [self shareInstance].coordinateBlock = block;
    //开始定位
    [SHLocationManager startUpdatingLocation];
}

#pragma mark 通过经纬度 获取城市名
+ (void)getAddressWithCoordinate:(CLLocationCoordinate2D)coordinate block:(GetAddressBlock)block{
    
    CLLocation *location = [[CLLocation alloc]initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    //反地理编码
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (placemarks.count) {
            CLPlacemark *placemark = [placemarks firstObject];
            
            if (block) {
                block(placemark);
            }
        }
    }];
}

#pragma mark 通过城市名 获取经纬度
+ (void)getCoordinatesWithAddress:(NSString *)address block:(GetCoordinateBlock)block{
    
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    //地理编码
    [geocoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (placemarks.count) {
            CLPlacemark *placemark = [placemarks firstObject];
            CLLocation *location = placemark.location;
            
            if (block) {
                block(location.coordinate);
            }
        }
    }];
}

#pragma mark 开始定位
+ (void)startUpdatingLocation{
    [[self shareInstance].locationManager startUpdatingLocation];
}

#pragma mark 结束定位
+ (void)stopUpdatingLocation{
     [[self shareInstance].locationManager stopUpdatingLocation];
}


@end
