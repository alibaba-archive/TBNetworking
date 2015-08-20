//
//  MobilePhoneAPIManager.h
//  TBNetworking
//
//  Created by ChenHao on 7/31/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import "APIBaseManager.h"
#import "TBNetworking.h"

@interface MobilePhoneAPIManager : APIBaseManager <TBAPIManager>

- (NSString *)getPhoneNumber;

@end
