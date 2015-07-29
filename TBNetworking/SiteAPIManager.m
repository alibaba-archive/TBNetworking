//
//  SiteAPIManager.m
//  TBNetworking
//
//  Created by ChenHao on 7/29/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import "SiteAPIManager.h"

@implementation SiteAPIManager

- (NSString *)requestUrl {
    return @"site/info.json";
}

- (TBAPIManagerRequestType )requestType {
    return TBAPIManagerRequestTypeGET;
}

- (void)manager:(TBAPIBaseManager *)manager willPerformSuccessResponse:(TBURLResponse *)response {

    
}

- (NSDictionary *)reformParameters:(NSDictionary *)parameters {
    
    
    return nil;
}

@end
