//
//  MobilePhoneAPIManager.m
//  TBNetworking
//
//  Created by ChenHao on 7/31/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import "MobilePhoneAPIManager.h"

@implementation MobilePhoneAPIManager


- (NSString *)requestUrl {
    return @"mobilephoneservice/mobilephone";
}

- (NSDictionary *)parameters {

    return @{@"tel":@"18883359755"};
}

- (NSDictionary *)typeJsonValidator {
    return @{
             @"errMsg":[NSString class],
             @"reData":@{
                     @"carrier":[NSString class],
                     @"province":[NSString class],
                     @"telString":[NSString class],
                     },
             @"errNum":[MobilePhoneAPIManager class]
             };
}
@end
