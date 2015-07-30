//
//  TBAPIProxy.m
//  TBNetworking
//
//  Created by ChenHao on 7/29/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import "TBAPIProxy.h"
#import "TBLogger.h"


@interface TBAPIProxy ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

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

        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.operationQueue.maxConcurrentOperationCount = 4;

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
            
           
            request.dataTask = [self.sessionManager GET:[self buildRequestUrl:request] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                [self handleOperate:task];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                 [self handleOperate:task];
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

- (void)handleOperate:(NSURLSessionDataTask  *)dataTask {
    NSString *hashKey = [self requestHashKey:dataTask];
    
    TBAPIBaseRequest *request = _requestsTable[hashKey];
    
    if (request) {
        [TBLogger loggerWithRequest:request];
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

- (NSString *)requestHashKey :(NSURLSessionDataTask  *)dataTsk {
    NSString *hashKey = [NSString stringWithFormat:@"%lu",(unsigned long)[dataTsk hash]];
    return hashKey;
}

- (void)addOperation:(TBAPIBaseRequest *)request {

    if (request.requestOperation!=nil) {
        NSString *hashKey = [self requestHashKey:request.dataTask];
        @synchronized(self) {
            _requestsTable[hashKey] = request;
        }
    }
    
}
@end
