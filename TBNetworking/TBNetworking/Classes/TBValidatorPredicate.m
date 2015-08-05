//
//  TBValidatorPredicate.m
//  TBNetworking
//
//  Created by ChenHao on 8/3/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import "TBValidatorPredicate.h"

@interface TBValidatorPredicate()
@property (nonatomic, strong) NSMutableArray *requirements; // An array of ValidatorBlocks
@property (nonatomic) BOOL optional;
@property (nonatomic, strong) NSMutableArray *failedRequirementDescriptions; // An array of descriptions for failures. ValidatorBlocks are supposed to populate them
@end

@interface TBValidatorPredicate(Protected)
- (void)validateValue:(id)value withKey:(NSString *)key;
- (NSMutableArray *)failedRequirementDescriptions;
@end

@implementation TBValidatorPredicate

- (instancetype)init {

    self = [super init];
    if (self) {
        self.requirements = [NSMutableArray array];
        self.failedRequirementDescriptions = [NSMutableArray array];
    }
    return self;
}

+ (instancetype)isOptional {
    TBValidatorPredicate *predicate = [self new];
    return [predicate isOptional];
}

+ (instancetype)isNotNull {
    TBValidatorPredicate *predicate = [self new];
    return [predicate isNotNull];
}

+ (instancetype)isNull {
    TBValidatorPredicate *predicate = [self new];
    return [predicate isNull];
}

+ (instancetype)isNumber {
    TBValidatorPredicate *predicate = [self new];
    return [predicate isNumber];
}

+ (instancetype)isBoolean {
    TBValidatorPredicate *predicate = [self new];
    return [predicate isBoolean];
}

+ (instancetype)isArray {
    TBValidatorPredicate *predicate = [self new];
    return [predicate isArray];
}

+ (instancetype)isDictionary {
    TBValidatorPredicate *predicate = [self new];
    return [predicate isDictionary];
}

+ (instancetype)valuesWithRequirements:(NSDictionary *)requirements {
    TBValidatorPredicate *predicate = [self new];
    return [predicate valuesWithRequirements:requirements];
}


#pragma mark instance method
- (instancetype)isOptional {
    self.optional = YES;
    return self;
}

- (instancetype)isNotNull {

    __weak typeof(self) ws = self;
    ValidatorBlock block = ^BOOL(NSString *jsonKey, id jsonValue) {
        if (![jsonValue isEqual:[NSNull null]]) {
            return YES;
        } else {
            [ws.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires non-null value, given (%@)", jsonValue]];
            return NO;
        }
    };
    
    [self.requirements addObject:block];
    return self;
}

- (instancetype)isNull {
    __weak typeof(self) ws = self;
    ValidatorBlock block = ^BOOL(NSString *jsonKey, id jsonValue) {
        if ([jsonValue isEqual:[NSNull null]]) {
            return YES;
        } else {
            [ws.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires null value, given (%@)", jsonValue]];
            return NO;
        }
    };
    
    [self.requirements addObject:block];
    return self;
    
}

- (instancetype)isArray {
    __weak typeof (self) weakSelf = self;
    ValidatorBlock block = ^BOOL(NSString *jsonKey, id jsonValue) {
        if([jsonValue isKindOfClass:[NSArray class]]) {
            return YES;
        } else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires NSArray, given (%@)", [jsonValue class]]];
            return NO;
        }
    };
    
    [self.requirements addObject:block];
    return self;
}

- (instancetype)isNumber {
    __weak typeof (self) weakSelf = self;
    ValidatorBlock block = ^BOOL(NSString *jsonKey, id jsonValue) {
        if([jsonValue isKindOfClass:[NSNumber class]]) {
            return YES;
        } else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires NSNumber, given (%@)", [jsonValue class]]];
            return NO;
        }
    };
    
    [self.requirements addObject:block];
    return self;
}

- (instancetype)isBoolean {
    __weak typeof (self) weakSelf = self;
    ValidatorBlock block = ^BOOL(NSString *jsonKey, id jsonValue) {
        if([jsonValue isKindOfClass:[NSNumber class]]) {
            return YES;
        } else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires NSboolean, given (%@)", [jsonValue class]]];
            return NO;
        }
    };
    
    [self.requirements addObject:block];
    return self;
}

- (instancetype)isDictionary {
    __weak typeof (self) weakSelf = self;
    ValidatorBlock block = ^BOOL(NSString *jsonKey, id jsonValue) {
        if([jsonValue isKindOfClass:[NSDictionary class]]) {
            return YES;
        } else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires NSDictionary, given (%@)", [jsonValue class]]];
            return NO;
        }
    };
    
    [self.requirements addObject:block];
    return self;
}

- (instancetype)valuesWithRequirements:(NSDictionary *)requirements {
    __weak typeof (self) weakSelf = self;
    ValidatorBlock block = ^BOOL(NSString *jsonKey, id jsonValue) {
        if ([jsonValue isKindOfClass:[NSArray class]]) {
            BOOL isValid = YES;
            
            for (id object in (NSArray *)jsonValue)
            {
                NSError *error = nil;
                
                ;
                
                if (![TBJSONValidator
                      validateValue:object
                      withRequirements:requirements
                      error:&error]) {
                    isValid = NO;
                    
                    id errorMessageObject = error.userInfo[TBJSONValidatorFailingKeys];
                    if (errorMessageObject != nil) {
                        [weakSelf.failedRequirementDescriptions addObject:error.userInfo[TBJSONValidatorFailingKeys]];
                    }
                }
            }
            
            return isValid;
        }
        else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires NSArray, given (%@)", [jsonValue class]]];
            return NO;
        }
    };
    
    [self.requirements addObject:block];
    
    return self;
}

#pragma mark protected


- (void)validateValue:(id)value
              withKey:(NSString *)key {
    if (value) {
        for (ValidatorBlock block in self.requirements) {
            block(key,value);
        }
    } else {
        if (!self.optional) {
            [self.failedRequirementDescriptions addObject:@"Key not found"];
        }
        
    }
}

@end
