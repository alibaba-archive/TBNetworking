//
//  TBAPIProxy.h
//  TBNetworking
//
//  Created by ChenHao on 7/29/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "TBAPIBaseRequest.h"

typedef void(^TBCallBack) (NSURLResponse *response);

@interface TBAPIProxy : NSObject

+ (instancetype)sharedInstance;

- (void)addRequest:(TBAPIBaseRequest *)request;

@end
