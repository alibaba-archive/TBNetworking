//
//  TBAPIBatchManager.m
//  TBNetworking
//
//  Created by ChenHao on 7/31/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import "TBAPIBatchManager.h"
#import "TBAPIManager.h"
#import "TBAPIBatchAgent.h"

@interface TBAPIBatchManager()<TBAPIBaseManagerDelegate>

@property (nonatomic, assign) NSInteger finishCount;

@end

@implementation TBAPIBatchManager

- (instancetype)initWithManagerArray:(NSArray *)managerArray {

    self = [super init];
    if (self) {
        _requestBachArray = managerArray;
        _finishCount = 0;
        
    }
    return self;
}

- (void)start {
    if (_finishCount!=0) {
        return;
    }
    [[TBAPIBatchAgent sharedInstance] addBatchManager:self];
    for (TBAPIManager *manager in _requestBachArray) {
        manager.delegate = self;
        [manager start];
    }
    
}

- (void)stop {
    _delegate = nil;
    for (TBAPIManager *manager in _requestBachArray) {
        manager.delegate = self;
        [manager stop];
    }
    [[TBAPIBatchAgent sharedInstance] removeBatchManager:self];
}


#pragma mark - TBAPIManager Delegate

- (void)requestAPIDidSuccess:(TBAPIBaseManager *)request {
    _finishCount++;
    if (_finishCount == _requestBachArray.count) {
        if (_delegate !=nil && [_delegate respondsToSelector:@selector(batchRequestAPIDidSuccess:)]) {
            [_delegate batchRequestAPIDidSuccess:self];
        }
    }
    
}

- (void)requestAPIDidFailed:(TBAPIBaseManager *)request {
    [self stop];
    
    if (_delegate !=nil && [_delegate respondsToSelector:@selector(batchRequestAPIDidFailed:)]) {
        [_delegate batchRequestAPIDidFailed:self];
    }
}

@end
