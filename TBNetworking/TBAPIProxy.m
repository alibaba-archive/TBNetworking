//
//  TBAPIProxy.m
//  TBNetworking
//
//  Created by ChenHao on 7/29/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import "TBAPIProxy.h"

@implementation TBAPIProxy {

    AFHTTPRequestOperationManager *_manager;
    
}


+ (instancetype)sharedInstance {

    static dispatch_once_t onceToken;
    static TBAPIProxy *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TBAPIProxy alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {

    self = [super init];
    if (self) {
        _manager = [AFHTTPRequestOperationManager manager];
    }
    return self;
}

- (void)addRequest:(TBAPIBaseRequest *)request {

    TBAPIRequestType requestMethod = [request requestType];
    
    switch (requestMethod) {
        case TBAPIManagerRequestTypeGET: {
        
            request.requestOPeration = [_manager GET:[request requestUrl] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                [self handleOperate:operation];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [self handleOperate:operation];
            }];
        }
            break;
            
        default:
            break;
    }
    
}

- (void)handleOperate:(AFHTTPRequestOperation *)operate {

    
}
@end
