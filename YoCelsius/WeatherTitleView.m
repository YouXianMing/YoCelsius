//
//  WeatherTitleView.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/23.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "WeatherTitleView.h"
#import "ChangeColorLabel.h"

@interface WeatherTitleViewStoreValue : NSObject

@property (nonatomic) CGRect startRect;
@property (nonatomic) CGRect midRect;
@property (nonatomic) CGRect endRect;

@end

@implementation WeatherTitleViewStoreValue

@end

@interface WeatherTitleView ()

@property (nonatomic, strong) ChangeColorLabel            *changeColorLabel;
@property (nonatomic, strong) WeatherTitleViewStoreValue  *changeColorLabelStoreValue;
@property (nonatomic, strong) UIView                      *vLine;
@property (nonatomic, strong) UIView                      *hLine;
@property (nonatomic, strong) UILabel                     *describInfoLabel;

@end

@implementation WeatherTitleView

/**
 *  创建出view
 */
- (void)buildView {
    
    // 颜色设置
    self.changeColorLabel              = [[ChangeColorLabel alloc] initWithFrame:CGRectMake(35 - 10, 23, 0, 0)];
    self.changeColorLabel.textColor    = [UIColor blackColor];
    self.changeColorLabel.changedColor = COLOR_PURE_;
    self.changeColorLabel.font         = [UIFont fontWithName:LATO_REGULAR size:24];
    [self.changeColorLabel updateLabelView];
    [self.changeColorLabel colorPercent:0.f];
    self.changeColorLabel.alpha        = 0.f;
    [self addSubview:self.changeColorLabel];
    
    // 垂直的线条
    self.vLine = [[UIView alloc] initWithFrame:CGRectMake(17 - 5, 18, 6, 40)];
    self.vLine.backgroundColor = [UIColor blackColor];
    self.vLine.alpha           = 0.f;
    [self addSubview:self.vLine];
    
    // 水平的线条
    self.hLine                 = [[UIView alloc] initWithFrame:CGRectMake(17 + 10, self.vLine.y + self.vLine.height - 1, 200, 1)];
    self.hLine.alpha           = 0.f;
    self.hLine.backgroundColor = [UIColor blackColor];
    [self addSubview:self.hLine];
    
    // 天气描述信息
    self.describInfoLabel = [[UILabel alloc] initWithFrame:\
                             CGRectMake(17 + 10,
                                        self.vLine.y + self.vLine.height + 2,
                                        200,
                                        12)];
    self.describInfoLabel.textAlignment = NSTextAlignmentRight;
    self.describInfoLabel.textColor     = COLOR_PURE_;
    self.describInfoLabel.alpha         = 0.f;
    self.describInfoLabel.font          = [UIFont fontWithName:LATO_BOLD size:10.f];
    [self addSubview:self.describInfoLabel];
}

- (void)show {
    
    // 更新标题
    self.changeColorLabel.text = self.cityName;
    [self.changeColorLabel updateLabelView];
    [self.changeColorLabel colorPercent:0.f];
    
    CGFloat duration = 1.75f;
    
    // 获取天气描述信息
    self.describInfoLabel.text = self.weatherDescription;
    
    [UIView animateWithDuration:duration animations:^{
        
        // 城市名字信息
        self.changeColorLabel.x     = 35;
        self.changeColorLabel.alpha = 1.f;
        
        // 垂直的线条
        self.vLine.x     = 17;
        self.vLine.alpha = 1.f;
        
        // 水平的线条
        self.hLine.x     = 17;
        self.hLine.alpha = 1.f;
        
        // 天气描述信息
        self.describInfoLabel.x     = 17.f;
        self.describInfoLabel.alpha = 1.f;
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hide {
    
    // 动画时间
    CGFloat duration = 0.75f;
    
    [UIView animateWithDuration:duration animations:^{
        
        // 城市名字信息
        self.changeColorLabel.x     = 35 + 10;
        self.changeColorLabel.alpha = 0.f;
        
        // 垂直的线条
        self.vLine.x     = 17 + 5;
        self.vLine.alpha = 0.f;
        
        // 水平的线条
        self.hLine.x     = 17 - 5;
        self.hLine.alpha = 0.f;
        
        // 天气描述信息
        self.describInfoLabel.x     = 17.f - 10;
        self.describInfoLabel.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        
        self.changeColorLabel.x = 35 - 10;
        self.vLine.x            = 17 - 5;
        self.hLine.x            = 17 + 10;
        self.describInfoLabel.x = 17 + 10;
    }];
}

- (void)accessOffsetValue:(CGFloat)offsetValue {
    
    if (offsetValue <= 0) {
        
        CGFloat percent = -offsetValue / 100.f;
        [self.changeColorLabel colorPercent:percent];
        
        CGFloat tmpX  = - offsetValue;
        
        self.hLine.x  = 17.f + tmpX * 0.2;
        self.vLine.y  = 18.f + tmpX *0.1f;
        self.changeColorLabel.x = 35 + tmpX * 0.1;
        self.describInfoLabel.x = 17.f - tmpX * 0.05;
        
    } else {
        
        CGFloat percent = (64 - offsetValue) / 64.f;
        
        self.changeColorLabel.alpha = percent;
        self.hLine.alpha            = percent;
        self.vLine.alpha            = percent;
        self.describInfoLabel.alpha = percent;
    }
}

@end
