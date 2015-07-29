//
//  TBAPIBaseManager.h
//  TBNetworking
//
//  Created by ChenHao on 7/29/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBURLResponse.h"

@class TBAPIBaseManager;

/**
 *  拦截器
 */

@protocol TBAPIManagerInterceptor <NSObject>

@optional
- (void)manager:(TBAPIBaseManager *)manager willPerformSuccessResponse:(TBURLResponse *)response;
- (void)manager:(TBAPIBaseManager *)manager didPerformSuccessResponse:(TBURLResponse *)response;

- (void)manager:(TBAPIBaseManager *)manager willPerformFailResponse:(TBURLResponse *)response;
- (void)manager:(TBAPIBaseManager *)manager didPerformFailResponse:(TBURLResponse *)response;


@end

/**
 *  参数设置
 */
@protocol TBAPIManagerParametersDelegate <NSObject>

- (NSDictionary *)parametersForAPI:(TBAPIBaseManager *)manager;

@end

@protocol TBAPIManager <NSObject>



@end


@protocol TBAPIBaseManagerDelegate <NSObject>

- (void)managerCallAPIDidSuccess:(TBAPIBaseManager *)manager;
- (void)managerCallAPIDidFailed:(TBAPIBaseManager *)manager;

@end

@interface TBAPIBaseManager : NSObject

@property (nonatomic, weak) id<TBAPIBaseManagerDelegate> delegate;
@property (nonatomic, weak) id<TBAPIManagerInterceptor> interceptor;
@property (nonatomic, weak) id<TBAPIManagerParametersDelegate> parametersDelegate;


- (NSInteger)loadData;

- (NSInteger)loadDataFromParameters:(NSDictionary *)parameters;

- (void)cancelAllRequest;

- (NSDictionary *)reformParameters:(NSDictionary *)parameters;

@end
