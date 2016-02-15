//
//  SearchCell.m
//  YoCelsius
//
//  Created by XianMingYou on 15/3/2.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "SearchCell.h"

@interface SearchCell ()

@property (nonatomic, strong) UILabel *cityLabel;
@property (nonatomic, strong) UILabel *countryLabel;
@property (nonatomic, strong) UIView  *blackView;

@end

@implementation SearchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self buildViews];
    }
    
    return self;
}

- (void)buildViews {
    
    // 国家编号
    self.blackView                  = [[UIView alloc] initWithFrame:CGRectMake(25, 25, 50, 28)];
    self.blackView.backgroundColor  = [UIColor redColor];
    [self addSubview:self.blackView];
    self.countryLabel               = [[UILabel alloc] initWithFrame:self.blackView.bounds];
    self.countryLabel.text          = @"CN";
    self.countryLabel.font          = [UIFont fontWithName:LATO_LIGHT size:20.f];
    self.countryLabel.textAlignment = NSTextAlignmentCenter;
    self.countryLabel.textColor     = [UIColor whiteColor];
    [self.blackView addSubview:self.countryLabel];
    
    // 城市名字
    self.cityLabel               = [[UILabel alloc] initWithFrame:CGRectMake(25 + 70, 25, 200, 28)];
    self.cityLabel.textAlignment = NSTextAlignmentLeft;
    self.cityLabel.font          = [UIFont fontWithName:LATO_LIGHT size:24.f];
    self.cityLabel.textColor     = [UIColor blackColor];
    self.cityLabel.text          = @"Beijin";
    [self addSubview:self.cityLabel];
}

@end
