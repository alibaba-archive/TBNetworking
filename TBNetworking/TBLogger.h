//
//  TBLogger.h
//  TBNetworking
//
//  Created by ChenHao on 7/30/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TBAPIBaseManager;

typedef NS_ENUM(NSInteger, TBLoggerType) {
    TBLoggerTypeDefault,
    TBLoggerTypeNone,
    TBLoggerTypeNoResponseObject,
    TBLoggerTypeDetail,
};

@interface TBLogger : NSObject

+ (void)loggerWithRequest:(TBAPIBaseManager *)request responseType:(TBLoggerType )type;

+ (void)loggerWithRequest:(TBAPIBaseManager *)request error:(NSError *)error responseType:(TBLoggerType )type;

+ (void)TBLog:(NSString *)log;
@end
