//
//  ViewController.m
//  TBNetworking
//
//  Created by DangGu on 15/7/29.
//  Copyright (c) 2015年 Teambition. All rights reserved.
//

#import "ViewController.h"
#import "StateAPIRequest.h"

@interface ViewController ()<TBAPIBaseRequestDelegate>

@property (nonatomic, strong) StateAPIRequest *stateRequest;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    for (int i = 0; i<100; i++) {
        
    }
    //[self.siteManager start];
    [self.stateRequest start];
    
}

- (void)requestAPIDidSuccess:(TBAPIBaseRequest *)request {

}



#pragma makr gettter

- (StateAPIRequest *)stateRequest {

    if (!_stateRequest) {
        _stateRequest = [[StateAPIRequest alloc] init];
        _stateRequest.delegate = self;
    }
    return _stateRequest;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
