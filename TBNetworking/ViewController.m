//
//  ViewController.m
//  TBNetworking
//
//  Created by DangGu on 15/7/29.
//  Copyright (c) 2015年 Teambition. All rights reserved.
//

#import "ViewController.h"
#import "SiteAPIManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    SiteAPIManager *api = [[SiteAPIManager alloc] init];
    api.delegate = api;
    [api loadData];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
