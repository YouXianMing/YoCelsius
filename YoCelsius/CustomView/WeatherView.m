//
//  WeatherView.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/23.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "WeatherView.h"
#import "HumidityView.h"
#import "WindSpeedView.h"
#import "MaxTempView.h"
#import "SunInfoView.h"
#import "WeatherIconView.h"
#import "TemperatureView.h"
#import "ChangeColorLabel.h"
#import "CityTitleView.h"
#import "ShowDownView.h"
#import "LeftToRightView.h"
#import "UpToDownView.h"
#import "ShapeWordView.h"

@interface WeatherView ()<UITableViewDelegate>

@property (nonatomic, strong) ChangeColorLabel  *changeColorLabel;
@property (nonatomic ,strong) HumidityView      *humidityView;
@property (nonatomic, strong) WindSpeedView     *windSpeedView;
@property (nonatomic, strong) MaxTempView       *maxTempView;
@property (nonatomic, strong) SunInfoView       *sunInfoView;
@property (nonatomic, strong) TemperatureView   *temperatureView;
@property (nonatomic, strong) WeatherIconView   *weatherIconView;
@property (nonatomic, strong) CityTitleView     *cityTitleView;
@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) ShowDownView      *showDownView;
@property (nonatomic, strong) LeftToRightView   *grayLine1;
@property (nonatomic, strong) LeftToRightView   *grayLine2;
@property (nonatomic, strong) LeftToRightView   *grayLine3;
@property (nonatomic, strong) LeftToRightView   *grayLine4;
@property (nonatomic, strong) UpToDownView      *vLine;
@property (nonatomic, strong) ShapeWordView     *shapeWordView;

@end

@implementation WeatherView

