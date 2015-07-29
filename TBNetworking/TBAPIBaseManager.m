//
//  TBAPIBaseManager.m
//  TBNetworking
//
//  Created by ChenHao on 7/29/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import "TBAPIBaseManager.h"
#import <AFNetworking.h>

@implementation TBAPIBaseManager



- (NSInteger)loadData {
    NSDictionary *parameters = [self.parametersDelegate parametersForAPI:self];
    return [self loadDataFromParameters:parameters];
}

- (NSInteger)loadDataFromParameters:(NSDictionary *)parameters {

    NSInteger requestID = 0;
    NSDictionary *APIParameters = [self reformParameters:parameters];
    
    [self willPerformSuccessResponse:nil];
    [self.delegate managerCallAPIDidSuccess:self];
    
    
    return 1;
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
