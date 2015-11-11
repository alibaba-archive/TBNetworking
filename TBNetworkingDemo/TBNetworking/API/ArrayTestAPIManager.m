//
//  ArrayTestAPIManager.m
//  TBNetworking
//
//  Created by ChenHao on 10/26/15.
//  Copyright © 2015 Teambition. All rights reserved.
//

#import "ArrayTestAPIManager.h"

@implementation ArrayTestAPIManager

- (NSString *)requestUrl {
    return @"";
}

- (TBAPIRequestType)requestType {
    return TBAPIManagerRequestTypePOST;
}

- (NSDictionary *)parameters {
    return @{
             @"user": [NSNull null],
             @"user2": @[@"123", @"333"],
             @"userId": @[],
             };
}

@end
