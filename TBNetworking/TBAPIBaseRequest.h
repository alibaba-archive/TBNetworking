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

/**
 *  请求类型
 */
typedef NS_ENUM(NSInteger, TBAPIRequestType){
    /**
     *  GET方法
     */
    TBAPIManagerRequestTypeGET,
    /**
     *  POST方法
     */
    TBAPIManagerRequestTypePOST,
    /**
     *  PUT方法
     */
    TBAPIManagerRequestTypePUT,
    /**
     *  DELETE方法
     */
    TBAPIManagerRequestTypeDELETE
};

/**
 *  请求回调协议
 */
@protocol TBAPIBaseRequestDelegate <NSObject>

@optional
- (void)requestAPIDidSuccess:(TBAPIBaseRequest *)request;
- (void)requestAPIDidFailed:(TBAPIBaseRequest *)request;

@end


/**
 *  子类必须遵守的协议
 *  强制子类实现url的实现
 */
@protocol TBAPIRequest <NSObject>

@required

- (NSString *)requestUrl;

@end

@interface TBAPIBaseRequest : NSObject

@property (nonatomic, weak)   id<TBAPIBaseRequestDelegate>     delegate;
@property (nonatomic, weak)   id<TBAPIBaseRequestInterceptor>  interceptor;

@property (nonatomic, assign, readonly) NSTimeInterval         requestTime;

@property (nonatomic, strong) NSObject<TBAPIRequest>           *child;
@property (nonatomic, strong) NSURLSessionDataTask             *dataTask;

@property (nonatomic, assign) NSInteger                        responseStatusCode;


- (NSString *)baseUrl;

- (TBAPIRequestType)requestType;

- (void)start;

- (void)startWithParameters:(NSDictionary *)parameters;

- (void)stop;

/**
 *  根据HTTP状态码来判断本次请求是否成功
 *
 *  @return 在200到299之间为成功
 */
- (BOOL)requestSuccess;

/**
 *  判断是否正在执行
 *
 *  @return
 */
- (BOOL)isExcuting;


/**
 *  请求结束
 */
- (void)complete;
/**
 *  请求超时的时间
 *
 *  @return 
 */
- (NSTimeInterval )requestTimeOutInterval;




@end
