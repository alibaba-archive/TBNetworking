//
//  TBValidator.m
//  TBNetworking
//
//  Created by ChenHao on 7/31/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import "TBValidator.h"
#import "TBLogger.h"

@implementation TBValidator

+ (BOOL)checkJsonType:(id)json withValidator:(id)validator {

    if ([json isKindOfClass:[NSDictionary class]] && [validator isKindOfClass:[NSDictionary class]]) {
        NSDictionary *jsonDict = json;
        NSDictionary *validatorDict = validator;
        
        BOOL result = YES;
        NSEnumerator *enumerator = [validator keyEnumerator];
        NSString *key;
        while (key = [enumerator nextObject]) {
            id value = jsonDict[key];
            id format = validatorDict[key];
            
            //存在无效的验证key
            if (!value) {
                //break;
            }
            if ([value isKindOfClass:[NSDictionary class]] || [value isKindOfClass:[NSArray class]]) {
                result = [self checkJsonType:value withValidator:format];
                if (!result) {
                    break;
                }
            } else {
                if ([value isKindOfClass:format] == NO && value!=nil) {
                    result = NO;
                    TBLog(@"%@ is %@ not %@",key,format,[value class]);
                    break;
                }
            }
            
        }
        return result;
    }
    return YES;
}
@end
