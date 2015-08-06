//
//  TBValidator.h
//  TBNetworking
//
//  Created by ChenHao on 7/31/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TBValidatorPredicate;

#define TBJSONValidatorErrorDomain @"TBJSONValidatorErrorDomain"
#define TBJSONValidatorFailingKeys @"TBJSONValidatorFailingKeys"
#define TBJSONValidatorErrorBadRequirementsParameter 0
#define TBJSONValidatorErrorBadJSONParameter 1
#define TBJSONValidatorErrorInvalidJSON 2

@interface TBJSONValidator : NSObject

+ (BOOL)validateValue:(id)json
      withRequirements:(NSDictionary *)requirements
                error:(NSError **)error;

@end
