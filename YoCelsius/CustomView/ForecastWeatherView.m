//
//  ForecastWeatherView.m
//  YoCelsius
//
//  Created by XianMingYou on 15/3/4.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "ForecastWeatherView.h"

@interface ForecastWeatherView ()

@property (nonatomic, strong) LineBackgroundView *lineBackgroundView;

@property (nonatomic, strong) UIView  *countryCodeBackgroundView;
@property (nonatomic, strong) UILabel *countryCodeLabel;
@property (nonatomic, strong) UILabel *forecastLabel;
@property (nonatomic, strong) UILabel *cityNameLabel;

@end

@implementation ForecastWeatherView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.85];
        [self initViews];
    }
    
    return self;
}

- (void)initViews {
    
    self.lineBackgroundView = [LineBackgroundView createViewWithFrame:self.bounds
                                                            LineWidth:4
                                                              lineGap:4
                                                            lineColor:[[UIColor blackColor] colorWithAlphaComponent:0.015]];
    [self addSubview:self.lineBackgroundView];
}

- (void)show {
    
}

- (void)hide {
    
}

- (void)buildView {
    
    self.countryCodeBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(15, 15, 37, 22)];
    self.countryCodeBackgroundView.backgroundColor = [UIColor redColor];
    [self addSubview:self.countryCodeBackgroundView];
    
    self.countryCodeLabel = [[UILabel alloc] initWithFrame:self.countryCodeBackgroundView.bounds];
    self.countryCodeLabel.textAlignment = NSTextAlignmentCenter;
    self.countryCodeLabel.text = @"";
    self.countryCodeLabel.font = [UIFont fontWithName:LATO_LIGHT size:LATO_14];
    self.countryCodeLabel.textColor = [UIColor whiteColor];
    [self.countryCodeBackgroundView addSubview:self.countryCodeLabel];
    
    self.forecastLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.countryCodeBackgroundView.x + 50, self.countryCodeBackgroundView.y, 0, 0)];
    self.forecastLabel.text      = @"Weather Forecast";
    self.forecastLabel.font      = [UIFont fontWithName:LATO_LIGHT size:LATO_16];
    self.forecastLabel.textColor = [UIColor blackColor];
    [self.forecastLabel sizeToFit];
    [self addSubview:self.forecastLabel];
    
    if (iPhone4_4s || iPhone5_5s) {
        
        self.cityNameLabel      = [[UILabel alloc] initWithFrame:CGRectMake(self.countryCodeBackgroundView.x,
                                                                            self.countryCodeBackgroundView.x + 30, 0, 0)];
        self.cityNameLabel.text = @"";
        self.cityNameLabel.font = [UIFont fontWithName:LATO_REGULAR size:24];
        
    } else if (iPhone6_6s) {
        
        self.cityNameLabel      = [[UILabel alloc] initWithFrame:CGRectMake(self.countryCodeBackgroundView.x,
                                                                            self.countryCodeBackgroundView.x + 30, 0, 0)];
        self.cityNameLabel.text = @"";
        self.cityNameLabel.font = [UIFont fontWithName:LATO_THIN size:40];
        
    } else if (iPhone6_6sPlus) {
        
        self.cityNameLabel      = [[UILabel alloc] initWithFrame:CGRectMake(self.countryCodeBackgroundView.x,
                                                                            self.countryCodeBackgroundView.x + 30, 0, 0)];
        self.cityNameLabel.text = @"";
        self.cityNameLabel.font = [UIFont fontWithName:LATO_LIGHT size:47.f];
        
    } else {
        
        self.cityNameLabel      = [[UILabel alloc] initWithFrame:CGRectMake(self.countryCodeBackgroundView.x,
                                                                            self.countryCodeBackgroundView.x + 30, 0, 0)];
        self.cityNameLabel.text = @"";
        self.cityNameLabel.font = [UIFont fontWithName:LATO_REGULAR size:24];
        
    }
    
    [self.cityNameLabel sizeToFit];
    [self addSubview:self.cityNameLabel];
}

@synthesize cityName = _cityName;

- (void)setCityName:(NSString *)cityName {
    
    _cityName               = cityName;
    self.cityNameLabel.text = cityName;
    [self.cityNameLabel sizeToFit];
}

@synthesize countryCode = _countryCode;

- (void)setCountryCode:(NSString *)countryCode {
    
    _countryCode               = countryCode;
    self.countryCodeLabel.text = countryCode;
}

@end
