//
//  TBAPIBatchManager.m
//  TBNetworking
//
//  Created by ChenHao on 7/31/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import "TBAPIBatchManager.h"


@interface TBAPIBatchManager()<TBAPIBaseManagerDelegate>

@property (nonatomic, assign) NSInteger     finishCount;
@property (nonatomic, assign, readwrite)    NSInteger       successCount;
@property (nonatomic, assign, readwrite)    NSInteger       faildCount;
@property (nonatomic, strong, readwrite)    NSArray         *requestBachArray;
@property (nonatomic, strong, readwrite)    NSMutableArray  *successMutalArray;
@property (nonatomic, strong, readwrite)    NSMutableArray  *faildMutalArray;


@end

@implementation TBAPIBatchManager

- (instancetype)initWithManagerArray:(NSArray *)managerArray {

    self = [super init];
    if (self) {
        _requestBachArray = managerArray;
        _successMutalArray = [NSMutableArray new];
        _faildMutalArray = [NSMutableArray new];
        _finishCount = 0;
    }
    return self;
}

- (void)addManager:(TBAPIBaseManager *)manager {
    NSMutableArray *temp = [[NSMutableArray alloc] initWithArray:_requestBachArray];
    [temp addObject:manager];
    _requestBachArray = [temp copy];
}

- (void)start {
    if (_finishCount!=0) {
        return;
    }
    [[TBAPIBatchManagerAgent sharedInstance] addBatchManager:self];
    for (TBAPIBaseManager *manager in _requestBachArray) {
        manager.delegate = self;
        [manager start];
    }
    
}

- (void)stop {
    _delegate = nil;
    for (TBAPIBaseManager *manager in _requestBachArray) {
        manager.delegate = self;
        [manager stop];
    }
    [[TBAPIBatchManagerAgent sharedInstance] removeBatchManager:self];
}


#pragma mark - TBAPIManager Delegate

- (void)apiRequestDidSuccess:(TBAPIBaseManager *)request {
    
    _finishCount++;
    _successCount++;
    
    [_successMutalArray addObject:request];
    
    if (_delegate && [_delegate respondsToSelector:@selector(batchSubManagerDidSuccess:)]) {
        [_delegate batchSubManagerDidSuccess:request];
    }
    
    if (_finishCount == _requestBachArray.count) {
        if (_delegate && [_delegate respondsToSelector:@selector(batchManagerDidSuccess:)]) {
            [_delegate batchManagerDidSuccess:self];
        }
    }
    
    if (_finishCount == _requestBachArray.count) {
        if (_delegate && [_delegate respondsToSelector:@selector(batchManagerDidFinish:)]) {
            [_delegate batchManagerDidFinish:self];
        }
    }
}

- (void)apiRequestDidFailed:(TBAPIBaseManager *)request {
    //[self stop];
    
    _finishCount++;
    _faildCount++;
    [_faildMutalArray addObject:request];
    
    if (_delegate && [_delegate respondsToSelector:@selector(batchSubManagerDidFaild:)]) {
        [_delegate batchSubManagerDidFaild:request];
    }
 
    if (_delegate && [_delegate respondsToSelector:@selector(batchManagerDidFailed:)]) {
        [_delegate batchManagerDidFailed:self];
    }
    
    if (_finishCount == _requestBachArray.count) {
        if (_delegate && [_delegate respondsToSelector:@selector(batchManagerDidFinish:)]) {
            [_delegate batchManagerDidFinish:self];
        }
    }
}

- (NSArray *)successArray {
    return [_successMutalArray copy];
}

- (NSArray *)faildArray {
    return [_faildMutalArray copy];
}

@end
