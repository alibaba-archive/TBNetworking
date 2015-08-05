//
//  ViewController.m
//  TBNetworking
//
//  Created by DangGu on 15/7/29.
//  Copyright (c) 2015年 Teambition. All rights reserved.
//

#import "ViewController.h"
#import "MobilePhoneAPIManager.h"
#import "IDCardNumberAPIManager.h"
#import "TBAPIChainManager.h"

@interface ViewController ()<TBAPIBaseManagerDelegate,TBAPIChainManagerDelegate>

@property (nonatomic, strong) MobilePhoneAPIManager *mobileManager;
@property (nonatomic, strong) IDCardNumberAPIManager *idCardNumberManager;
@property (nonatomic, strong) TBAPIChainManager     *chainManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    for (int i = 0; i<100; i++) {
        
    }
//    [self.mobileManager start];
//    [self.idCardNumberManager start];
    [self.chainManager start];
    
}

- (void)apiRequestDidSuccess:(TBAPIBaseManager *)request {
    
    if ([request isKindOfClass:[MobilePhoneAPIManager class]]) {
        NSLog(@"%@",[(MobilePhoneAPIManager *)request getPhoneNumber]);
    }
}



#pragma mark - gettter

- (MobilePhoneAPIManager *)mobileManager {

    if (!_mobileManager) {
        _mobileManager = [[MobilePhoneAPIManager alloc] init];
        _mobileManager.delegate = self;
    }
    return _mobileManager;
}

- (IDCardNumberAPIManager *)idCardNumberManager {
    if (!_idCardNumberManager) {
        _idCardNumberManager = [[IDCardNumberAPIManager alloc] init];
        _idCardNumberManager.delegate = self;
    }
    return _idCardNumberManager;
}

- (TBAPIChainManager *)chainManager {
    if (!_chainManager) {
        _chainManager = [[TBAPIChainManager alloc] init];
        _chainManager.delegate = self;
        [_chainManager addManager:self.mobileManager];
        [_chainManager addManager:self.idCardNumberManager];
    }
    return _chainManager;
}

#pragma mark - TBAPIChainManagerDelegate
- (void)chainSingleManagerDidSuccess:(TBAPIBaseManager *)manager {
    if ([manager isKindOfClass:[MobilePhoneAPIManager class]]) {
        NSLog(@"moble manager finished");
    }
    if ([manager isKindOfClass:[IDCardNumberAPIManager class]]) {
        NSLog(@"idcardnumber manager finished");
    }
}
- (void)chainAllManagerDidSuccess:(TBAPIChainManager *)chainManager{
    NSLog(@"chain all finished");
}
- (void)chainAllManagerDidFailed:(TBAPIChainManager *)chainManager failedBaseManager:(TBAPIBaseManager *)manager {
    NSLog(@"chain all failed");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
