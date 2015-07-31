//
//  TBChainManager.h
//  TBNetworking
//
//  Created by DangGu on 15/7/31.
//  Copyright (c) 2015年 Teambition. All rights reserved.
//

#import <Foundation/Foundation.h>


@class TBAPIChainManager;
@class TBAPIBaseManager;
@protocol TBAPIChainManagerDelegate <NSObject>

- (void)chainAllManagerDidSuccess:(TBAPIChainManager *)chainManager;
- (void)chainSingleManagerDidSuccess:(TBAPIBaseManager *)manager;
- (void)chainAllManagerDidFailed:(TBAPIChainManager *)chainManager failedBaseManager:(TBAPIBaseManager *)manager;

@end

@interface TBAPIChainManager : NSObject

@property (nonatomic, weak) id<TBAPIChainManagerDelegate> delegate;

- (void)start;

- (void)stop;

- (void)addManager:(TBAPIBaseManager *)manager;

@end
