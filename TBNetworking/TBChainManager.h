//
//  TBChainManager.h
//  TBNetworking
//
//  Created by DangGu on 15/7/31.
//  Copyright (c) 2015年 Teambition. All rights reserved.
//

#import <Foundation/Foundation.h>


@class TBChainManager;
@class TBAPIBaseManager;
@protocol TBChainManagerDelegate <NSObject>

- (void)chainRequestFinished:(TBChainManager *)manager;
- (void)chainRequestFailed:(TBChainManager *)chainManager failedBaseManager:(TBAPIBaseManager *)manager;

@end

@interface TBChainManager : NSObject

@property (nonatomic, weak) id<TBChainManagerDelegate> delegate;

- (void)start;

- (void)stop;

- (void)addManager:(TBAPIBaseManager *)manager;

@end
