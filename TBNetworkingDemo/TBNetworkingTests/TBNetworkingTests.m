//
//  TBNetworkingTests.m
//  TBNetworkingTests
//
//  Created by DangGu on 15/7/29.
//  Copyright (c) 2015年 Teambition. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OHHTTPStubs.h>
#import "MobilePhoneAPIManager.h"
#import "IDCardNumberAPIManager.h"
#import <Nocilla.h>

@interface TBNetworkingTests : XCTestCase<TBAPIBaseManagerDelegate>

@end

@implementation TBNetworkingTests

- (void)setUp {
    [super setUp];
//    
//    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
//        return [request.URL.absoluteString isEqualToString:@"http://www.api.com/mobilephoneservice/mobilephone?tel=18679211201"];
//    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
//        // Stub it with our "wsresponse.json" stub file (which is in same bundle as self)
//        //        return [[OHHTTPStubsResponse responseWithJSONObject:@"{}" statusCode:200 headers:nil] responseTime:3.0];
//        return [OHHTTPStubsResponse responseWithJSONObject:@"{}" statusCode:200 headers:@{@"Content-Type":@"application/json"}];
//    }];
//    
//    
//    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
//        return [request.URL.absoluteString isEqualToString:@"http://www.api.com/idservice/id"];
//    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
//        // Stub it with our "wsresponse.json" stub file (which is in same bundle as self)
//        //        return [[OHHTTPStubsResponse responseWithJSONObject:@"{}" statusCode:200 headers:nil] responseTime:3.0];
//        return [OHHTTPStubsResponse responseWithJSONObject:@"{}" statusCode:200 headers:@{@"Content-Type":@"application/json"}];
//    }];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testExample {
  
    MobilePhoneAPIManager *manager = [[MobilePhoneAPIManager alloc] init];
    manager.delegate = self;
    [manager start];
}

- (void)testIDCard {

    IDCardNumberAPIManager *card = [[IDCardNumberAPIManager alloc] init];
    card.delegate = self;
    [card start];
    
}

- (void)testUpload {

    
}

- (void)apiRequestDidFailed:(TBAPIBaseManager *)manager {

    NSLog(@"%@",manager.response.error);
}

- (void)apiRequestDidSuccess:(TBAPIBaseManager *)manager {

    
}

@end
