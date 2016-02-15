//
//  WeatherNumberMeaningTransform.m
//  YoCelsius
//
//  Created by XianMingYou on 15/3/4.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "WeatherNumberMeaningTransform.h"

@implementation WeatherNumberMeaningTransform

+ (NSString *)fontTextWeatherNumber:(NSNumber *)number {
    
    // Clouds
    // 800	clear sky
    // 801	few clouds
    // 802	scattered clouds
    // 803	broken clouds
    // 804  overcast clouds
    
    /*
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
     
     
     Rain
     ID	Meaning	Icon
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
     
     
     
     
     Drizzle
     ID	Meaning	Icon
     300	light intensity drizzle	[[file:09d.png]]
     301	drizzle	[[file:09d.png]]
     302	heavy intensity drizzle	[[file:09d.png]]
     310	light intensity drizzle rain	[[file:09d.png]]
     311	drizzle rain	[[file:09d.png]]
     312	heavy intensity drizzle rain	[[file:09d.png]]
     313	shower rain and drizzle	[[file:09d.png]]
     314	heavy shower rain and drizzle	[[file:09d.png]]
     321	shower drizzle	[[file:09d.png]]
     
     
     Thunderstorm
     ID	Meaning	Icon
     200	thunderstorm with light rain	[[file:11d.png]]
     201	thunderstorm with rain	[[file:11d.png]]
     202	thunderstorm with heavy rain	[[file:11d.png]]
     210	light thunderstorm	[[file:11d.png]]
     211	thunderstorm	[[file:11d.png]]
     212	heavy thunderstorm	[[file:11d.png]]
     221	ragged thunderstorm	[[file:11d.png]]
     230	thunderstorm with light drizzle	[[file:11d.png]]
     231	thunderstorm with drizzle	[[file:11d.png]]
     232	thunderstorm with heavy drizzle	[[file:11d.png]]
     
     
     
     
     Extreme
     
     900	tornado
     901	tropical storm
     902	hurricane
     903	cold
     904	hot
     905	windy
     906	hail
     
     Additional
     
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
    
    NSString *weatherText = nil;
    
    
    switch (number.intValue) {
            
            // Extreme + Additional
        case 900:
            weatherText = @"e";
            break;
            
        case 901:
        case 902:
            weatherText = @"Y";
            break;
            
        case 903:
            weatherText = @"o";
            break;
            
        case 904:
            weatherText = @"h";
            break;
            
        case 905:
            weatherText = @"a";
            break;
            
        case 906:
            weatherText = @"W";
            break;
            
        case 951:
            weatherText = @"B";
            break;
            
        case 952:
        case 953:
        case 954:
        case 955:
        case 956:
        case 957:
            weatherText = @"Z";
            break;
            
        case 958:
        case 959:
        case 960:
        case 961:
        case 962:
            weatherText = @"Y";
            break;
            
            
            // Thunderstorm
        case 210:
        case 211:
        case 212:
        case 221:
            weatherText = @"T";
            break;
            
        case 200:
        case 201:
        case 202:
        case 230:
        case 231:
        case 232:
            weatherText = @"V";
            break;
            
            // Drizzle
        case 300:
        case 301:
        case 302:
        case 311:
        case 312:
        case 313:
        case 314:
        case 321:
            weatherText = @"R";
            break;
            
            // Rain
        case 500:
            weatherText = @"R";
            break;
            
        case 501:
        case 502:
        case 503:
        case 504:
            weatherText = @"S";
            break;
            
        case 511:
        case 520:
        case 521:
        case 522:
        case 531:
            weatherText = @"X";
            break;
            
            
            // Snow
        case 600:
        case 601:
        case 602:
        case 611:
        case 612:
        case 615:
        case 616:
        case 620:
        case 621:
        case 622:
            weatherText = @"W";
            break;
            
            
            // Atmosphere
        case 701:
            weatherText = @"N";
            break;
            
        case 711:
        case 721:
        case 731:
        case 741:
            weatherText = @"G";
            break;
            
        case 751:
        case 761:
        case 762:
        case 771:
            weatherText = @"O";
            break;
            
        case 781:
            weatherText = @"e";
            break;
            
            
            
            // Clouds
        case 800:
            weatherText = @"A";
            break;
            
        case 801:
            weatherText = @"C";
            break;
            
        case 802:
        case 803:
        case 804:
            weatherText = @"D";
            break;
            
            
            
        default:
            // 未知的情况
            weatherText = @"p";
            break;
    }
    
    
    return weatherText;
}

+ (UIColor *)iconColor:(NSNumber *)number {
    UIColor *color = nil;
    
    
    switch (number.intValue) {
            
            // Extreme + Additional
        case 900:
        case 901:
        case 902:
        case 903:
        case 904:
        case 905:
        case 906:
        case 951:
        case 952:
        case 953:
        case 954:
        case 955:
        case 956:
        case 957:
        case 958:
        case 959:
        case 960:
        case 961:
        case 962:
            color = [UIColor redColor];
            break;
            
            
            // Thunderstorm
        case 210:
        case 211:
        case 212:
        case 221:
        case 200:
        case 201:
        case 202:
        case 230:
        case 231:
        case 232:
            color = [UIColor redColor];
            break;
            
            // Drizzle
        case 300:
        case 301:
        case 302:
        case 311:
        case 312:
        case 313:
        case 314:
        case 321:
            color = [UIColor redColor];
            break;
            
            // Rain
        case 500:
        case 501:
        case 502:
        case 503:
        case 504:
        case 511:
        case 520:
        case 521:
        case 522:
        case 531:
            color = [UIColor redColor];
            break;
            
            
            // Snow
        case 600:
        case 601:
        case 602:
        case 611:
        case 612:
        case 615:
        case 616:
        case 620:
        case 621:
        case 622:
            color = COLOR_PURE_;
            break;
            
            
            // Atmosphere
        case 701:
        case 711:
        case 721:
        case 731:
        case 741:
        case 751:
        case 761:
        case 762:
        case 771:
        case 781:
            color = [UIColor redColor];
            break;
            
            
            
            // Clouds
        case 800:
        case 801:
        case 802:
        case 803:
        case 804:
            color = [UIColor orangeColor];
            break;
            
            
            
        default:
            // 未知的情况
            color = [UIColor blackColor];
            break;
    }
    
    
    return color;
    
}

+ (EMitterType)emitterTypeWithNumber:(NSNumber *)number {
    
    EMitterType type = __NONE;
    
    switch (number.intValue) {
            
            // Extreme + Additional
        case 900:
        case 901:
        case 902:
        case 903:
        case 904:
        case 905:
        case 906:
        case 951:
        case 952:
        case 953:
        case 954:
        case 955:
        case 956:
        case 957:
        case 958:
        case 959:
        case 960:
        case 961:
        case 962:
            break;
            
            
            // Thunderstorm
        case 210:
        case 211:
        case 212:
        case 221:
        case 200:
        case 201:
        case 202:
        case 230:
        case 231:
        case 232:
            type = __RAIN;
            break;
            
            // Drizzle
        case 300:
        case 301:
        case 302:
        case 311:
        case 312:
        case 313:
        case 314:
        case 321:
            type = __RAIN;
            break;
            
            // Rain
        case 500:
        case 501:
        case 502:
        case 503:
        case 504:
        case 511:
        case 520:
        case 521:
        case 522:
        case 531:
            type = __RAIN;
            break;
            
            
            // Snow
        case 600:
        case 601:
        case 602:
        case 611:
        case 612:
        case 615:
        case 616:
        case 620:
        case 621:
        case 622:
            type = __SNOW;
            break;
            
            
            // Atmosphere
        case 701:
        case 711:
        case 721:
        case 731:
        case 741:
        case 751:
        case 761:
        case 762:
        case 771:
        case 781:
            break;
            
            
            
            // Clouds
        case 800:
        case 801:
        case 802:
        case 803:
        case 804:
            break;
            
            
            
        default:
            // 未知的情况
            break;
    }
    
    return type;
}

@end
