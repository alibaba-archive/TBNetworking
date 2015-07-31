//
//  ViewController.m
//  TBNetworking
//
//  Created by DangGu on 15/7/29.
//  Copyright (c) 2015年 Teambition. All rights reserved.
//

#import "ViewController.h"
#import "MobilePhoneAPIManager.h"

@interface ViewController ()<TBAPIBaseManagerDelegate>

@property (nonatomic, strong) MobilePhoneAPIManager *mobileManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    for (int i = 0; i<100; i++) {
        
    }
    //[self.siteManager start];
    //[self.stateRequest start];
    [self.mobileManager start];
    
}

- (void)requestAPIDidSuccess:(TBAPIBaseManager *)request {
    
    if ([request isKindOfClass:[MobilePhoneAPIManager class]]) {
        
        NSLog(@"%@",[(MobilePhoneAPIManager *)request getPhoneNumber]);
    }
}



#pragma makr gettter

- (MobilePhoneAPIManager *)mobileManager {

    if (!_mobileManager) {
        _mobileManager = [[MobilePhoneAPIManager alloc] init];
        _mobileManager.delegate = self;
    }
    return _mobileManager;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
