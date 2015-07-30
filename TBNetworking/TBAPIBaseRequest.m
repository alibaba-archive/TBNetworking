//
//  TBAPIBaseManager.m
//  TBNetworking
//
//  Created by ChenHao on 7/29/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import "TBAPIBaseRequest.h"
#import "TBAPIProxy.h"

@interface TBAPIBaseRequest()

@property (nonatomic, assign, readwrite) NSTimeInterval     requestTime;
@property (nonatomic, strong) NSDate                        *requestStartTime;
@property (nonatomic, strong) NSDate                        *requestEndTime;

@end

@implementation TBAPIBaseRequest

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
    return @"https://www.v2ex.com/api/";
}

- (NSString *)requestUrl {

    return @"";
}

- (TBAPIRequestType )requestType {

    return TBAPIManagerRequestTypeGET;
}

- (NSInteger)responseStatusCode {
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)self.dataTask.response;
    return response.statusCode;
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

- (BOOL)requestSuccess {

    NSInteger stateCode = [self responseStatusCode];
    if (stateCode >=200 && stateCode <=299) {
        return YES;
    }
    return NO;
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
