//
//  TBChainManagerAgent.h
//  TBNetworking
//
//  Created by DangGu on 15/7/31.
//  Copyright (c) 2015年 Teambition. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TBAPIChainManager;
@interface TBAPIChainManagerAgent : NSObject

+ (TBAPIChainManagerAgent *)sharedInstance;

- (void)addChainManager:(TBAPIChainManager *)manager;

- (void)removeChainManager:(TBAPIChainManager *)manager;

@end
