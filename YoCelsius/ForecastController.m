//
//  ForecastController.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/26.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "ForecastController.h"
#import "ForecastCell.h"
#import "ShowDownView.h"
#import "ForecastWeatherView.h"

@interface ForecastController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIButton            *button;

@property (nonatomic, strong) UITableView         *tableView;
@property (nonatomic)         CGFloat              cellHeight;

@property (nonatomic, strong) NSMutableArray      *weatherDataArray;
@property (nonatomic, strong) ShowDownView        *showDownView;

@property (nonatomic, strong) ForecastWeatherView *forecastView;

@end

@implementation ForecastController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self initTableView];
    
    // 加载动画并动画显示
    [GCDQueue executeInMainQueue:^{
        
        self.weatherDataArray = [NSMutableArray arrayWithArray:self.weatherCondition.list];

        NSMutableArray *indexPathArray = [NSMutableArray array];
        
        for (int count = 0; count < self.weatherDataArray.count; count++) {
            
            NSIndexPath *path = [NSIndexPath indexPathForRow:count inSection:0];
            [indexPathArray addObject:path];
        }
        
        [self.tableView insertRowsAtIndexPaths:indexPathArray
                              withRowAnimation:UITableViewRowAnimationFade];
        
    } afterDelaySecs:0.30f];
    
    // 显示进入更多天气的view的提示信息
    self.showDownView        = [[ShowDownView alloc] initWithFrame:CGRectMake(0, 0, 30.f, 30.f / 3.f)];
    self.showDownView.center = self.view.center;
    self.showDownView.y      = -30.f;
    [self.tableView addSubview:self.showDownView];
}

- (void)initTableView {
    
    // cell高度
    self.cellHeight           = Width / 4.f;
    self.tableView            = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator   = NO;
    self.tableView.separatorStyle                 = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[ForecastCell class] forCellReuseIdentifier:@"ForecastCell"];
    
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.weatherDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ForecastCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ForecastCell"];
    [cell acccessData:self.weatherDataArray[indexPath.row] indexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.cellHeight;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (scrollView.contentOffset.y <= -60) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        }];
     
        [GCDQueue executeInMainQueue:^{
            
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
            
        } afterDelaySecs:0.15f];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat percent = (-scrollView.contentOffset.y) / 60.f;
    [self.showDownView showPercent:percent];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ForecastCell *forecastCell = (ForecastCell *)cell;
    [forecastCell show];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    
    ForecastCell *forecastCell = (ForecastCell *)cell;
    [forecastCell hide];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        ForecastWeatherView *titleView = [[ForecastWeatherView alloc] initWithFrame:CGRectMake(0, 0, Width, Height - Width * 1.5)];
        [titleView buildView];
        
        titleView.cityName    = self.weatherCondition.city.name;
        titleView.countryCode = self.weatherCondition.city.country;
        
        UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, Height - Width * 1.5 - 1, Width, 0.5)];
        line.backgroundColor = [UIColor blackColor];
        line.alpha           = 0.1f;
        [titleView addSubview:line];
        
        return titleView;
        
    } else {
        
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return Height - Width * 1.5;
}

@end
