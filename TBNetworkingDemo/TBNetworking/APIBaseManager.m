//
//  APIBaseManager.m
//  TBNetworking
//
//  Created by ChenHao on 8/20/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import "APIBaseManager.h"

@implementation APIBaseManager

- (NSString *)baseUrl {
    return @"http://apis.baidu.com/apistore/";
}

- (NSDictionary *)requestHeaderFieldValueDictionary {
    return @{@"apikey":@"97681d7f39cb64d8060460dc5032fa48"};
}

@end
