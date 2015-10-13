//
//  ValidatorTests.m
//  TBNetworking
//
//  Created by ChenHao on 8/3/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "TBValidatorPredicate.h"
#import "TBJSONValidator.h"

@interface ValidatorTests : XCTestCase

@end

@implementation ValidatorTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testArray {

    NSArray *json = @[@{@"name":@"chenhao",
                        @"age":@12,
                        @"phone":@"18883359755"
                        },
                      @{@"name":@"fff",
                        @"age":@12,
                        @"phone":@"18883359755"
                        }
                      ];
    
    
    NSDictionary *requirement = @{@"*":[TBValidatorPredicate.isArray valuesWithRequirements:
                                   @{@"name":TBValidatorPredicate.isNotNull}]
                                  };
    
    NSError *error = nil;
    BOOL result = [TBJSONValidator validateValue:json withRequirements:requirement error:&error];
    XCTAssert(result);
    
    if (error) {
        NSLog(@"%@",error);
    }

}

- (void)testDictionary {
    NSError *error;
    NSDictionary *json = @{
                           @"ssn" : [NSNull null],
                           @"children" : @[],
                           @"friends" : @[
                                   @{@"name" : @"Anna",
                                     @"age"  : @25},
                                   @{@"name" : @"Maria",
                                     @"age"  : @19},
                                   @{@"name" : @"WrongObject",
                                     @"counry" : @"UA",
                                     @"age":@12}]
                           };
    
    
    BOOL result = [TBJSONValidator validateValue:json withRequirements:@{
                                                           @"ssn" : TBValidatorPredicate.isNull,
                                                           @"children" : TBValidatorPredicate.isArray,
                                                           @"friends" : [TBValidatorPredicate.isArray valuesWithRequirements:
                                                                         @{@"age"  : TBValidatorPredicate.isNumber}
                                                                         ]
                                                           }
                             error:&error];
    
    if (error) {
        NSLog(@"%@",error);
    }
    XCTAssert(result);
 
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
