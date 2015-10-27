//
//  ResponseDataSerialization.h
//  Networking
//
//  Created by YouXianMing on 15/8/1.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ResponseDataSerialization <NSObject>

@required
- (id)transformResponseDataWithInputData:(id)data;

@end

#pragma mark - ResponseDataSerializer
@interface ResponseDataSerializer : NSObject <ResponseDataSerialization>

@end

