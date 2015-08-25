//
//  TBAPIProxy.m
//  TBNetworking
//
//  Created by ChenHao on 7/29/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import "TBAPIProxy.h"

@interface TBAPIProxy ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) NSMutableDictionary  *requestsTable;

@end

@implementation TBAPIProxy

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
        [self addReachblityManager:_sessionManager];
    }
    return self;
}

#pragma mark ReachablityManager

- (void)addReachblityManager:(AFHTTPSessionManager *)manager {
    __block AFHTTPSessionManager *managerBlock = manager;
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                managerBlock.operationQueue.maxConcurrentOperationCount = 20;
                [TBLogger TBLog:@"change to Wifi"];
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                managerBlock.operationQueue.maxConcurrentOperationCount = 4;
                [TBLogger TBLog:@"change to 2G/3G"];
            }
            default:
                break;
        }
    }];
    [manager.reachabilityManager startMonitoring];
}

- (NSString *)buildRequestUrl:(TBAPIBaseManager *)request {
    NSString *url = [request.child requestUrl];
    return [NSString stringWithFormat:@"%@%@",request.baseUrl,url];
}

- (void)addRequest:(TBAPIBaseManager *)manager {

    [_sessionManager.requestSerializer setTimeoutInterval:manager.requestTimeOutInterval];
    
    TBAPIRequestType requestMethod = [manager requestType];
    
    
    if (manager.requestSerializerType == TBRequestSerializerTypeHTTP) {
        _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];

    } else {
        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    if (manager.responseSerializerType == TBResponseSerializerTypeHTTP) {
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    } else {
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    
    // if api need add custom value to HTTPHeaderField
    NSDictionary *headerFieldValueDictionary = [manager requestHeaderFieldValueDictionary];
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
            
            manager.dataTask = [self.sessionManager
                                GET:[self buildRequestUrl:manager]
                                parameters:manager.parameters
                                success:^(NSURLSessionDataTask *task, id responseObject) {
                                
                                    TBAPIResponse *response = [[TBAPIResponse alloc] initWithRequestID:task.taskIdentifier
                                                                                      responseObject:[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil]
                                                                                              statusCode:((NSHTTPURLResponse *)task.response).statusCode];
                                    manager.response = response;
                                    [self handleOperate:task];
                               
            }
                                failure:^(NSURLSessionDataTask *task, NSError *error) {
                                    
                                    TBAPIResponse *response = [[TBAPIResponse alloc] initWithRequestID:task.taskIdentifier
                                                                                      responseObject:nil
                                                                                          statusCode:((NSHTTPURLResponse *)task.response).statusCode error:error];
                                    manager.response = response;
                                    [self handleOperate:task];
            }];

        }
            break;
        case TBAPIManagerRequestTypePOST: {
        
            manager.dataTask = [self.sessionManager
                                POST:[self buildRequestUrl:manager]
                                parameters:manager.parameters
                                success:^(NSURLSessionDataTask *task, id responseObject) {
                                    TBAPIResponse *response = [[TBAPIResponse alloc] initWithRequestID:task.taskIdentifier
                                                                                      responseObject:[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil]
                                                                                          statusCode:((NSHTTPURLResponse *)task.response).statusCode];
                                    manager.response = response;
                                    [self handleOperate:task];
            }
                                failure:^(NSURLSessionDataTask *task, NSError *error) {
                                    TBAPIResponse *response = [[TBAPIResponse alloc] initWithRequestID:task.taskIdentifier
                                                                                      responseObject:nil
                                                                                          statusCode:((NSHTTPURLResponse *)task.response).statusCode error:error];
                                    manager.response = response;
                                    [self handleOperate:task];
            }];
            
            
        }
            break;
        case TBAPIManagerRequestTypePUT: {
        
            manager.dataTask = [self.sessionManager
                                PUT:[self buildRequestUrl:manager]
                                parameters:manager.parameters
                                success:^(NSURLSessionDataTask *task, id responseObject) {
                                    TBAPIResponse *response = [[TBAPIResponse alloc] initWithRequestID:task.taskIdentifier
                                                                                      responseObject:[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil]
                                                                                          statusCode:((NSHTTPURLResponse *)task.response).statusCode];
                                    manager.response = response;
                                    [self handleOperate:task];
            }
                                failure:^(NSURLSessionDataTask *task, NSError *error) {
                                    TBAPIResponse *response = [[TBAPIResponse alloc] initWithRequestID:task.taskIdentifier
                                                                                      responseObject:nil
                                                                                          statusCode:((NSHTTPURLResponse *)task.response).statusCode error:error];
                                    manager.response = response;
                                    [self handleOperate:task];
            }];
        }
            break;
        case TBAPIManagerRequestTypeDELETE: {
        
            manager.dataTask = [self.sessionManager
                                DELETE:[self buildRequestUrl:manager]
                                parameters:manager.parameters
                                success:^(NSURLSessionDataTask *task, id responseObject) {
                                    TBAPIResponse *response = [[TBAPIResponse alloc] initWithRequestID:task.taskIdentifier
                                                                                      responseObject:[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil]
                                                                                          statusCode:((NSHTTPURLResponse *)task.response).statusCode];
                                    manager.response = response;
                                    [self handleOperate:task];
            }
                                failure:^(NSURLSessionDataTask *task, NSError *error) {
                                    TBAPIResponse *response = [[TBAPIResponse alloc] initWithRequestID:task.taskIdentifier
                                                                                      responseObject:nil
                                                                                          statusCode:((NSHTTPURLResponse *)task.response).statusCode error:error];
                                    manager.response = response;
                                    
                
                                    [self handleOperate:task];
            }];
        }
        default:
            break;
    }
    
    [self addDataTask:manager];
}

