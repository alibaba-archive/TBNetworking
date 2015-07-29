//
//  TBAPIBaseManager.m
//  TBNetworking
//
//  Created by ChenHao on 7/29/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import "TBAPIBaseRequest.h"
#import "TBAPIProxy.h"

@implementation TBAPIBaseRequest


- (instancetype)init {

    self = [super init];
    if (self) {
        
        self.delegate = nil;
        if ([self conformsToProtocol:@protocol(TBAPIManager)]) {
            self.child = (id<TBAPIManager>)self;
        }
    }
    return self;
}

- (NSString *)baseUrl {
    return @"https://www.v2ex.com/api/";
}

- (void)start {

    [[TBAPIProxy sharedInstance] addRequest:self];
}



- (void)cancelAllRequest {

    
}



#pragma mark - method interceptor

- (void)willPerformSuccessResponse:(TBURLResponse *)response {
    
    if (self!= self.interceptor && [self.interceptor respondsToSelector:@selector(manager:willPerformSuccessResponse:)]) {
        [self.interceptor manager:self willPerformSuccessResponse:response];
    }
    
    
}

- (void)didPerformSuccessReponse:(TBURLResponse *)response {

    
}
@end
