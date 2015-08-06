//
//  TBValidator.m
//  TBNetworking
//
//  Created by ChenHao on 7/31/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import "TBJSONValidator.h"
#import "TBValidatorPredicate.h"
#import "TBLogger.h"

@interface TBValidatorPredicate(Protected)
- (void)validateValue:(id)value withKey:(NSString *)key;
- (NSMutableArray *)failedRequirementDescriptions;
@end

@implementation TBJSONValidator

+ (BOOL)validateValue:(id)json
     withRequirements:(NSDictionary *)requirements
                error:(NSError **)error {

    
    if (!json) {
        if (error) {
            *error = [NSError errorWithDomain:TBJSONValidatorErrorDomain
                                         code:TBJSONValidatorErrorBadJSONParameter
                                     userInfo:@{
                                                NSLocalizedDescriptionKey : @"Nothing to validate",
                                                NSLocalizedFailureReasonErrorKey : @"json parameter is nil",
                                                NSLocalizedRecoverySuggestionErrorKey : @"pass in valid json"
                                                }];
        }
        return NO;
    }
    
    if (![json isKindOfClass:[NSDictionary class]] && ![json isKindOfClass:[NSArray class]]) {
        if(error) {
            *error = [NSError errorWithDomain:TBJSONValidatorErrorDomain
                                         code:TBJSONValidatorErrorBadJSONParameter
                                     userInfo:@{
                                                NSLocalizedDescriptionKey : @"Nothing to validate",
                                                NSLocalizedFailureReasonErrorKey : @"json parameter is not an NSArray or NSDictionary",
                                                NSLocalizedRecoverySuggestionErrorKey : @"pass in valid json"
                                                }];
        }
        return NO;
    }
    
    if(!requirements) {
        if(error) {
            *error = [NSError errorWithDomain:TBJSONValidatorErrorDomain
                                         code:TBJSONValidatorErrorBadJSONParameter
                                     userInfo:@{
                                                NSLocalizedDescriptionKey : @"Nothing to validate",
                                                NSLocalizedFailureReasonErrorKey : @"requirements parameter is nil",
                                                NSLocalizedRecoverySuggestionErrorKey : @"pass in valid requirements"
                                                }];
        }
        return NO;
    }
    
    if(![requirements isKindOfClass:[NSDictionary class]]) {
        if(error) {
            *error = [NSError errorWithDomain:TBJSONValidatorErrorDomain
                                         code:TBJSONValidatorErrorBadJSONParameter
                                     userInfo:@{
                                                NSLocalizedDescriptionKey : @"Nothing to validate",
                                                NSLocalizedFailureReasonErrorKey : @"requirements parameter is not an NSDictionary",
                                                NSLocalizedRecoverySuggestionErrorKey : @"pass in valid requirements"
                                                }];
        }
        return NO;
    }
    
    
    
    if ([json isKindOfClass:[NSArray class]] && [requirements objectForKey:@"*"]) {
        json = @{@"*":json};
    }
    
    return [self validateValue:json
              withRequirements:requirements
                         error:error
                      userInfo:[@{} mutableCopy]];
}

+ (BOOL)validateValue:(id)json
     withRequirements:(NSDictionary *)requirements
                error:(NSError **)error
             userInfo:(NSMutableDictionary *)userInfo{
    
    
    __block BOOL hasError = NO;
    [requirements enumerateKeysAndObjectsUsingBlock:^(id key, id requirementsValue, BOOL *stop) {
       
        id jsonValue;
        if ([json isKindOfClass:[NSArray class]] && [key isKindOfClass:[NSNumber class]] && [json count] > [key unsignedIntegerValue]) {
            jsonValue = [json objectAtIndex:[key unsignedIntegerValue]];
        } else if([json isKindOfClass:[NSDictionary class]]) {
            jsonValue = [json objectForKey:key];
        } else {
            jsonValue = nil;
        }
        
        if ([requirementsValue isKindOfClass:[TBValidatorPredicate class]] && [key isKindOfClass:[NSString class]]) {
            
            [(TBValidatorPredicate *)requirementsValue validateValue:jsonValue withKey:key];
   
            if ([[(TBValidatorPredicate *)requirementsValue failedRequirementDescriptions] count]) {
                NSMutableDictionary *failingKeys = [userInfo objectForKey:TBJSONValidatorFailingKeys];
                
                if (failingKeys) {
                    failingKeys = [failingKeys mutableCopy];
                } else {
                    failingKeys = [NSMutableDictionary dictionary];
                }
                [failingKeys setObject:[(TBValidatorPredicate *)requirementsValue failedRequirementDescriptions] forKey:key];
                [userInfo setObject:failingKeys forKey:TBJSONValidatorFailingKeys];
            }
            
        } else if([requirementsValue isKindOfClass:[NSDictionary class]]) {
            [self validateValue:jsonValue
               withRequirements:requirementsValue
                          error:error
                       userInfo:userInfo];
        } else {
            
            hasError = YES;
            if (error) {
                *error = [NSError errorWithDomain:TBJSONValidatorErrorDomain
                                             code:TBJSONValidatorErrorBadJSONParameter
                                          userInfo:@{
                                                    NSLocalizedDescriptionKey : @"Requirements not setup correctly",
                                                    NSLocalizedFailureReasonErrorKey : [NSString stringWithFormat:@"Requirements key (%@) with value (%@) is not an RPValidatorPredicate or NSDictionary", key, requirementsValue],
                                                    NSLocalizedRecoverySuggestionErrorKey : @"Review requirements syntax"
                                                    }];
            }
            
            *stop = YES;
        }
        
    }];
    
    if (hasError) {
        return NO;
    }
    if([[userInfo allKeys] count]) {
        if (error) {
            [userInfo setObject:@"JSON did not validate" forKey:NSLocalizedDescriptionKey];
            [userInfo setObject:@"At least one requirement wasn't met" forKey:NSLocalizedFailureReasonErrorKey];
            [userInfo setObject:@"Perhaps use backup JSON" forKey:NSLocalizedRecoverySuggestionErrorKey];
            *error = [NSError errorWithDomain:TBJSONValidatorErrorDomain code:TBJSONValidatorErrorInvalidJSON userInfo:userInfo];
        }
        return NO;
    }
    return YES;
}

@end
