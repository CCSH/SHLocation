//
//  ViewController.m
//  SHLocationExample
//
//  Created by CSH on 2019/3/29.
//  Copyright © 2019 CSH. All rights reserved.
//

#import "ViewController.h"
#import "SHLocationManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    30.241991646563449, longitude = 120.23635082975349
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [SHLocationManager openAppSetting];
    
//    [SHLocationManager getCoordinateWithBlock:^(CLLocationCoordinate2D coordinate) {
//
//    }];
    
//    CLLocationCoordinate2D coor;
//    coor.latitude = 30.241991646563449;
//    coor.longitude = 120.23635082975349;
//    [SHLocationManager getAddressWithCoordinate:coor block:^(CLPlacemark *param) {
//        //省
//        NSString *administrativeArea = param.administrativeArea;
//        //市
//        NSString *locality = param.locality;
//        //区
//        NSString *subLocality = param.subLocality;
//        //街道
//        NSString *thoroughfare = param.thoroughfare;
//        //门牌号
//        NSString *subThoroughfare = param.subThoroughfare;
//        //地名
//        NSString *name = param.name;
//    }];

//    [SHLocationManager getCoordinatesWithAddress:@"浙江省杭州市萧山区传化大厦" block:^(CLLocationCoordinate2D coordinate) {
//
//    }];
}


@end
