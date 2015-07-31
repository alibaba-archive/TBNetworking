//
//  TBAPIProxy.m
//  TBNetworking
//
//  Created by ChenHao on 7/29/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import "TBAPIProxy.h"
#import "TBAPIResponse.h"

@interface TBAPIProxy ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation TBAPIProxy {

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

        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.operationQueue.maxConcurrentOperationCount = 4;

        _requestsTable = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (NSString *)buildRequestUrl:(TBAPIBaseRequest *)request {
    NSString *url = [request.child requestUrl];
    return [NSString stringWithFormat:@"%@%@",request.baseUrl,url];
}

- (void)addRequest:(TBAPIBaseRequest *)request {

    TBAPIRequestType requestMethod = [request requestType];
    
    
    if (request.requestSerializerType == TBRequestSerializerTypeHTTP) {
        _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];

    } else {
        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    if (request.responseSerializerType == TBResponseSerializerTypeHTTP) {
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    } else {
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    
    switch (requestMethod) {
        case TBAPIManagerRequestTypeGET: {
            
            request.dataTask = [self.sessionManager
                                GET:[self buildRequestUrl:request]
                                parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                                    [self handleOperate:task];
                                    
                                    TBAPIResponse *response = [[TBAPIResponse alloc] initWithRequest:request
                                                                                           requestID:task.taskIdentifier
                                                                                      responseObject:responseObject
                                                                                              statusCode:((NSHTTPURLResponse *)task.response).statusCode];
                                    request.response = response;
                                    [TBLogger loggerWithRequest:request];
                               
            }
                                failure:^(NSURLSessionDataTask *task, NSError *error) {
                                    [self handleOperate:task];
                                    TBAPIResponse *response = [[TBAPIResponse alloc] initWithRequest:request
                                                                                           requestID:task.taskIdentifier
                                                                                      responseObject:nil
                                                                                          statusCode:((NSHTTPURLResponse *)task.response).statusCode error:error];
                                   
                                    request.response = response;
                                    [TBLogger loggerWithRequest:request error:error];
            }];

        }
            break;
        case TBAPIManagerRequestTypePOST: {
        
            request.dataTask = [self.sessionManager
                                POST:[self buildRequestUrl:request]
                                parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                [self handleOperate:task];
            }
                                failure:^(NSURLSessionDataTask *task, NSError *error) {
                [self handleOperate:task];
            }];
            
            
        }
            break;
        case TBAPIManagerRequestTypePUT: {
        
            request.dataTask = [self.sessionManager
                                PUT:[self buildRequestUrl:request]
                                parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                [self handleOperate:task];
            }
                                failure:^(NSURLSessionDataTask *task, NSError *error) {
                [self handleOperate:task];
            }];
        }
            break;
        case TBAPIManagerRequestTypeDELETE: {
        
            request.dataTask = [self.sessionManager DELETE:[self buildRequestUrl:request] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                [self handleOperate:task];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [self handleOperate:task];
            }];
        }
        default:
            break;
    }
    
    [self addDataTask:request];
}

- (void)cancelRequest:(TBAPIBaseRequest *)request {
    [request stop];
}

- (void)cancelAllRequest {
    NSDictionary *copyTable = [_requestsTable copy];
    for (TBAPIBaseRequest *request in copyTable) {
        [self cancelRequest:request];
    }
    
}



#pragma mark - private method

- (BOOL)checkResult:(TBAPIBaseRequest *)request {

    return YES;
}

- (void)handleOperate:(NSURLSessionDataTask  *)dataTask {
    NSString *hashKey = [self requestHashKey:dataTask];
    
    TBAPIBaseRequest *request = _requestsTable[hashKey];
    [request complete];
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
    [self removeDataTask:dataTask];
   
    
}

- (NSString *)requestHashKey :(NSURLSessionDataTask  *)dataTsk {
    NSString *hashKey = [NSString stringWithFormat:@"%lu",(unsigned long)[dataTsk hash]];
    return hashKey;
}

- (void)addDataTask:(TBAPIBaseRequest *)request {
    if (request.dataTask!=nil) {
        NSString *hashKey = [self requestHashKey:request.dataTask];
        @synchronized(self) {
            _requestsTable[hashKey] = request;
        }
    }
    TBLog(@"requestsTable size is %lu", (unsigned long) [_requestsTable count]);
    TBLog(@"Operation quene size is %lu", (unsigned long) self.sessionManager.operationQueue.operationCount);
}

- (void)removeDataTask:(NSURLSessionDataTask *)dataTask {
    NSString *hashKey = [self requestHashKey:dataTask];
    @synchronized(self) {
        [_requestsTable removeObjectForKey:hashKey];
    }
    TBLog(@"current quene size is %lu", (unsigned long) [_requestsTable count]);
    TBLog(@"Operation quene size is %lu", (unsigned long) self.sessionManager.operationQueue.operationCount);
}

@end
