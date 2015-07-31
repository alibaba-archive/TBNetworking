//
//  TBAPIBaseManager.m
//  TBNetworking
//
//  Created by ChenHao on 7/29/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import "TBAPIBaseManager.h"
#import "TBAPIProxy.h"

@interface TBAPIBaseManager()

@property (nonatomic, assign, readwrite) NSTimeInterval     requestTime;
@property (nonatomic, strong) NSDate                        *requestStartTime;
@property (nonatomic, strong) NSDate                        *requestEndTime;

@end

@implementation TBAPIBaseManager

- (instancetype)init {

    self = [super init];
    if (self) {
        self.delegate = nil;
        
        if ([self conformsToProtocol:@protocol(TBAPIRequest)]) {
            self.child = (id <TBAPIRequest>)self;
        }
    }
    return self;
}

- (NSString *)baseUrl {
    return @"http://apis.baidu.com/apistore/";
}

- (NSString *)requestUrl {

    return @"";
}

- (TBAPIRequestType )requestType {

    return TBAPIManagerRequestTypeGET;
}

- (TBRequestSerializerType)requestSerializerType {
    return TBRequestSerializerTypeHTTP;
}

- (TBResponseSerializerType)responseSerializerType {
    return TBResponseSerializerTypeHTTP;
}

- (void)start {
    self.requestStartTime = [NSDate date];
    [[TBAPIProxy sharedInstance] addRequest:self];
}

- (void)startWithParameters:(NSDictionary *)parameters {

    
}

- (void)stop {
    
    [self.dataTask cancel];
    [self setDelegate:nil];
    
}

- (void)complete {

    NSDate *now = [NSDate date];
    _requestTime = [now timeIntervalSinceDate:self.requestStartTime];
}

- (BOOL)isExcuting {
    return self.dataTask.state == NSURLSessionTaskStateRunning;
}

- (NSTimeInterval )requestTimeOutInterval {
    return 0;
}

@end
