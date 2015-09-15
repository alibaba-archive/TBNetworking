//
//  TBAPIBatchManager.h
//  TBNetworking
//
//  Created by ChenHao on 7/31/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBAPIBaseManager.h"
#import "TBAPIBatchManagerAgent.h"

/*************************************************************************************************/
/*                             TBAPIBaseRequestDelegate                                          */
/*************************************************************************************************/
/**
 *  请求回调协议
 */
@class TBAPIBatchManager;
@protocol TBAPIBatchManagerDelegate <NSObject>

@optional

- (void)batchManagerDidSuccess:(TBAPIBatchManager *)manager __deprecated_msg("use (void)batchManagerDidFinish:");
- (void)batchManagerDidFailed:(TBAPIBatchManager *)manager __deprecated_msg("use (void)batchManagerDidFinish:");

/**
 *  when batch resuests all finished
 *
 *  @param manager TBAPIBatchManager
 */
- (void)batchManagerDidFinish:(TBAPIBatchManager *)manager;

- (void)batchSubManagerDidSuccess:(TBAPIBaseManager *)manager;

- (void)batchSubManagerDidFaild:(TBAPIBaseManager *)manager;

@end

@interface TBAPIBatchManager : NSObject

@property (nonatomic, weak) id<TBAPIBatchManagerDelegate> delegate;
@property (nonatomic, strong, readonly)     NSArray     *requestBachArray;
@property (nonatomic, strong, readonly)     NSArray     *successArray;
@property (nonatomic, strong, readonly)     NSArray     *faildArray;
@property (nonatomic, assign, readonly)     NSInteger   successCount;
@property (nonatomic, assign, readonly)     NSInteger   faildCount;

- (instancetype)initWithManagerArray:(NSArray *)managerArray;

- (void)addManager:(TBAPIBaseManager *)manager;

- (void)start;

- (void)stop;

@end
