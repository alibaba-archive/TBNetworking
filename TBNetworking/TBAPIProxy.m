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
    NSMutableDictionary *_requestsTable;
    
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
        _requestsTable = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (NSString *)buildRequestUrl:(TBAPIBaseRequest *)request {
    NSString *url = [request requestUrl];
    return [NSString stringWithFormat:@"%@%@",request.baseUrl,url];
}

- (void)addRequest:(TBAPIBaseRequest *)request {

    TBAPIRequestType requestMethod = [request requestType];
    
    switch (requestMethod) {
        case TBAPIManagerRequestTypeGET: {
            NSLog(@"%@",[self buildRequestUrl:request]);
            request.requestOperation = [_manager GET:[self buildRequestUrl:request] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                [self handleOperate:operation];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [self handleOperate:operation];
                
            }];
        }
            break;
        case TBAPIManagerRequestTypePOST: {
        
            
        }
            break;
            
        default:
            break;
    }
    
    [self addOperation:request];

    
}

- (BOOL)checkResult:(TBAPIBaseRequest *)request {

    return YES;
}

- (void)handleOperate:(AFHTTPRequestOperation *)operate {
    NSString *hashKey = [self requestHashKey:operate];
    
    TBAPIBaseRequest *request = _requestsTable[hashKey];
    if (request) {
        BOOL success = [self checkResult:request];
        if (success) {
            
            if (request.interceptor && [request.interceptor respondsToSelector:@selector(requestWillPerformSuccessResponse:)]) {
                [request.interceptor requestWillPerformSuccessResponse:request];
            }
            
            if (request.delegate && [request.delegate respondsToSelector:@selector(requestAPIDidSuccess:)]) {
                [request.delegate requestAPIDidSuccess:request];
            }
            
            if (request.interceptor && [request.interceptor respondsToSelector:@selector(requestDidPerformSuccessResponse:)]) {
                [request.interceptor requestDidPerformSuccessResponse:request];
            }
            
        }
        else {
            if (request.interceptor && [request respondsToSelector:@selector(requestWillPerformFailResponse:)]) {
                [request.interceptor requestWillPerformFailResponse:request];
            }
            
            if (request.delegate && [request respondsToSelector:@selector(requestAPIDidFailed:)]) {
                [request.delegate requestAPIDidFailed:request];
            }
            
            if (request.interceptor && [request respondsToSelector:@selector(requestDidPerformFailResponse:)]) {
                [request.interceptor requestDidPerformFailResponse:request];
            }
            
        }
    }
   
    
}

- (NSString *)requestHashKey :(AFHTTPRequestOperation *)operation {
    NSString *hashKey = [NSString stringWithFormat:@"%lu",(unsigned long)[operation hash]];
    return hashKey;
}

- (void)addOperation:(TBAPIBaseRequest *)request {

    if (request.requestOperation!=nil) {
        NSString *hashKey = [self requestHashKey:request.requestOperation];
        @synchronized(self) {
            _requestsTable[hashKey] = request;
        }
    }
    
}
@end
