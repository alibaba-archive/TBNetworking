//
//  TBAPIBatchAgent.m
//  TBNetworking
//
//  Created by ChenHao on 7/31/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import "TBAPIBatchManagerAgent.h"

@interface TBAPIBatchManagerAgent()

@property (strong, nonatomic) NSMutableArray *requestArray;

@end

@implementation TBAPIBatchManagerAgent

+ (TBAPIBatchManagerAgent *)sharedInstance {

    static TBAPIBatchManagerAgent *sharedInstace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstace = [[TBAPIBatchManagerAgent alloc] init];
    });
    return sharedInstace;
}

- (instancetype)init {

    self = [super init];
    if (self) {
        _requestArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addBatchManager:(TBAPIBatchManager *)manager {
    @synchronized(self) {
        [_requestArray addObject:manager];
    }
}

- (void)removeBatchManager:(TBAPIBatchManager *)manager {
    @synchronized(self) {
        [_requestArray removeObject:manager];
    }
}

@end
