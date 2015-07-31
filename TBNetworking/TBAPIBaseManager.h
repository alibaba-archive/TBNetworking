//
//  TBAPIBaseManager.h
//  TBNetworking
//
//  Created by ChenHao on 7/29/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@class TBAPIBaseManager;


/*************************************************************************************************/
/*                                TBAPIBaseRequestInterceptor                                    */
/*************************************************************************************************/
/**
 *拦截器
 */
@protocol TBAPIBaseRequestInterceptor <NSObject>

@optional
- (void)requestWillPerformSuccessResponse:(TBAPIBaseManager *)request;
- (void)request:(TBAPIBaseManager *)requst willPerformSuccessWithResponse:(NSURLResponse *)response;
- (void)requestDidPerformSuccessResponse:(TBAPIBaseManager *)request;

- (void)requestWillPerformFailResponse:(TBAPIBaseManager *)response;
- (void)requestDidPerformFailResponse:(TBAPIBaseManager *)response;

@end

/*************************************************************************************************/
/*                             TBAPIBaseRequestParametersDelegate                                */
/*************************************************************************************************/
/**
 *  参数设置
 */
@protocol TBAPIBaseRequestParametersDelegate <NSObject>

- (NSDictionary *)parametersForAPI:(TBAPIBaseManager *)manager;

@end

/*************************************************************************************************/
/*                             TBAPIBaseRequestDelegate                                          */
/*************************************************************************************************/
/**
 *  请求回调协议
 */
@protocol TBAPIBaseRequestDelegate <NSObject>

@optional
- (void)requestAPIDidSuccess:(TBAPIBaseManager *)request;
- (void)requestAPIDidFailed:(TBAPIBaseManager *)request;

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

@optional

- (NSDictionary *)typeJsonValidator;

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

@interface TBAPIBaseManager : NSObject

@property (nonatomic, weak)   id<TBAPIBaseRequestDelegate>     delegate;
@property (nonatomic, weak)   id<TBAPIBaseRequestInterceptor>  interceptor;

@property (nonatomic, assign, readonly) NSTimeInterval         requestTime;

@property (nonatomic, weak)   NSObject<TBAPIRequest>           *child;
@property (nonatomic, strong) NSURLSessionDataTask             *dataTask;

@property (nonatomic, strong) TBAPIResponse                      *response;


- (NSString *)baseUrl;

/**
 *  请求类型,默认为GET请求
 *
 *  @return
 */
- (TBAPIRequestType)requestType;

- (void)start;

- (void)startWithParameters:(NSDictionary *)parameters;

- (void)stop;

/**
 *  参数列表
 *
 *  @return
 */
- (NSDictionary *)parameters;

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

/**
 *  请求头
 *
 *  @return 
 */
- (NSDictionary *)requestHeaderFieldValueDictionary;




@end
