//
//  LocationManager.m
//  yqjy
//
//  Created by admin on 2019/9/14.
//  Copyright © 2019 易起. All rights reserved.
//

#import "LocationManager.h"

@interface LocationManager()<CLLocationManagerDelegate>

@end

@implementation LocationManager

- (CLLocationManager *)manager{
    if (!_manager) {
        _manager = [[CLLocationManager alloc] init];
        _manager.delegate = self;
        _manager.desiredAccuracy = kCLLocationAccuracyBest;
        _manager.distanceFilter = 10.f;
    }
    return _manager;
}

- (CLAuthorizationStatus)currentStatus{
    return [CLLocationManager authorizationStatus];
}

-(void)requestAuthor{
    if ([self currentStatus] == kCLAuthorizationStatusDenied || [self currentStatus] == kCLAuthorizationStatusNotDetermined) {
        [YLUtils showAlertWithTwoButton:@"未开启定位" message:@"\n请到设置-定位中修改" leftbuttonTitle:@"取消" leftBlock:^{
        } rightButtonTitle:@"确定" rightBlock:^{
            NSURL *url= [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication]openURL:url options:@{}completionHandler:nil];
            } else {
                [[UIApplication sharedApplication]openURL:url];
            }
        }];
    }
}

-(BOOL)canLocation{
    if ([CLLocationManager locationServicesEnabled]) {
        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
            return YES;
        }else if (status == kCLAuthorizationStatusDenied){
            [YLUtils showAlertWithTwoButton:@"未开启定位" message:@"\n请到设置-定位中修改" leftbuttonTitle:@"取消" leftBlock:^{
            } rightButtonTitle:@"确定" rightBlock:^{
                NSURL *url= [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if (@available(iOS 10.0, *)) {
                    [[UIApplication sharedApplication]openURL:url options:@{}completionHandler:nil];
                } else {
                    [[UIApplication sharedApplication]openURL:url];
                }
            }];
        }
    }
    return NO;
}

-(void)startLocation{
    if ([self canLocation]) {
        if (!self.alreadyLocation) {
            [self.manager startUpdatingLocation];
        }
    }else{
        [self.manager requestWhenInUseAuthorization];
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [self.manager stopUpdatingLocation];//停止定位
    //地理反编码
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    //当系统设置为其他语言时，可利用此方法获得中文地理名称
    NSMutableArray
    *userDefaultLanguages = [[NSUserDefaults standardUserDefaults]objectForKey:@"AppleLanguages"];
    // 强制 成 简体中文
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"zh-hans", nil]forKey:@"AppleLanguages"];
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        NSString *lostLocate = @"定位失败,请稍后重试";
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            NSString *city = placeMark.locality;
            if (!city) {
                self.failBlock(lostLocate);
            } else {
                NSString *city = placeMark.locality ;//获取当前城市
                NSLog(@"定位成功，城市名：%@",city);
                self.alreadyLocation = YES;
                if (self.sucBlock) {
                    self.sucBlock(city, currentLocation);
                }
            }
        } else if (error == nil && placemarks.count == 0 ) {
        } else if (error) {
            self.failBlock(lostLocate);
        }
        // 还原Device 的语言
        [[NSUserDefaults
          standardUserDefaults] setObject:userDefaultLanguages
         forKey:@"AppleLanguages"];
    }];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"%@",error.description);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        {
            NSLog(@"用户还未决定授权");
            break;
        }
        case kCLAuthorizationStatusRestricted:
        {
            NSLog(@"访问受限");
            break;
        }
        case kCLAuthorizationStatusDenied:
        {
            // 类方法，判断是否开启定位服务
            if ([CLLocationManager locationServicesEnabled]) {
                NSLog(@"定位服务开启，被拒绝");
            } else {
                NSLog(@"定位服务关闭，不可用");
            }
            break;
        }
        case kCLAuthorizationStatusAuthorizedAlways:
        {
            NSLog(@"获得前后台授权");
            [self startLocation];
            break;
        }
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            NSLog(@"获得前台授权");
            [self startLocation];
            break;
        }
        default:
            break;
    }
}

@end
