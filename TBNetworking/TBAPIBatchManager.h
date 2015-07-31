//
//  TBAPIBatchManager.h
//  TBNetworking
//
//  Created by ChenHao on 7/31/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBAPIManager.h"

/*************************************************************************************************/
/*                             TBAPIBaseRequestDelegate                                          */
/*************************************************************************************************/
/**
 *  请求回调协议
 */
@class TBAPIBatchManager;
@protocol TBAPIBatchManagerDelegate <NSObject>

@optional

- (void)batchRequestAPIDidSuccess:(TBAPIBatchManager *)request;
- (void)batchRequestAPIDidFailed:(TBAPIBatchManager *)request;

@end

@interface TBAPIBatchManager : NSObject

@property (nonatomic, weak) id<TBAPIBatchManagerDelegate> delegate;
@property (nonatomic, strong, readonly) NSArray *requestBachArray;

- (instancetype)initWithManagerArray:(NSArray *)managerArray;

- (void)start;

- (void)stop;


@end