- (void)cancelRequest:(TBAPIBaseManager *)manager {
    [manager stop];
}

- (void)cancelAllRequest {
    NSDictionary *copyTable = [_requestsTable copy];
    for (TBAPIBaseManager *request in copyTable) {
        [self cancelRequest:request];
    }
}



#pragma mark - private method

- (BOOL)checkResult:(TBAPIBaseManager *)request {
    
    if (!(request.response.statusCode >=200 && request.response.statusCode <=299)) {
        return NO;
    }
    
    if ([request respondsToSelector:@selector(jsonValidator)]) {
        NSDictionary *jsonValidator = [((id <TBAPIManager>)request) jsonValidator];
        if (jsonValidator) {
            NSError *error;
            return [TBJSONValidator validateValue:request.response.responseObject withRequirements:jsonValidator error:&error];
        }
    }
    return YES;
}

- (void)handleOperate:(NSURLSessionDataTask  *)dataTask {
    
    NSString *hashKey = [self requestHashKey:dataTask];
    
    TBAPIBaseManager *manager = _requestsTable[hashKey];
    
    [manager complete];
    
    [TBLogger loggerWithRequest:manager responseType:manager.responseLoggerType];
    if (manager) {
        
        BOOL success = [self checkResult:manager];
        if (success) {
            
            if (manager.interceptor && [manager.interceptor respondsToSelector:@selector(managerWillPerformSuccessResponse:)]) {
                [manager.interceptor managerWillPerformSuccessResponse:manager];
            }
            
            if (manager.delegate && [manager.delegate respondsToSelector:@selector(apiRequestDidSuccess:)]) {
                [manager.delegate apiRequestDidSuccess:manager];
            }
            
            if (manager.interceptor && [manager.interceptor respondsToSelector:@selector(managerDidPerformSuccessResponse:)]) {
                [manager.interceptor managerDidPerformSuccessResponse:manager];
            }
            
        }
        else {
            if (manager.interceptor && [manager.interceptor respondsToSelector:@selector(managerWillPerformFailResponse:)]) {
                [manager.interceptor managerWillPerformFailResponse:manager];
            }
            
            if (manager.delegate && [manager.delegate respondsToSelector:@selector(apiRequestDidFailed:)]) {
                [manager.delegate apiRequestDidFailed:manager];
            }
            
            if (manager.interceptor && [manager.interceptor respondsToSelector:@selector(managerDidPerformFailResponse:)]) {
                [manager.interceptor managerDidPerformFailResponse:manager];
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
    [TBLogger TBLog:[NSString stringWithFormat:@"requestsTable size is %lu", (unsigned long) [_requestsTable count]]];
    [TBLogger TBLog:[NSString stringWithFormat:@"Operation quene size is %lu", (unsigned long) self.sessionManager.operationQueue.operationCount]];
}

- (void)removeDataTask:(NSURLSessionDataTask *)dataTask {
    NSString *hashKey = [self requestHashKey:dataTask];
    @synchronized(self) {
        [_requestsTable removeObjectForKey:hashKey];
    }
    [TBLogger TBLog:[NSString stringWithFormat:@"requestsTable size is %lu", (unsigned long) [_requestsTable count]]];
    [TBLogger TBLog:[NSString stringWithFormat:@"Operation quene size is %lu", (unsigned long) self.sessionManager.operationQueue.operationCount]];
}

@end
