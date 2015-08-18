//
//  RequestDictionarySerialization.h
//  Networking
//
//  Created by YouXianMing on 15/8/1.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RequestDictionarySerialization <NSObject>

@required
- (NSDictionary *)transformRequestDictionaryWithInputDictionary:(NSDictionary *)inputDictionary;

@end

#pragma mark - RequestDictionarySerializer
@interface RequestDictionarySerializer : NSObject <RequestDictionarySerialization>

@end
