//
//  TBAPIProxy.m
//  TBNetworking
//
//  Created by ChenHao on 7/29/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import "TBAPIProxy.h"
#import "TBAPIResponse.h"
#import "TBValidator.h"

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

- (NSString *)buildRequestUrl:(TBAPIBaseManager *)request {
    NSString *url = [request.child requestUrl];
    return [NSString stringWithFormat:@"%@%@",request.baseUrl,url];
}

- (void)addRequest:(TBAPIBaseManager *)request {

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
    
    // if api need add custom value to HTTPHeaderField
    NSDictionary *headerFieldValueDictionary = [request requestHeaderFieldValueDictionary];
    if (headerFieldValueDictionary != nil) {
        for (id httpHeaderField in headerFieldValueDictionary.allKeys) {
            id value = headerFieldValueDictionary[httpHeaderField];
            if ([httpHeaderField isKindOfClass:[NSString class]] && [value isKindOfClass:[NSString class]]) {
                [_sessionManager.requestSerializer setValue:(NSString *)value forHTTPHeaderField:(NSString *)httpHeaderField];
            } else {

            }
        }
    }

    switch (requestMethod) {
        case TBAPIManagerRequestTypeGET: {
            
            request.dataTask = [self.sessionManager
                                GET:[self buildRequestUrl:request]
                                parameters:request.parameters success:^(NSURLSessionDataTask *task, id responseObject) {
                                
                                    TBAPIResponse *response = [[TBAPIResponse alloc] initWithRequest:request
                                                                                           requestID:task.taskIdentifier
                                                                                      responseObject:[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil]
                                                                                              statusCode:((NSHTTPURLResponse *)task.response).statusCode];
                                    request.response = response;
                                    [self handleOperate:task];
                               
            }
                                failure:^(NSURLSessionDataTask *task, NSError *error) {
                                    
                                    TBAPIResponse *response = [[TBAPIResponse alloc] initWithRequest:request
                                                                                           requestID:task.taskIdentifier
                                                                                      responseObject:nil
                                                                                          statusCode:((NSHTTPURLResponse *)task.response).statusCode error:error];
                                    request.response = response;
                                    [self handleOperate:task];
            }];

        }
            break;
        case TBAPIManagerRequestTypePOST: {
        
            request.dataTask = [self.sessionManager
                                POST:[self buildRequestUrl:request]
                                parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                                    TBAPIResponse *response = [[TBAPIResponse alloc] initWithRequest:request
                                                                                           requestID:task.taskIdentifier
                                                                                      responseObject:[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil]
                                                                                          statusCode:((NSHTTPURLResponse *)task.response).statusCode];
                                    request.response = response;
                                    [self handleOperate:task];
            }
                                failure:^(NSURLSessionDataTask *task, NSError *error) {
                                    TBAPIResponse *response = [[TBAPIResponse alloc] initWithRequest:request
                                                                                           requestID:task.taskIdentifier
                                                                                      responseObject:nil
                                                                                          statusCode:((NSHTTPURLResponse *)task.response).statusCode error:error];
                                    request.response = response;
                                    [self handleOperate:task];
            }];
            
            
        }
            break;
        case TBAPIManagerRequestTypePUT: {
        
            request.dataTask = [self.sessionManager
                                PUT:[self buildRequestUrl:request]
                                parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                                    TBAPIResponse *response = [[TBAPIResponse alloc] initWithRequest:request
                                                                                           requestID:task.taskIdentifier
                                                                                      responseObject:[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil]
                                                                                          statusCode:((NSHTTPURLResponse *)task.response).statusCode];
                                    request.response = response;
                                    [self handleOperate:task];
            }
                                failure:^(NSURLSessionDataTask *task, NSError *error) {
                                    TBAPIResponse *response = [[TBAPIResponse alloc] initWithRequest:request
                                                                                           requestID:task.taskIdentifier
                                                                                      responseObject:nil
                                                                                          statusCode:((NSHTTPURLResponse *)task.response).statusCode error:error];
                                    request.response = response;
                                    [self handleOperate:task];
            }];
        }
            break;
        case TBAPIManagerRequestTypeDELETE: {
        
            request.dataTask = [self.sessionManager
                                DELETE:[self buildRequestUrl:request]
                                parameters:nil
                                success:^(NSURLSessionDataTask *task, id responseObject) {
                                    TBAPIResponse *response = [[TBAPIResponse alloc] initWithRequest:request
                                                                                           requestID:task.taskIdentifier
                                                                                      responseObject:[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil]
                                                                                          statusCode:((NSHTTPURLResponse *)task.response).statusCode];
                                    request.response = response;
                                    [self handleOperate:task];
            }
                                failure:^(NSURLSessionDataTask *task, NSError *error) {
                                    TBAPIResponse *response = [[TBAPIResponse alloc] initWithRequest:request
                                                                                           requestID:task.taskIdentifier
                                                                                      responseObject:nil
                                                                                          statusCode:((NSHTTPURLResponse *)task.response).statusCode error:error];
                                    request.response = response;
                                    
                
                                    [self handleOperate:task];
            }];
        }
        default:
            break;
    }
    
    [self addDataTask:request];
}

- (void)cancelRequest:(TBAPIBaseManager *)request {
    [request stop];
}

- (void)cancelAllRequest {
    NSDictionary *copyTable = [_requestsTable copy];
    for (TBAPIBaseManager *request in copyTable) {
        [self cancelRequest:request];
    }
    
}



#pragma mark - private method

- (BOOL)checkResult:(TBAPIBaseManager *)request {

    BOOL result;
    if ([request respondsToSelector:@selector(typeJsonValidator)]) {
        NSDictionary *typeJsonValidator = [((id <TBAPIRequest>)request) typeJsonValidator];
        if (typeJsonValidator) {
            result = [TBValidator checkJsonType:request.response.responseObject withValidator:typeJsonValidator];
            if (!result) {
               TBLog(@"类型验证没通过");
            }
        }
    }
    
    return request;
}

- (void)handleOperate:(NSURLSessionDataTask  *)dataTask {
    
    
    
    NSString *hashKey = [self requestHashKey:dataTask];
    
    TBAPIBaseManager *request = _requestsTable[hashKey];
    
    [TBLogger loggerWithRequest:request];
    
    [request complete];
    if (request) {
        
        BOOL success = [self checkResult:request];
        if (success) {
            
            if (request.interceptor && [request.interceptor respondsToSelector:@selector(requestWillPerformSuccessResponse:)]) {
                [request.interceptor requestWillPerformSuccessResponse:request];
            }
            
            if (request.delegate && [request.delegate respondsToSelector:@selector(requestAPIDidSuccess:)]) {
                [request.delegate apiRequestDidSuccess:request];
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
                [request.delegate apiRequestDidFailed:request];
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

- (void)addDataTask:(TBAPIBaseManager *)request {
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
