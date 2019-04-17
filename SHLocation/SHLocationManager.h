//
//  SHLocationManager.h
//  SHLocationExample
//
//  Created by CSH on 2019/3/29.
//  Copyright © 2019 CSH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef enum : NSUInteger {
    SHLocationType_not_determined,//未做决定
    SHLocationType_use,//可以使用
    SHLocationType_no_use,//不可以使用
} SHLocationType;

//获取当前经纬度block
typedef void (^CoordinateBlock) (CLLocationCoordinate2D coordinate);
//获取地址信息block
typedef void (^GetAddressBlock) (CLPlacemark * _Nullable param);
//获取坐标信息block
typedef void (^GetCoordinateBlock) (CLLocationCoordinate2D coordinate);

NS_ASSUME_NONNULL_BEGIN

@interface SHLocationManager : NSObject

//打开APP设置页面
+ (void)openAppSetting;

//获取位置权限状态
+ (SHLocationType)getLocAuthorizationStatus;

/**
 获取定位权限

 @param isAlways 始终获取
 //始终允许 NSLocationAlwaysAndWhenInUseUsageDescription
 //使用期间使用 NSLocationWhenInUseUsageDescription
 */
+ (void)getLocAuthorizationWithIsAlways:(BOOL)isAlways;

//获取经纬度
+ (void)getCoordinateWithBlock:(CoordinateBlock)block;

//通过经纬度 获取城市名
+ (void)getAddressWithCoordinate:(CLLocationCoordinate2D)coordinate block:(GetAddressBlock)block;

//通过城市名 获取经纬度
+ (void)getCoordinatesWithAddress:(NSString *)address block:(GetCoordinateBlock)block;

//开始定位
+ (void)startUpdatingLocation;

//结束定位
+ (void)stopUpdatingLocation;

@end

NS_ASSUME_NONNULL_END
