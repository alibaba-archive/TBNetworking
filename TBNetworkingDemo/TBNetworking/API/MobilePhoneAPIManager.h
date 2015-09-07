//
//  MobilePhoneAPIManager.h
//  TBNetworking
//
//  Created by ChenHao on 7/31/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import "TBAPIManager.h"

@interface MobilePhoneAPIManager : TBAPIManager <TBAPIManager>

- (NSString *)getPhoneNumber;

@end
