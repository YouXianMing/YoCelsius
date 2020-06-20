//
//  Weather.h
//
//  http://home.cnblogs.com/u/YouXianMing
//  https://github.com/YouXianMing
//
//  Copyright (c) 2015 YouXianMing All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject

@property (nonatomic, strong) NSNumber       *weatherId;       // Weather condition id
@property (nonatomic, strong) NSString       *main;            // Group of weather parameters (Rain, Snow, Extreme etc.)
@property (nonatomic, strong) NSString       *icon;            // Weather icon id
@property (nonatomic, strong) NSString       *descriptionInfo; // Weather condition within the group

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

/*
 weatherId
 http://www.openweathermap.org/weather-conditions
 
 Thunderstorm ID Meaning Icon
 200	thunderstorm with light rain	[[file:11d.png]]
 201	thunderstorm with rain	        [[file:11d.png]]
 202	thunderstorm with heavy rain	[[file:11d.png]]
 210	light thunderstorm	            [[file:11d.png]]
 211	thunderstorm	                [[file:11d.png]]
 212	heavy thunderstorm	            [[file:11d.png]]
 221	ragged thunderstorm	            [[file:11d.png]]
 230	thunderstorm with light drizzle	[[file:11d.png]]
 231	thunderstorm with drizzle	    [[file:11d.png]]
 232	thunderstorm with heavy drizzle	[[file:11d.png]]
 
 Drizzle ID	Meaning	Icon
 300	light intensity drizzle	        [[file:09d.png]]
 301	drizzle	                        [[file:09d.png]]
 302	heavy intensity drizzle	        [[file:09d.png]]
 310	light intensity drizzle rain	[[file:09d.png]]
 311	drizzle rain                	[[file:09d.png]]
 312	heavy intensity drizzle rain	[[file:09d.png]]
 313	shower rain and drizzle	        [[file:09d.png]]
 314	heavy shower rain and drizzle	[[file:09d.png]]
 321	shower drizzle	[[file:09d.png]]
 
 Rain ID Meaning Icon
 500	light rain	[[file:10d.png]]
 501	moderate rain	[[file:10d.png]]
 502	heavy intensity rain	[[file:10d.png]]
 503	very heavy rain	[[file:10d.png]]
 504	extreme rain	[[file:10d.png]]
 511	freezing rain	[[file:13d.png]]
 520	light intensity shower rain	[[file:09d.png]]
 521	shower rain	[[file:09d.png]]
 522	heavy intensity shower rain	[[file:09d.png]]
 531	ragged shower rain	[[file:09d.png]]
 Snow
 ID	Meaning	Icon
 600	light snow	[[file:13d.png]]
 601	snow	[[file:13d.png]]
 602	heavy snow	[[file:13d.png]]
 611	sleet	[[file:13d.png]]
 612	shower sleet	[[file:13d.png]]
 615	light rain and snow	[[file:13d.png]]
 616	rain and snow	[[file:13d.png]]
 620	light shower snow	[[file:13d.png]]
 621	shower snow	[[file:13d.png]]
 622	heavy shower snow	[[file:13d.png]]
 Atmosphere
 ID	Meaning	Icon
 701	mist	[[file:50d.png]]
 711	smoke	[[file:50d.png]]
 721	haze	[[file:50d.png]]
 731	sand, dust whirls	[[file:50d.png]]
 741	fog	[[file:50d.png]]
 751	sand	[[file:50d.png]]
 761	dust	[[file:50d.png]]
 762	volcanic ash	[[file:50d.png]]
 771	squalls	[[file:50d.png]]
 781	tornado	[[file:50d.png]]
 Clouds
 ID	Meaning	Icon
 800	clear sky	[[file:01d.png]] [[file:01n.png]]
 801	few clouds	[[file:02d.png]] [[file:02n.png]]
 802	scattered clouds	[[file:03d.png]] [[file:03d.png]]
 803	broken clouds	[[file:04d.png]] [[file:03d.png]]
 804	overcast clouds	[[file:04d.png]] [[file:04d.png]]
 Extreme
 ID	Meaning
 900	tornado
 901	tropical storm
 902	hurricane
 903	cold
 904	hot
 905	windy
 906	hail
 Additional
 ID	Meaning
 951	calm
 952	light breeze
 953	gentle breeze
 954	moderate breeze
 955	fresh breeze
 956	strong breeze
 957	high wind, near gale
 958	gale
 959	severe gale
 960	storm
 961	violent storm
 962	hurricane
 */

@end

