//
//  TBAPIBaseManager.h
//  TBNetworking
//
//  Created by ChenHao on 7/29/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBURLResponse.h"

@class TBAPIBaseRequest;

/**
 *  拦截器
 */

@protocol TBAPIBaseRequestInterceptor <NSObject>

@optional
- (void)manager:(TBAPIBaseManager *)manager willPerformSuccessResponse:(TBURLResponse *)response;
- (void)manager:(TBAPIBaseManager *)manager didPerformSuccessResponse:(TBURLResponse *)response;

- (void)manager:(TBAPIBaseManager *)manager willPerformFailResponse:(TBURLResponse *)response;
- (void)manager:(TBAPIBaseManager *)manager didPerformFailResponse:(TBURLResponse *)response;


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





@protocol TBAPIManager <NSObject>

@required

//强制子类必须实现的方法
- (NSString *)requestUrl;

- (TBAPIRequestType)requestType;

@end


@protocol TBAPIBaseManagerDelegate <NSObject>

- (void)managerCallAPIDidSuccess:(TBAPIBaseRequest *)request;
- (void)managerCallAPIDidFailed:(TBAPIBaseRequest *)request;

@end

@interface TBAPIBaseRequest : NSObject

@property (nonatomic, weak) id<TBAPIBaseManagerDelegate> delegate;
@property (nonatomic, weak) id<TBAPIBaseRequestInterceptor> interceptor;
@property (nonatomic, weak) NSObject<TBAPIManager> *child;

- (NSString *)baseUrl;

- (void)start;

- (NSInteger)loadData;

- (NSInteger)loadDataFromParameters:(NSDictionary *)parameters;

- (void)cancelAllRequest;

@end
