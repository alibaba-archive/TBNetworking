//
//  TBChainManager.m
//  TBNetworking
//
//  Created by DangGu on 15/7/31.
//  Copyright (c) 2015年 Teambition. All rights reserved.
//

#import "TBChainManager.h"
#import "TBChainManagerAgent.h"
#import "TBLogger.h"
#import "TBAPIBaseManager.h"

@interface TBChainManager()<TBAPIBaseManagerDelegate>

@property (nonatomic, strong) NSMutableArray *apiManagerArray;
@property (nonatomic, assign) NSUInteger nextManagerIndex;

@end

@implementation TBChainManager

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
        TBLog(@"This chain manager has started");
        return;
    }
    if ([_apiManagerArray count] > 0) {
        [self startNextManager];
        [[TBChainManagerAgent sharedInstance] addChainManager:self];
    } else {
        TBLog(@"apiManagerArray is empty");
    }
}

- (void)stop {
    [self clearAllManager];
    [[TBChainManagerAgent sharedInstance] removeChainManager:self];
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

#pragma mark - getters and setters

- (NSMutableArray *)apiManagerArray {
    return _apiManagerArray;
}

@end
