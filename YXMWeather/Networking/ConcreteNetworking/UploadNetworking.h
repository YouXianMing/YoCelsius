//
//  UploadNetworking.h
//  Networking
//
//  Created by YouXianMing on 15/8/2.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "Networking.h"

typedef void(^ConstructingBodyBlock)(id<AFMultipartFormData> formData);

@interface UploadNetworking : Networking

@property (nonatomic, copy) ConstructingBodyBlock   constructingBodyBlock;

@end
