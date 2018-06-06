//
//  ZZJLocation.m
//  LearnCLLocation
//
//  Created by zhifu360 on 2018/6/6.
//  Copyright © 2018年 智富金融. All rights reserved.
//

#import "ZZJLocation.h"

@interface ZZJLocation ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation ZZJLocation

#pragma mark - 开启定位
- (void)beginUpdatingLocation {
    
    [self.locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    //获取新的位置
    CLLocation *newLocation = locations.lastObject;
    
    //创建自定制位置对象
    Location *location = [[Location alloc] init];
    
    //存储经度
    location.longitude = newLocation.coordinate.longitude;
    
    //存储纬度
    location.latitude = newLocation.coordinate.latitude;
    
    //根据经纬度反向地理编译出地址信息
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * placemarks, NSError *error) {
        
        if (placemarks.count > 0) {
            
            CLPlacemark *placeMark = placemarks.firstObject;
            
            //存储位置信息
            location.country = placeMark.country;
            location.administrativeArea = placeMark.administrativeArea;
            location.locality = placeMark.locality;
            
            if (!placeMark.locality) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                location.locality = placeMark.administrativeArea;
            }
            
            location.subLocality = placeMark.subLocality;
            location.thoroughfare = placeMark.thoroughfare;
            location.subThoroughfare = placeMark.subThoroughfare;
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(locationDidEndUpdatingLocation:)]) {
                
                [self.delegate locationDidEndUpdatingLocation:location];
            }
        }
        else if (error == nil && [placemarks count] == 0)
        {
            NSLog(@"No results were returned.");
        }
        else if (error != nil)
        {
            NSLog(@"An error occurred = %@", error);
        }
        
    }];
    
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    if ([error code] == kCLErrorDenied) {
        NSLog(@"访问被拒绝");
    }
    
    if ([error code] == kCLErrorLocationUnknown) {
        NSLog(@"无法获取位置信息");
    }
}

#pragma mark - lazy

- (CLLocationManager *)locationManager {
    
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        // 取得定位权限，有两个方法，取决于你的定位使用情况
        // 一个是 requestAlwaysAuthorization
        // 一个是 requestWhenInUseAuthorization
        [_locationManager requestAlwaysAuthorization];//ios8以上版本使用。
        [_locationManager requestWhenInUseAuthorization];
    }
    return _locationManager;
}

@end
















