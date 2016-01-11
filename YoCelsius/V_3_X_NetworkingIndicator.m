//
//  V_3_X_NetworkingIndicator.m
//  AFNetworking-3.x
//
//  Created by YouXianMing on 16/1/11.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "V_3_X_NetworkingIndicator.h"
#import "UIKit+AFNetworking.h"

@implementation V_3_X_NetworkingIndicator

+ (void)showNetworkActivityIndicator:(BOOL)show {
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:show];
}

@end
