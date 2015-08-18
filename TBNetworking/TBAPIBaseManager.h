//
//  TBAPIBaseManager.h
//  TBNetworking
//
//  Created by ChenHao on 7/29/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBLogger.h"

@class TBAPIBaseManager;

/*************************************************************************************************/
/*                                TBAPIBaseManagerInterceptor                                    */
/*************************************************************************************************/
/**
 *拦截器
 */
@protocol TBAPIBaseManagerInterceptor <NSObject>

@optional
- (void)managerWillPerformSuccessResponse:(TBAPIBaseManager *)manager;
- (void)manager:(TBAPIBaseManager *)manager willPerformSuccessWithResponse:(NSURLResponse *)response;
- (void)managerDidPerformSuccessResponse:(TBAPIBaseManager *)manager;

- (void)managerWillPerformFailResponse:(TBAPIBaseManager *)manager;
- (void)managerDidPerformFailResponse:(TBAPIBaseManager *)manager;

@end

/*************************************************************************************************/
/*                             TBAPIBaseManagerParamSourceDelegate                               */
/*************************************************************************************************/
/**
 *  参数设置
 */
@protocol TBAPIBaseManagerParamSourceDelegate <NSObject>
@required
- (NSDictionary *)parametersForAPI:(TBAPIBaseManager *)manager;
@end

/*************************************************************************************************/
/*                             TBAPIBaseManagerDelegate                                          */
/*************************************************************************************************/
/**
 *  请求回调协议
 */
@protocol TBAPIBaseManagerDelegate <NSObject>

@optional
- (void)apiRequestDidSuccess:(TBAPIBaseManager *)manager;
- (void)apiRequestDidFailed:(TBAPIBaseManager *)manager;

@end


/*************************************************************************************************/
/*                                         TBAPIManager                                          */
/*************************************************************************************************/
/**
 *  子类必须遵守的协议
 *  强制子类实现url的实现
 */
@protocol TBAPIManager <NSObject>

@required
- (NSString *)requestUrl;
@optional
- (NSDictionary *)jsonValidator;

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

@property (nonatomic, weak)   id<TBAPIBaseManagerDelegate>              delegate;
@property (nonatomic, weak)   id<TBAPIBaseManagerParamSourceDelegate>   parameSource;
@property (nonatomic, weak)   id<TBAPIBaseManagerInterceptor>           interceptor;

@property (nonatomic, assign, readonly) NSTimeInterval                  requestTime;
@property (nonatomic, strong, readonly) NSDictionary                    *parameters;

@property (nonatomic, weak)   NSObject<TBAPIManager>                    *child;
@property (nonatomic, strong) NSURLSessionDataTask                      *dataTask;

@property (nonatomic, strong) TBAPIResponse                             *response;


- (NSString *)baseUrl;

/**
 *  请求类型,默认为GET请求
 *
 *  @return
 */
- (TBAPIRequestType)requestType;

- (void)start;

//- (void)startWithParameters:(NSDictionary *)parameters;

- (void)stop;

/// 请求的SerializerType
- (TBRequestSerializerType)requestSerializerType;

/// 返回的的SerializerType
- (TBResponseSerializerType)responseSerializerType;

/**
 *  控制台在DEBUG模式下打印的返回结果，默认为LoggerTypeDefault
 *  默认显示不带responseObject
 *
 *  @return 
 */
- (TBLoggerType)responseLoggerType;

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
