//
//  TBAPIBatchAgent.m
//  TBNetworking
//
//  Created by ChenHao on 7/31/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import "TBAPIBatchAgent.h"

@interface TBAPIBatchAgent()

@property (strong, nonatomic) NSMutableArray *requestArray;

@end

@implementation TBAPIBatchAgent

+ (TBAPIBatchAgent *)sharedInstance {

    static TBAPIBatchAgent *sharedInstace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstace = [[TBAPIBatchAgent alloc] init];
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
