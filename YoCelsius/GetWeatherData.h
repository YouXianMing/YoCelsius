//
//  GetWeatherData.h
//  YoCelsius
//
//  Created by XianMingYou on 15/2/25.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@protocol GetWeatherDataDelegate <NSObject>

- (void)weatherData:(id)object sucess:(BOOL)sucess;

@end

@interface GetWeatherData : NSObject

@property (nonatomic, weak)  id<GetWeatherDataDelegate> delegate;

@property (nonatomic, strong) CLLocation  *location;
@property (nonatomic, strong) NSString    *cityId;

- (void)startGetLocalRandomData;

@end
