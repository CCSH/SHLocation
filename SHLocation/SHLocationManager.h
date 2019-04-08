//
//  SHLocationManager.h
//  SHLocationExample
//
//  Created by CSH on 2019/3/29.
//  Copyright © 2019 CSH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

//获取当前经纬度block
typedef void (^CoordinateBlock) (CLLocationCoordinate2D coordinate);
//获取地址信息block
typedef void (^GetAddressBlock) (CLPlacemark *param);
//获取坐标信息block
typedef void (^GetCoordinateBlock) (CLLocationCoordinate2D coordinate);

NS_ASSUME_NONNULL_BEGIN

@interface SHLocationManager : NSObject

//打开APP设置页面
+ (void)openAppSetting;

//获取定位权限
+ (void)getLocPermissions;

//获取经纬度
+ (void)getCoordinateWithBlock:(CoordinateBlock)block;

//通过经纬度 获取城市名
+ (void)getAddressWithCoordinate:(CLLocationCoordinate2D)coordinate block:(GetAddressBlock)block;

//通过城市名 获取经纬度
+ (void)getCoordinatesWithAddress:(NSString *)address block:(GetCoordinateBlock)block;

@end

NS_ASSUME_NONNULL_END
