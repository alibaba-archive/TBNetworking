//
//  TBAPIProxy.m
//  TBNetworking
//
//  Created by ChenHao on 7/29/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import "TBAPIProxy.h"

@implementation TBAPIProxy


+ (instancetype)sharedInstance {

    static dispatch_once_t onceToken;
    static TBAPIProxy *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TBAPIProxy alloc] init];
    });
    return sharedInstance;
}

- (NSInteger)GETWithParameters:(NSDictionary *)parameters success:(TBCallBack)success {

    NSNumber *requestID = [self request:nil success:success fail:success];
    return [requestID integerValue];
}


#pragma mark - private methods

- (NSNumber *)request:(NSURLRequest *)request success:(TBCallBack )success fail:(TBCallBack)fail {

    return @1;
}
@end
