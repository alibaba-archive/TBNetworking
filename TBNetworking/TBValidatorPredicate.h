//
//  TBValidatorPredicate.h
//  TBNetworking
//
//  Created by ChenHao on 8/3/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import <Foundation/Foundation.h>


@class TBValidatorPredicate;

typedef BOOL (^ValidatorBlock)(NSString *jsonKey, id jsonValue);

@interface TBValidatorPredicate : NSObject

// validate type
+ (instancetype)isOptional;
+ (instancetype)isNotNull;
+ (instancetype)isNull;
+ (instancetype)isNumber;
+ (instancetype)isArray;
+ (instancetype)isBoolean;
+ (instancetype)isDictionary;
+ (instancetype)valuesWithRequirements:(NSDictionary *)requirements;


- (instancetype)valuesWithRequirements:(NSDictionary *)requirements;

@end
