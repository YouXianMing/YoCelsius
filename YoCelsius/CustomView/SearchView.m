//
//  SearchView.m
//  YoCelsius
//
//  Created by XianMingYou on 15/3/2.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "SearchView.h"
#import "LongTapAnimationView.h"
#import "TapTitleView.h"
#import "SearchCell.h"
#import "NSString+StringHeight.h"


typedef enum : NSUInteger {
    
    CURRENT_LOCATION = 0x3456,
    ADD_MORE_CITY,
    
} ESearchView;


@interface SearchView ()<TapTitleViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel     *menu;
@property (nonatomic, strong) UILabel     *currentLocation; // 当前位置
@property (nonatomic, strong) UILabel     *addMoreCity;     // 添加城市
@property (nonatomic, strong) UIButton    *menuButton;

@end

@implementation SearchView

- (void)tapTitleView:(TapTitleView *)tapView {
    
    // 当前位置
    if (tapView.tag == CURRENT_LOCATION) {
        
        if (_delegate && [_delegate respondsToSelector:@selector(currentLocationWithView:)]) {
            
            [_delegate currentLocationWithView:self];
        }
    }
}

- (void)buildView {
    
    // Menu标题
    TapTitleView *title = [[TapTitleView alloc] initWithFrame:CGRectMake(- 15, 5, 130, 60)];
    title.title         = @"Menu";
    title.delegate      = self;
    title.font          = [UIFont fontWithName:LATO_REGULAR size:26.f];
    [self addSubview:title];
    
    // 添加城市按钮
    UIFont  *font                 = [UIFont fontWithName:LATO_REGULAR size:22.f];
    CGFloat widthForAddMoreCity   = [@"Add More City" widthWithLabelFont:font];
    TapTitleView *addMoreCity     = [[TapTitleView alloc] initWithFrame:CGRectMake(0, Height - Width / 2.f,
                                                                                   widthForAddMoreCity + 60, 60)];
    addMoreCity.title    = @"Add More City";
    addMoreCity.delegate = self;
    addMoreCity.font     = font;
    [self addSubview:addMoreCity];
    addMoreCity.x        = Width - addMoreCity.width;
    addMoreCity.y       += 10.f;
    
    // 当前位置
    CGFloat widthCurrentLocation  = [@"Current Location" widthWithLabelFont:font];
    TapTitleView *currentLocation = [[TapTitleView alloc] initWithFrame:CGRectMake(0, Height - 85,
                                                                                   widthCurrentLocation + 60, 60)];
    currentLocation.tag      = CURRENT_LOCATION;
    currentLocation.title    = @"Current Location";
    currentLocation.delegate = self;
    currentLocation.font     = font;
    [self addSubview:currentLocation];
    currentLocation.x        = Width - currentLocation.width;

    // 初始化tableView
    [self initTableView];
    
    // 灰色的线条
    UIView *line1         = [[UIView alloc] initWithFrame:CGRectMake(0, Height - Width * 1.5, Width, 0.5f)];
    line1.alpha           = 0.1f;
    line1.backgroundColor = [UIColor blackColor];
    [self addSubview:line1];
    
    UIView *line2          = [[UIView alloc] initWithFrame:CGRectMake(0, Height - Width / 2.f, Width, 0.5f)];
    line2.alpha            = 0.1f;
    line2.backgroundColor  = [UIColor blackColor];
    [self addSubview:line2];
    
    // 黑色的view
    UIView *blackView         = [[UIView alloc] initWithFrame:CGRectMake(Width - 5, 0, 5, Height)];
    blackView.backgroundColor = [UIColor blackColor];
    [self addSubview:blackView];
}

/**
 *  初始化tableView
 */
- (void)initTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Height - Width * 1.5, Width, Width)
                                                  style:UITableViewStylePlain];
    self.tableView.delegate       = self;
    self.tableView.dataSource     = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[SearchCell class] forCellReuseIdentifier:@"SearchCell"];
    [self addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SearchCell *searchCell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell"];
    return searchCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return Width / 4.f;
}

@end
