//
//  TBAPIBaseManager.h
//  TBNetworking
//
//  Created by ChenHao on 7/29/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@class TBAPIBaseRequest;

/**
 *  拦截器
 */

@protocol TBAPIBaseRequestInterceptor <NSObject>

@optional
- (void)requestWillPerformSuccessResponse:(TBAPIBaseRequest *)request;
- (void)requestDidPerformSuccessResponse:(TBAPIBaseRequest *)request;

- (void)requestWillPerformFailResponse:(TBAPIBaseRequest *)response;
- (void)requestDidPerformFailResponse:(TBAPIBaseRequest *)response;


@end

/**
 *  参数设置
 */
@protocol TBAPIBaseRequestParametersDelegate <NSObject>

- (NSDictionary *)parametersForAPI:(TBAPIBaseRequest *)manager;

@end

typedef NS_ENUM(NSInteger, TBAPIRequestType) {
    TBAPIManagerRequestTypeGET,
    TBAPIManagerRequestTypePOST,
    TBAPIManagerRequestTypePUT,
    TBAPIManagerRequestTypeDELETE
};


@protocol TBAPIBaseRequestDelegate <NSObject>

@optional
- (void)requestAPIDidSuccess:(TBAPIBaseRequest *)request;
- (void)requestAPIDidFailed:(TBAPIBaseRequest *)request;

@end

@interface TBAPIBaseRequest : NSObject

@property (nonatomic, weak)   id<TBAPIBaseRequestDelegate>     delegate;
@property (nonatomic, weak)   id<TBAPIBaseRequestInterceptor>  interceptor;

@property (nonatomic, strong) AFHTTPRequestOperation           *requestOperation;
@property (nonatomic, strong) NSURLSessionDataTask             *dataTask;

@property (nonatomic, assign) NSInteger                        responseStatusCode;


- (NSString *)baseUrl;

- (NSString *)requestUrl;

- (TBAPIRequestType)requestType;

- (void)start;

- (void)startWithParameters:(NSDictionary *)parameters;

- (void)stop;

- (BOOL)isExcuting;

- (NSTimeInterval )requestTimeOutInterval;




@end
