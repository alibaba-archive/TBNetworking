//
//  TBChainManagerAgent.h
//  TBNetworking
//
//  Created by DangGu on 15/7/31.
//  Copyright (c) 2015年 Teambition. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TBChainManager;
@interface TBChainManagerAgent : NSObject

+ (TBChainManagerAgent *)sharedInstance;

- (void)addChainManager:(TBChainManager *)manager;

- (void)removeChainManager:(TBChainManager *)manager;

@end