- (void)buildView {
    
    // 加载用tableView
    self.tableView                 = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate        = self;
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableView];
    
    if (iPhone4_4s) {
        
        // 显示控件
        self.humidityView = [[HumidityView alloc] initWithFrame:CGRectMake(0, Height - Width / 2.f, Width / 2.f, Width / 2.f)];
        [self.humidityView buildView];
        [self.tableView addSubview:self.humidityView];
        
        self.sunInfoView = [[SunInfoView alloc] initWithFrame:CGRectMake(Width / 2.f, Height - Width / 2.f, Width / 2.f, Width / 2.f)];
        [self.sunInfoView buildView];
        [self.tableView addSubview:self.sunInfoView];
        
        self.temperatureView = [[TemperatureView alloc] initWithFrame:CGRectMake(Width / 2.f, Height - Width, Width / 2.f, Width / 2.f)];
        [self.temperatureView buildView];
        [self.tableView addSubview:self.temperatureView];
        
        self.weatherIconView = [[WeatherIconView alloc] initWithFrame:CGRectMake(0, Height - Width, Width / 2.f, Width / 2.f)];
        [self.weatherIconView buildView];
        [self.tableView addSubview:self.weatherIconView];
        
    } else {
        
        // 显示控件
        self.humidityView = [[HumidityView alloc] initWithFrame:CGRectMake(0, Height - Width, Width / 2.f, Width / 2.f)];
        [self.humidityView buildView];
        [self.tableView addSubview:self.humidityView];
        
        self.windSpeedView = [[WindSpeedView alloc] initWithFrame:CGRectMake(Width / 2.f, Height - Width / 2.f, Width / 2.f, Width / 2.f)];
        [self.windSpeedView buildView];
        [self.tableView addSubview:self.windSpeedView];
        
        self.maxTempView = [[MaxTempView alloc] initWithFrame:CGRectMake(0, Height - Width / 2.f, Width / 2.f, Width / 2.f)];
        [self.maxTempView buildView];
        [self.tableView addSubview:self.maxTempView];
        
        self.sunInfoView = [[SunInfoView alloc] initWithFrame:CGRectMake(Width / 2.f, Height - Width, Width / 2.f, Width / 2.f)];
        [self.sunInfoView buildView];
        [self.tableView addSubview:self.sunInfoView];
        
        self.temperatureView = [[TemperatureView alloc] initWithFrame:CGRectMake(Width / 2.f, Height - Width - Width / 2.f, Width / 2.f, Width / 2.f)];
        [self.temperatureView buildView];
        [self.tableView addSubview:self.temperatureView];
        
        self.weatherIconView = [[WeatherIconView alloc] initWithFrame:CGRectMake(0, Height - Width - Width / 2.f, Width / 2.f, Width / 2.f)];
        [self.weatherIconView buildView];
        [self.tableView addSubview:self.weatherIconView];
    }
    
    // 创建出线条
    {
        self.grayLine1                 = [[LeftToRightView alloc] initWithFrame:CGRectMake(0, Height - Width / 2.f, Width, 0.5)];
        self.grayLine1.backgroundColor = [UIColor blackColor];
        self.grayLine1.alpha           = 0.1;
        [self.tableView addSubview:self.grayLine1];
        
        self.grayLine2                 = [[LeftToRightView alloc] initWithFrame:CGRectMake(0, Height - 1, Width, 0.5)];
        self.grayLine2.backgroundColor = [UIColor blackColor];
        self.grayLine2.alpha           = 0.1;
        [self.tableView addSubview:self.grayLine2];
        
        self.grayLine3                 = [[LeftToRightView alloc] initWithFrame:CGRectMake(0, Height - Width, Width, 0.5)];
        self.grayLine3.backgroundColor = [UIColor blackColor];
        self.grayLine3.alpha           = 0.1;
        [self.tableView addSubview:self.grayLine3];
        
        self.grayLine4                 = [[LeftToRightView alloc] initWithFrame:CGRectMake(0, Height - Width - Width / 2.f, Width, 0.5)];
        self.grayLine4.backgroundColor = [UIColor blackColor];
        self.grayLine4.alpha           = 0.1;
        [self.tableView addSubview:self.grayLine4];
        
        self.vLine                     = [[UpToDownView alloc] initWithFrame:CGRectMake(Width / 2.f - 1, Height - Width - Width / 2.f, 0.5, Width + Width / 2.f)];
        self.vLine.backgroundColor     = [UIColor blackColor];
        self.vLine.alpha               = 0.1;
        [self.tableView addSubview:self.vLine];
    }
    
    // 标题
    self.cityTitleView = [[CityTitleView alloc] initWithFrame:CGRectMake(0, 0, Width, Height - Width - Width / 2.f)];
    [self.cityTitleView buildView];
    [self.tableView addSubview:self.cityTitleView];
    
    // 显示进入更多天气的view的提示信息
    self.showDownView = [[ShowDownView alloc] initWithFrame:CGRectMake(0, 0, 30.f, 30.f / 3.f)];
    self.showDownView.center = self.middlePoint;
    self.showDownView.y = Height + 20.f;
    [self.tableView addSubview:self.showDownView];
    self.showDownView.layer.transform = CATransform3DConcat(self.showDownView.layer.transform, CATransform3DMakeRotation(M_PI,1.0, 0.0, 0.0));
    
    // tableView上面加载的view
    self.shapeWordView           = [[ShapeWordView alloc] initWithFrame:CGRectMake(0, -60, Width, 60)];
    self.shapeWordView.text      = @"Release To Refresh";
    self.shapeWordView.font      = [UIFont fontWithName:LATO_THIN size:20.f];
    self.shapeWordView.lineWidth = 0.5f;
    self.shapeWordView.lineColor = [UIColor redColor];
    [self.shapeWordView buildView];
    [self.tableView addSubview:self.shapeWordView];
}

- (WeatherInfo *)accessWeatherInfoDateWith:(NSArray *)list {
    
    // 获取时间
    WeatherInfo *today       = list[0];
    WeatherInfo *tomorrow    = list[1];
    WeatherInfo *weatherInfo = nil;
    
    // 进行时间转换
    NSDate *utcDate            = [NSDate dateWithTimeIntervalSince1970:today.dt.integerValue];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    NSString *netDateStr     = [formatter stringFromDate:utcDate];       // 获取的UTC时间
    NSString *currentDateStr = [formatter stringFromDate:[NSDate date]]; // 当前系统时间
    
    // 进行数据转换
    if ([netDateStr isEqualToString:currentDateStr]) {
        
        weatherInfo = today;
        
    } else {
        
        weatherInfo = tomorrow;
    }
    
    return weatherInfo;
}

