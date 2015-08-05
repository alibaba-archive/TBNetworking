//
//  TBAPIProxy.h
//  TBNetworking
//
//  Created by ChenHao on 7/29/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBNetworking.h"
#import "TBAPIBatchAgent.h"
#import "TBAPIBaseManager.h"

@interface TBAPIProxy : NSObject

+ (instancetype)sharedInstance;

- (void)addRequest:(TBAPIBaseManager *)request;

- (void)cancelRequest:(TBAPIBaseManager *)request;

- (void)cancelAllRequest;
@end
