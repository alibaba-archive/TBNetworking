//
//  TBAPIUploadManager.h
//  TBNetworking
//
//  Created by ChenHao on 9/8/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import "TBAPIBaseManager.h"

@interface TBAPIUploadManager : TBAPIBaseManager

- (instancetype)initWithUploadData:(NSData *)data;

- (instancetype)initWithUploadFile:(NSURL *)url;

@end
