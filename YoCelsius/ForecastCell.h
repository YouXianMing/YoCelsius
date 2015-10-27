//
//  ForecastCell.h
//  YoCelsius
//
//  Created by XianMingYou on 15/2/26.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import <UIKit/UIKit.h>

@interface ForecastCell : UITableViewCell

/**
 *  处理常规数据
 *
 *  @param data 处理的数据
 */
- (void)acccessData:(id)data indexPath:(NSIndexPath *)indexPath;

/**
 *  显示
 */
- (void)show;

/**
 *  隐藏
 */
- (void)hide;

@end
