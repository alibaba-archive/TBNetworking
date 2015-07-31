//
//  TBChainManagerAgent.m
//  TBNetworking
//
//  Created by DangGu on 15/7/31.
//  Copyright (c) 2015年 Teambition. All rights reserved.
//

#import "TBChainManagerAgent.h"
#import "TBChainManager.h"

@interface TBChainManagerAgent()

@property (nonatomic, strong) NSMutableArray *chainManagerArray;

@end

@implementation TBChainManagerAgent

+ (TBChainManagerAgent *)sharedInstance {
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

- (void)addChainManager:(TBChainManager *)manager {
    @synchronized(self) {
        [_chainManagerArray addObject:manager];
    }
}

- (void)removeChainManager:(TBChainManager *)manager {
    @synchronized(self) {
        [_chainManagerArray removeObject:manager];
    }
}

@end