/**
 *  显示动画
 */
- (void)show {
    
    if (self.weahterData == nil) {
        
        return;
    }
    
    // 湿度显示
    self.humidityView.percent = self.weahterData.main.humidity.intValue / 100.f;
    
    // 风速显示
    self.windSpeedView.windSpeed         = self.weahterData.wind.speed.floatValue;
    self.windSpeedView.circleByOneSecond = self.windSpeedView.windSpeed / 10.f;
    
    // 最大温度,最小温度显示
    WeatherInfo *today = [self accessWeatherInfoDateWith:self.weatherConditions.list];
    CGFloat tmpMax = today.temp.max.floatValue - 273.15;
    CGFloat tmpMin = today.temp.min.floatValue - 273.15;
    self.maxTempView.maxTemp = @(tmpMax).intValue;
    self.maxTempView.minTemp = @(tmpMin).intValue;
    
    // 日出时间,日落时间显示
    self.sunInfoView.sunsireValue.utcSec = self.weahterData.sys.sunrise.integerValue;
    self.sunInfoView.sunsetValue.utcSec  = self.weahterData.sys.sunset.integerValue;
    [self.sunInfoView.sunsireValue accessUtcSec];
    [self.sunInfoView.sunsetValue  accessUtcSec];

    // 当前温度显示(开尔文温度 --> 热力学温度)
    self.temperatureView.temperature = @(self.weahterData.main.temp.floatValue - 273.15).intValue;

    // 开始标题动画
    self.cityTitleView.cityName           = self.weahterData.name; // 城市名字
    Weather *weather                      = self.weahterData.weather[0];
    self.cityTitleView.weatherDescription = weather.descriptionInfo; // 天气描述信息
    self.cityTitleView.baseStation        = self.weahterData.base; // 基站信息
    self.cityTitleView.utcSec             = self.weahterData.dt.integerValue; // 更新时间
    self.cityTitleView.weatherNumber      = weather.weatherId;

    // 天气图标
    self.weatherIconView.weatherNumber = weather.weatherId;

    [self.windSpeedView show];
    [self.humidityView show];
    [self.maxTempView show];
    [self.sunInfoView show];
    [self.temperatureView show];
    [self.weatherIconView show];
    [self.cityTitleView show];
    
    [self.grayLine1 show];
    [self.grayLine2 show];
    [self.grayLine3 show];
    [self.grayLine4 show];
    [self.vLine show];
}

- (void)hide {
    
    // 湿度隐藏
    [self.humidityView hide];
    
    // 风速隐藏
    [self.windSpeedView hide];
    
    // 最大温度,最小温度隐藏
    [self.maxTempView hide];
    
    // 日出时间,日落时间显示
    [self.sunInfoView hide];
    
    // 当前温度
    [self.temperatureView hide];
    
    // 当前温度图标
    [self.weatherIconView hide];
    
    // 隐藏标题动画
    [self.cityTitleView hide];
    
    [self.grayLine1 hide];
    [self.grayLine2 hide];
    [self.grayLine3 hide];
    [self.grayLine4 hide];
    [self.vLine     hide];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat percent = (scrollView.contentOffset.y) / 60.f;
    [self.showDownView showPercent:percent];
    
    CGFloat offsetY = -scrollView.contentOffset.y;
    
    if (offsetY >= 0.f) {
        
        percent = offsetY / 60.f;
        [self.shapeWordView percent:percent animated:NO];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    // 位移超过60后执行动画效果
    if (scrollView.contentOffset.y >= 60.f) {
        
        if (_delegate && [_delegate respondsToSelector:@selector(pullUpEventWithData:)] && self.weatherConditions) {
            
            [_delegate pullUpEventWithData:self.weatherConditions];
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);

            [GCDQueue executeInMainQueue:^{
                
                scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                
            } afterDelaySecs:1.1];
        }
    }
    
    if (scrollView.contentOffset.y <= -60.f) {
        
        if (_delegate && [_delegate respondsToSelector:@selector(pullDownToRefreshData)]) {
            
            [_delegate pullDownToRefreshData];
        }
    }
}

@end
