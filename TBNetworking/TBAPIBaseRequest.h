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


/*************************************************************************************************/
/*                                TBAPIBaseRequestInterceptor                                    */
/*************************************************************************************************/
/**
 *拦截器
 */
@protocol TBAPIBaseRequestInterceptor <NSObject>

@optional
- (void)requestWillPerformSuccessResponse:(TBAPIBaseRequest *)request;
- (void)request:(TBAPIBaseRequest *)requst willPerformSuccessWithResponse:(NSURLResponse *)response;
- (void)requestDidPerformSuccessResponse:(TBAPIBaseRequest *)request;

- (void)requestWillPerformFailResponse:(TBAPIBaseRequest *)response;
- (void)requestDidPerformFailResponse:(TBAPIBaseRequest *)response;

@end

/*************************************************************************************************/
/*                             TBAPIBaseRequestParametersDelegate                                */
/*************************************************************************************************/
/**
 *  参数设置
 */
@protocol TBAPIBaseRequestParametersDelegate <NSObject>

- (NSDictionary *)parametersForAPI:(TBAPIBaseRequest *)manager;

@end

/*************************************************************************************************/
/*                             TBAPIBaseRequestDelegate                                          */
/*************************************************************************************************/
/**
 *  请求回调协议
 */
@protocol TBAPIBaseRequestDelegate <NSObject>

@optional
- (void)requestAPIDidSuccess:(TBAPIBaseRequest *)request;
- (void)requestAPIDidFailed:(TBAPIBaseRequest *)request;

@end


/*************************************************************************************************/
/*                                         TBAPIRequest                                          */
/*************************************************************************************************/
/**
 *  子类必须遵守的协议
 *  强制子类实现url的实现
 */
@protocol TBAPIRequest <NSObject>

@required

- (NSString *)requestUrl;

@end

/*************************************************************************************************/
/*                                         Enums                                                 */
/*************************************************************************************************/
/**
 *  请求类型
 */
typedef NS_ENUM(NSInteger, TBAPIRequestType){
    TBAPIManagerRequestTypeGET,
    TBAPIManagerRequestTypePOST,
    TBAPIManagerRequestTypePUT,
    TBAPIManagerRequestTypeDELETE
};

typedef NS_ENUM(NSInteger , TBRequestSerializerType) {
    TBRequestSerializerTypeHTTP = 0,
    TBRequestSerializerTypeJSON,
};

typedef NS_ENUM(NSInteger , TBResponseSerializerType) {
    TBResponseSerializerTypeHTTP = 0,
    TBResponseSerializerTypeJSON,
};



@class TBAPIResponse;

@interface TBAPIBaseRequest : NSObject

@property (nonatomic, weak)   id<TBAPIBaseRequestDelegate>     delegate;
@property (nonatomic, weak)   id<TBAPIBaseRequestInterceptor>  interceptor;

@property (nonatomic, assign, readonly) NSTimeInterval         requestTime;

@property (nonatomic, weak)   NSObject<TBAPIRequest>           *child;
@property (nonatomic, strong) NSURLSessionDataTask             *dataTask;

//@property (nonatomic, assign) id                               responseObject;
//@property (nonatomic, assign) NSInteger                        responseStatusCode;
@property (nonatomic, strong) TBAPIResponse                      *response;


- (NSString *)baseUrl;

- (TBAPIRequestType)requestType;

- (void)start;

- (void)startWithParameters:(NSDictionary *)parameters;

- (void)stop;



/// 请求的SerializerType
- (TBRequestSerializerType)requestSerializerType;

/// 返回的的SerializerType
- (TBResponseSerializerType)responseSerializerType;

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
