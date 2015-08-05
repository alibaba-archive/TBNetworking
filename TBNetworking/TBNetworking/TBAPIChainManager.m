//
//  TBChainManager.m
//  TBNetworking
//
//  Created by DangGu on 15/7/31.
//  Copyright (c) 2015年 Teambition. All rights reserved.
//

#import "TBAPIChainManager.h"
#import "TBAPIBaseManager.h"

@interface TBAPIChainManager()<TBAPIBaseManagerDelegate>

@property (nonatomic, strong) NSMutableArray *apiManagerArray;
@property (nonatomic, assign) NSUInteger nextManagerIndex;

@end

@implementation TBAPIChainManager

- (instancetype)init {
    self = [super init];
    if (self) {
        _apiManagerArray = [[NSMutableArray alloc] init];
        _nextManagerIndex = 0;
    }
    return self;
}

- (void)start {
    if (_nextManagerIndex > 0) {
        return;
    }
    if ([_apiManagerArray count] > 0) {
        [self startNextManager];
        [[TBAPIChainManagerAgent sharedInstance] addChainManager:self];
    } else {
        
    }
}

- (void)stop {
    [self clearAllManager];
    [[TBAPIChainManagerAgent sharedInstance] removeChainManager:self];
}

- (BOOL)startNextManager {
    if (_nextManagerIndex < [_apiManagerArray count]) {
        TBAPIBaseManager *manager = _apiManagerArray[_nextManagerIndex];
        [manager start];
        [manager setDelegate:self];
        _nextManagerIndex++;
        return YES;
    } else {
        return NO;
    }
}

- (void)clearAllManager {
    NSUInteger currentManagerIndex = _nextManagerIndex - 1;
    if (currentManagerIndex < [_apiManagerArray count]) {
        TBAPIBaseManager *manager = _apiManagerArray[currentManagerIndex];
        [manager stop];
        [manager setDelegate:nil];
    }
    [_apiManagerArray removeAllObjects];
}

- (void)addManager:(TBAPIBaseManager *)manager {
    [_apiManagerArray addObject:manager];
}


#pragma mark - TBAPIBaseManagerDelegate

- (void)apiRequestDidSuccess:(TBAPIBaseManager *)manager {
    NSUInteger currentManagerIndex = _nextManagerIndex - 1;
    if (currentManagerIndex < [_apiManagerArray count]) {
        if ([_delegate respondsToSelector:@selector(chainSingleManagerDidSuccess:)]) {
            [_delegate chainSingleManagerDidSuccess:manager];
        }
    }
    if (![self startNextManager]) {
        if ([_delegate respondsToSelector:@selector(chainAllManagerDidSuccess:)]) {
            [_delegate chainAllManagerDidSuccess:self];
        }
        [[TBAPIChainManagerAgent sharedInstance] removeChainManager:self];
    }
}

- (void)apiRequestDidFailed:(TBAPIBaseManager *)manager {
    if ([_delegate respondsToSelector:@selector(chainAllManagerDidFailed:failedBaseManager:)]) {
        [_delegate chainAllManagerDidFailed:self failedBaseManager:manager];
    }
    [[TBAPIChainManagerAgent sharedInstance] removeChainManager:self];
    [_apiManagerArray removeAllObjects];
}

#pragma mark - getters and setters

- (NSMutableArray *)apiManagerArray {
    return _apiManagerArray;
}

@end
