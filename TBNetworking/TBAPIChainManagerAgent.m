//
//  TBChainManagerAgent.m
//  TBNetworking
//
//  Created by DangGu on 15/7/31.
//  Copyright (c) 2015年 Teambition. All rights reserved.
//

#import "TBAPIChainManagerAgent.h"
#import "TBAPIChainManager.h"

@interface TBAPIChainManagerAgent()

@property (nonatomic, strong) NSMutableArray *chainManagerArray;

@end

@implementation TBAPIChainManagerAgent

+ (TBAPIChainManagerAgent *)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _chainManagerArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addChainManager:(TBAPIChainManager *)manager {
    @synchronized(self) {
        [_chainManagerArray addObject:manager];
    }
}

- (void)removeChainManager:(TBAPIChainManager *)manager {
    @synchronized(self) {
        [_chainManagerArray removeObject:manager];
    }
}

@end
