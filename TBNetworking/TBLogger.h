//
//  TBLogger.h
//  TBNetworking
//
//  Created by ChenHao on 7/30/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBAPIBaseManager.h"

@interface TBLogger : NSObject

+ (void)loggerWithRequest:(TBAPIBaseManager *)request;

+ (void)loggerWithRequest:(TBAPIBaseManager *)request error:(NSError *)error;

+ (void)TBLog:(NSString *)log;
@end
