//
//  MapManager.m
//  YXMWeather
//
//  Created by XianMingYou on 15/2/15.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import "MapManager.h"

@interface MapManager ()<CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation MapManager

- (void)start {
    [self.locationManager startUpdatingLocation];
}

@synthesize locationManager = _locationManager;
- (CLLocationManager *)locationManager {
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        
        // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
        if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [_locationManager requestWhenInUseAuthorization];
        }
        [_locationManager startUpdatingLocation];
    }
    
    return _locationManager;
}

// Location Manager Delegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [manager stopUpdatingLocation];
    
    if (_delegate && [_delegate respondsToSelector:@selector(mapManager:didUpdateAndGetLastCLLocation:)]) {
        CLLocation *location = [locations lastObject];
        [_delegate mapManager:self didUpdateAndGetLastCLLocation:location];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error; {
    if (_delegate && [_delegate respondsToSelector:@selector(mapManager:didFailed:)]) {
        [_delegate mapManager:self didFailed:error];
    }
}

@synthesize authorizationStatus = _authorizationStatus;
- (CLAuthorizationStatus)authorizationStatus {
    return [CLLocationManager authorizationStatus];
}

@end
