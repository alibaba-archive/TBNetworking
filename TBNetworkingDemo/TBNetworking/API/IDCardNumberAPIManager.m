//
//  IDCardNumberAPIManager.m
//  TBNetworking
//
//  Created by DangGu on 15/8/3.
//  Copyright (c) 2015年 Teambition. All rights reserved.
//

#import "IDCardNumberAPIManager.h"

@interface IDCardNumberAPIManager()

@end

@implementation IDCardNumberAPIManager

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSString *)requestUrl {
    return @"idservice/id";
}

- (NSDictionary *)parametersForAPI:(TBAPIBaseManager *)manager {
    return @{@"id":@"360421199306080039"};
}

- (TBLoggerType )responseLoggerType {
    return TBLoggerTypeDetail;
}


@end
