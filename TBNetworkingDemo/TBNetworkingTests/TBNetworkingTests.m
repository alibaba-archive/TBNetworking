//
//  TBNetworkingTests.m
//  TBNetworkingTests
//
//  Created by DangGu on 15/7/29.
//  Copyright (c) 2015年 Teambition. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface TBNetworkingTests : XCTestCase

@end

@implementation TBNetworkingTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
<<<<<<< Updated upstream
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
=======
  
    MobilePhoneAPIManager *manager = [[MobilePhoneAPIManager alloc] init];
    manager.delegate = self;
    [manager start];
//    [self waitForExpectationsWithTimeout:5 handler:nil];
>>>>>>> Stashed changes
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
