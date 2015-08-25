//
//  TBAPIResponse.m
//  TBNetworking
//
//  Created by DangGu on 15/7/30.
//  Copyright (c) 2015年 Teambition. All rights reserved.
//

#import "TBAPIResponse.h"

@interface TBAPIResponse ()

@property (nonatomic, assign, readwrite) TBAPIResponseStatus status;
@property (nonatomic, assign, readwrite) NSInteger           statusCode;
@property (nonatomic, copy,   readwrite) id                  responseObject;
@property (nonatomic, assign, readwrite) NSInteger           requestID;
@property (nonatomic, assign, readwrite) BOOL                isCache;
@property (nonatomic, strong, readwrite) NSError             *error;

@end

@implementation TBAPIResponse

#pragma mark - life cycle
- (instancetype)initWithRequestID:(NSInteger)requestID responseObject:(id)responseObject statusCode:(NSInteger)statusCode {
    
    self = [super init];
    if (self) {
        self.requestID = requestID;
        self.responseObject = responseObject;
        self.statusCode = statusCode;
        self.status = [self responseStatusWithStatusCode:statusCode];
        self.isCache = NO;
    }
    return self;
}

- (instancetype)initWithRequestID:(NSInteger)requestID responseObject:(id)responseObject statusCode:(NSInteger)statusCode error:(NSError *)error {
    
    self = [super init];
    if (self) {
        self.requestID = requestID;
        self.responseObject = responseObject;
        self.status = [self responseStatusWithError:error];
        self.statusCode = statusCode;
        self.isCache = NO;
        self.error = error;
    }
    return self;
}

#pragma mark - private method
- (TBAPIResponseStatus)responseStatusWithError:(NSError *)error {
    if (error) {
        TBAPIResponseStatus status = TBAPIResponseStatusNoNetwork;
        if (error.code == NSURLErrorTimedOut) {
            status = TBAPIResponseStatusErrorTimeout;
        }
        return status;
    } else {
        return TBAPIResponseStatusSuccess;
    }
}

- (TBAPIResponseStatus)responseStatusWithStatusCode:(NSInteger)statusCode {
    if (statusCode >= 200 && statusCode <= 299) {
        return TBAPIResponseStatusSuccess;
    }
    return TBAPIResponseStatusNoNetwork;
}
@end
