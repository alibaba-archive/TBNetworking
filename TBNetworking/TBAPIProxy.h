//
//  TBAPIProxy.h
//  TBNetworking
//
//  Created by ChenHao on 7/29/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "TBURLResponse.h"

typedef void(^TBCallBack) (TBURLResponse *response);

@interface TBAPIProxy : NSObject

+ (instancetype)sharedInstance;

- (NSInteger)GETWithParameters:(NSDictionary *)parameters success:(TBCallBack)success;

@end
