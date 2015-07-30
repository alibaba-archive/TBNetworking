//
//  TBLogger.h
//  TBNetworking
//
//  Created by ChenHao on 7/30/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBAPIBaseRequest.h"

#ifdef DEBUG
#define TBLog(fmt, ...)  NSLog(fmt, ##__VA_ARGS__)
#else
#define TBLOG(fmt,...);
#endif

@interface TBLogger : NSObject

+ (void)loggerWithRequest:(TBAPIBaseRequest *)request;

+ (void)loggerWithRequest:(TBAPIBaseRequest *)request error:(NSError *)error;
@end
